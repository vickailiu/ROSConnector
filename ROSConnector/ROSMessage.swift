//
//  ROSMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

@objcMembers
public class ROSMessage: NSObject {
    public var publishDate: Date?
    
    required override public init() {
        super.init()
        self.setDefaults()
    }
    
    public func setDefaults() {
        // assign default values to certain properties
    }
    
    public func load() {
        // override when the message is populated
    }
    
    public func process(messageData: NSDictionary) {
        self.publishDate = Date()
        
        let propertyList = Mirror(reflecting: self).children.flatMap { $0.label }
        
        for key in messageData.allKeys {
            if let stringKey = key as? String {
                if propertyList.index(of: stringKey) == nil { continue }

                let value = messageData.object(forKey: stringKey)

                if let objectProperty = self.value(forKey: stringKey) as? ROSMessage {
                    objectProperty.process(messageData: value as! NSDictionary)
                }
                else if let objectArray = value as? [NSDictionary] {
                    for element in objectArray {
                        var messageElement = self.value(forKey: "temp") as? ROSMessage
                        messageElement?.process(messageData: element as NSDictionary)
                        self.pushToArray(data: messageElement!)
                    }
                }
                else {
                    self.setValue(value, forKey: stringKey)
                }
            }
        }
        
//        var checkForKey = true
//        for (key, _) in messageData {
//            //guard checkForKey == true else { return }
//            if let stringKey = key as? String {
//                let value = messageData.object(forKey: stringKey)
//
//                if let objectProperty = self.value(forKey: stringKey) as? ROSMessage {
//                    objectProperty.process(messageData: value as! NSDictionary)
//                }
//                else if let objectArray = value as? [NSDictionary] {
//                    for element in objectArray {
//                        var messageElement = self.value(forKey: "temp") as? ROSMessage
//                        messageElement?.process(messageData: element as NSDictionary)
//                        self.pushToArray(data: messageElement!)
//                    }
//                }
//                else {
//                    self.setValue(value, forKey: stringKey)
//                }
//            }
//            //checkForKey = false
//        }
        self.load()
    }
    
    public func pushToArray(data: ROSMessage) {}
    
    public func publish() -> NSDictionary {
        let data = NSMutableDictionary()
        let properties = self.propertyKeys()
        for key in properties {
            let object = self.value(forKey: key as! String)
            if let objectAsMessage = object as? ROSMessage {
                data.setObject(objectAsMessage.publish(), forKey: key as! NSString)
            }
            else if object != nil {
                data.setObject(object!, forKey: key as! NSString)
            }
        }
        return data
    }
    
    public func propertyKeys() -> NSArray {
        var count: UInt32 = 0
        let properties = class_copyPropertyList(self.classForCoder, &count)!
        
        let rv = NSMutableArray()
        
        for i in 0..<count {
            let property: objc_property_t = properties[Int(i)]
            let name = String.init(utf8String: property_getName(property))
            rv.add(name!)
        }
        
        free(properties)
        return rv
    }
}


