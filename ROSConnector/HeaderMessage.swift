//
//  HeaderMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

class HeaderMessage: ROSMessage {
    var frameId: String = ""
    var seq: NSNumber = 0
    var stamp: StampMessage = StampMessage()
    
    override func setDefaults() {
        self.stamp = StampMessage()
    }
}
