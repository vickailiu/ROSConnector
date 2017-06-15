//
//  StampMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class StampMessage: ROSMessage {
    public var secs: Int = 0
    public var nsecs: NSNumber = 0
    
    public func getDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self.secs))
    }
    
}
