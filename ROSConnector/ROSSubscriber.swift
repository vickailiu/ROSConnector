//
//  ROSSubscriber.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public protocol ROSSubscriberDelegate: class {
    func messageRecieved(message: ROSMessage)
}

public class ROSSubscriber: NSObject {
    public var manager: ROSConnector?
    public var messageClass: Any?
    public var topic: String = ""
    public var messageType: String?
    public var subscriberId: String?
    
    public var isActive: Bool = false
    
    public weak var delegate: ROSSubscriberDelegate?
    
    // extra parameters
    public var topicType: String = ""
    public var throttleRate: Int?
    public var queueLength: Int?
    public var fragmentSize: Int?
    public var compression: String?
    public var label: String = ""
    
    public func subscribe() {
        self.isActive = true
        let data = NSMutableDictionary(objects: ["subscribe", self.topic], forKeys: ["op" as NSCopying, "topic" as NSCopying])
        if let type = self.messageType {
            data.setObject(type, forKey: "type" as NSCopying)
        }
        if let subscriberId = self.subscriberId {
            data.setObject(subscriberId, forKey: "id" as NSCopying)
        }
        if let throttleRate = self.throttleRate {
            data.setObject(throttleRate, forKey: "throttle_rate" as NSCopying)
        }
        if let queueLength = self.queueLength {
            data.setObject(queueLength, forKey: "queue_length" as NSCopying)
        }
        if let fragmentSize = self.fragmentSize {
            data.setObject(fragmentSize, forKey: "fragment_size" as NSCopying)
        }
        if let compression = self.compression {
            data.setObject(compression, forKey: "compression" as NSCopying)
        }
        self.manager?.sendData(data: data)
    }
    
    public func unsubscribe() {
        self.isActive = false
        let data = NSMutableDictionary(objects: ["unsubscribe", self.topic], forKeys: ["op" as NSCopying, "topic" as NSCopying])
        if let subscriberId = self.subscriberId {
            data.setObject(subscriberId, forKey: "id" as NSCopying)
        }
        self.manager?.sendData(data: data)
    }
}
