//
//  HumidityMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

class HumidityMessage: ROSMessage {
    var header: HeaderMessage = HeaderMessage()
    var relativeHumidity: NSNumber = 0
    var variance: NSNumber = 0
    
    override func setDefaults() {
        self.header = HeaderMessage()
    }
}
