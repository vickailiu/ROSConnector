//
//  PoseMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class PoseMessage: ROSMessage {
    public var x: Double = 0
    public var y: Double = 0
    public var theta: Double = 0
    public var linearVelocity: Double = 0
    public var angularVelocity: Double = 0
}
