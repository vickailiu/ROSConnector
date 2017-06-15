//
//  HeaderMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class HeaderMessage: ROSMessage {
    public var frameId: String = ""
    public var seq: NSNumber = 0
    public var stamp: StampMessage = StampMessage()
    
    override public func setDefaults() {
        self.stamp = StampMessage()
    }
}
