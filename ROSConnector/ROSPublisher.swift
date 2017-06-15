//
//  ROSPublisher.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class ROSPublisher: NSObject {
    public var manager: ROSConnector?
    public var topic: String = ""
    public var messageType: String = ""
    public var publisherId: String?
    public var label: String = ""
    public var isActive: Bool = false
    
    public func publish(message: ROSMessage) {
        let messageData = message.publish()
        let data = NSMutableDictionary(objects: ["publish", message.publish(), self.topic], forKeys: ["op" as NSCopying, "msg" as NSCopying, "topic" as NSCopying])
        if let id = self.publisherId {
            data.setObject(id, forKey: "id" as NSCopying)
        }
        message.publishDate = Date()
        self.manager?.lastPublishedMessage = message
        self.manager?.sendData(data: data)
    }
    
    public func advertise() {
        self.isActive = true
        let data = NSMutableDictionary(objects: ["advertise", self.messageType, self.topic], forKeys: ["op" as NSCopying, "type" as NSCopying, "topic" as NSCopying])
        if let id = self.publisherId {
            data.setObject(id, forKey: "id" as NSCopying)
        }
        self.manager?.sendData(data: data)
    }
    
    public func unadvertise() {
        self.isActive = false
        let data = NSMutableDictionary(objects: ["unadvertise", self.topic], forKeys: ["op" as NSCopying, "topic" as NSCopying])
        if let id = self.publisherId {
            data.setObject(id, forKey: "id" as NSCopying)
        }
        self.manager?.sendData(data: data)
    }
    
}
