//
//  StampMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

class StampMessage: ROSMessage {
    var secs: Int = 0
    var nsecs: NSNumber = 0
    
    func getDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self.secs))
    }
    
}
