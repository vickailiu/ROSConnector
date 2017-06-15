//
//  ROSConnector.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation
import SocketRocket

public protocol ROSConnectorDelegate: class {
    func managerDidConnect(manager: ROSConnector)
    func managerDidTimeout(manager: ROSConnector)
    func manager(manager: ROSConnector, didFailWithError: NSError)
    func manager(manager: ROSConnector, didCloseWithCode: Int, reason: String, wasClean: Bool)
}

public class ROSConnector: NSObject {
    var subscribers: NSMutableArray!
    var publishers: NSMutableArray!
    var queue: NSMutableArray!
    
    var host: String? = ""
    var socket: SRWebSocket?
    weak var delegate: ROSConnectorDelegate?
    
    var connected: Bool = false
    var timeoutTimer = Timer()
    var timeout: Int = 5
    
    var lastPublishedMessage: ROSMessage?
    var lastReceivedMessage: ROSMessage?
    var lastServiceCall: ROSServiceCall?
    
    private override init() {
        super.init()
        self.subscribers = NSMutableArray()
        self.publishers = NSMutableArray()
        self.queue = NSMutableArray()
        self.connected = false
    }
    
    static let sharedInstance = ROSConnector()
    
    func addSubscriber(topic: String, delegate: ROSSubscriberDelegate, messageClass: AnyClass) -> ROSSubscriber {
        let subscriber = ROSSubscriber()
        subscriber.manager = self
        subscriber.delegate = delegate
        subscriber.topic = topic
        subscriber.messageClass = messageClass
        subscriber.isActive = true
        self.subscribers.add(subscriber)
        return subscriber
    }
    
    func addPublisher(topic: String, messageType message: String) -> ROSPublisher {
        let publisher = ROSPublisher()
        publisher.manager = self
        publisher.topic = topic
        publisher.isActive = true
        publisher.messageType = message
        self.publishers.add(publisher)
        return publisher
    }
    
    func makeServiceCall(service: String, responseTarget serviceCallObject: NSObject, selector serviceSelector: Selector) -> ROSServiceCall {
        let serviceCall = ROSServiceCall()
        serviceCall.manager = self
        serviceCall.service = service
        serviceCall.serviceSelector = serviceSelector
        serviceCall.serviceObject = serviceCallObject
        return serviceCall
    }
    
    func setParam(name: String, value: AnyClass) -> ROSServiceCall {
        let serviceCall = ROSServiceCall()
        serviceCall.manager = self
        serviceCall.service = "/rosapi/set_param"
        serviceCall.args = NSArray(objects: name, value)
        return serviceCall
    }
    
    func getParam(name: String, responseTarget object: NSObject, selector responseSelector: Selector) -> ROSServiceCall {
        let serviceCall = ROSServiceCall()
        serviceCall.manager = self
        serviceCall.service = "/rosapi/get_param"
        serviceCall.serviceObject = object
        serviceCall.serviceSelector = responseSelector
        return serviceCall
    }
    
    
    func addExistingSubscriber(subscriber: ROSSubscriber) {
        subscriber.subscribe()
    }
    
    func addExistingPublisher(publisher: ROSPublisher) {
        publisher.advertise()
    }
    
    func removeSubscriber(subscriber: ROSSubscriber) {
        subscriber.unsubscribe()
    }
    
    func removePublisher(publisher: ROSPublisher) {
        publisher.unadvertise()
    }
    
