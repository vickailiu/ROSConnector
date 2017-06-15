//
//  ROSMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

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
        
        for key in messageData.allKeys {
            if let stringKey = key as? String {
                let value = messageData.object(forKey: stringKey)
                
                if let objectProperty = self.value(forKey: stringKey) as? ROSMessage {
                    objectProperty.process(messageData: value as! NSDictionary)
                }
                else {
                    self.setValue(value, forKey: stringKey)
                }
            }
        }
        self.load()
    }
    
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
            let property: objc_property_t = properties[Int(i)]!
            let name = String.init(utf8String: property_getName(property))
            rv.add(name!)
        }
        
        free(properties)
        return rv
    }
}


