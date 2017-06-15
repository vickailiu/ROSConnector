//
//  PoseMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

class PoseMessage: ROSMessage {
    var x: Double = 0
    var y: Double = 0
    var theta: Double = 0
    var linearVelocity: Double = 0
    var angularVelocity: Double = 0
}