    func connect(socketHost: String) {
        if (self.connected || (self.socket != nil)) {
            print("Socket already open")
        }
        else {
            print("connecting  --  \(socketHost)")
        }
        
        self.timeoutTimer = Timer(timeInterval: TimeInterval(self.timeout), target: self, selector: #selector(didTimeout), userInfo: nil, repeats: false)
        
        self.host = socketHost
        let request = URLRequest(url: URL(string: socketHost)!)
        self.socket = SRWebSocket(urlRequest: request)
        self.socket?.delegate = self
        self.socket?.open()
    }
    
    func didTimeout() {
        print("timeout")
        
        self.connected = false
        self.socket = nil
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "rbmanager/timeout"), object: nil)
        self.delegate?.managerDidTimeout(manager: self)
    }
    
    func disconnect() {
        self.socket?.close()
    }
    
    func sendData(data: NSDictionary) {
        print("sending   ---    \(data)")
        //let jsonError: NSError? = nil
        do {
            let jsonDictionary: NSData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions(rawValue: 0)) as NSData
            self.socket?.send(jsonDictionary)
        }
        catch {
            print("json error")
        }
    }
    
    func postSubscriberData(data: NSDictionary) {
        let msg = data.object(forKey: "msg") as? NSDictionary
        let topic = data.object(forKey: "topic") as? String
        
        for item in self.subscribers {
            if let subscriber = item as? ROSSubscriber {
                if subscriber.topic == topic {
                    if let cls = subscriber.messageClass as? ROSMessage.Type {
                        let message = cls.init()
                        message.process(messageData: msg!)
                        subscriber.delegate?.messageRecieved(message: message)
                        /*if (subscriber.subscriberObject?.responds(to: #selector(getter: subscriber.subscriberSelector)))! {
                            subscriber.subscriberObject?.performSelector(onMainThread: subscriber.subscriberSelector!, with: message, waitUntilDone: true)
                        }*/
                    }
                }
            }
        }
    }
    
    func postServiceCallResponse(data: NSDictionary) {
        if let call = self.lastServiceCall {
            call.recieve(data: data)
            if (call.serviceObject?.responds(to: call.serviceSelector))! {
                call.serviceObject?.performSelector(onMainThread: call.serviceSelector!, with: call, waitUntilDone: true)
            }
        }
    }
    
    func advertisePublishers() {
        for item in self.publishers {
            if let publisher = item as? ROSPublisher {
                if publisher.isActive {
                    publisher.advertise()
                }
            }
        }
    }
    
    func attachSubscribers() {
        for item in self.subscribers {
            if let subscriber = item as? ROSSubscriber {
                if subscriber.isActive {
                    subscriber.subscribe()
                }
            }
        }
    }

}

extension ROSConnector: SRWebSocketDelegate {
    public func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!) {
        print("recieved \(message)")
        
        //let error: NSError? = nil
        
        if let stringMessage = message as? String {
            let data = stringMessage.data(using: .utf8)
            do {
                let response = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! NSDictionary
                let op = response.object(forKey: "op") as? String
                if op == "publish" {
                    self.postSubscriberData(data: response)
                }
                else if op == "service_response" {
                    self.postServiceCallResponse(data: response)
                }
            }
            catch {
                print("json error")
            }
        }
    }

    public func webSocket(_ webSocket: SRWebSocket!, didCloseWithCode code: Int, reason: String!, wasClean: Bool) {
        print("socket closed -- \(webSocket.url.description) -- Code \(code) -- Reason == \(reason)")
        self.connected = false
        self.socket = nil
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "rbmanager/disconnected"), object: nil)
        self.delegate?.manager(manager: self, didCloseWithCode: code, reason: reason, wasClean: wasClean)
    }

    public func webSocket(_ webSocket: SRWebSocket!, didFailWithError error: Error!) {
        print("Socket failed -- \(webSocket.url.description) -- \(error.localizedDescription)")
        self.connected = false
        self.socket = nil
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "rbmanager/disconnected"), object: nil)
        self.delegate?.manager(manager: self, didFailWithError: error as NSError)
    }

    public func webSocketDidOpen(_ webSocket: SRWebSocket!) {
        print("Socket open -- \(webSocket.url.description)")
        self.timeoutTimer.invalidate()
        self.connected = true
        self.advertisePublishers()
        self.attachSubscribers()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "rbmanager/connected"), object: nil)
        self.delegate?.managerDidConnect(manager: self)
    }
    
}
