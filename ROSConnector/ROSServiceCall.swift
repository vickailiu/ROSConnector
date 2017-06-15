//
//  ROSServiceCall.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class ROSServiceCall: NSObject {
    public var manager: ROSConnector?
    public var service: String = ""
    public var serviceId: String?
    public var args: AnyObject?
    public var fragmentSize: Int?
    public var compression: String?
    public var response: NSDictionary? = NSDictionary()
    public var result: Bool? = false
    
    public var serviceSelector: Selector?
    public var serviceObject: NSObject?
    public var messageClass: AnyClass?
    
    public var label: String = ""
    
    public func send() {
        let data = NSMutableDictionary(objects: ["call_service", self.service], forKeys: ["op" as NSCopying, "service" as NSCopying])
        if let id = self.serviceId {
            data.setObject(id, forKey: "id" as NSCopying)
        }
        if let args = self.args {
            data.setObject(args, forKey: "args" as NSCopying)
        }
        if let compression = self.compression {
            data.setObject(compression, forKey: "compression" as NSCopying)
        }
        if let fragmentSize = self.fragmentSize {
            data.setObject(fragmentSize, forKey: "fragment_size" as NSCopying)
        }
        self.manager?.lastServiceCall = self
        self.manager?.sendData(data: data)
    }
    
    public func recieve(data: AnyObject) {
        self.result = data.object(forKey: "result") as? Bool
        self.response = data.object(forKey: "values") as? NSDictionary
    }
    
    public func setMessage(message: ROSMessage) {
        self.args = message.publish()
    }
    
}
