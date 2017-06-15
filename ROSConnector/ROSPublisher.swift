//
//  ROSPublisher.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

class ROSPublisher: NSObject {
    var manager: ROSConnector?
    var topic: String = ""
    var messageType: String = ""
    var publisherId: String?
    var label: String = ""
    var isActive: Bool = false
    
    func publish(message: ROSMessage) {
        let messageData = message.publish()
        let data = NSMutableDictionary(objects: ["publish", message.publish(), self.topic], forKeys: ["op" as NSCopying, "msg" as NSCopying, "topic" as NSCopying])
        if let id = self.publisherId {
            data.setObject(id, forKey: "id" as NSCopying)
        }
        message.publishDate = Date()
        self.manager?.lastPublishedMessage = message
        self.manager?.sendData(data: data)
    }
    
    func advertise() {
        self.isActive = true
        let data = NSMutableDictionary(objects: ["advertise", self.messageType, self.topic], forKeys: ["op" as NSCopying, "type" as NSCopying, "topic" as NSCopying])
        if let id = self.publisherId {
            data.setObject(id, forKey: "id" as NSCopying)
        }
        self.manager?.sendData(data: data)
    }
    
    func unadvertise() {
        self.isActive = false
        let data = NSMutableDictionary(objects: ["unadvertise", self.topic], forKeys: ["op" as NSCopying, "topic" as NSCopying])
        if let id = self.publisherId {
            data.setObject(id, forKey: "id" as NSCopying)
        }
        self.manager?.sendData(data: data)
    }
    
}
