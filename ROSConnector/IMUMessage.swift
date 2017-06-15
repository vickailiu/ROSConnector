//
//  IMUMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

class IMUMessage: ROSMessage {
    var header: HeaderMessage = HeaderMessage()
    
    var orientation: QuaternionMessage = QuaternionMessage()
    var orientationCovariance: [Any] = [Any]()
    
    var angularVelocity: VectorMessage = VectorMessage()
    var angularVelocityCovariance: [Any] = [Any]()
    
    var linearAcceleration: VectorMessage = VectorMessage()
    var linearAccelerationCovariance: [Any] = [Any]()
    
    override func setDefaults() {
        self.header = HeaderMessage()
        
        self.orientation = QuaternionMessage()
        self.orientationCovariance = [Any]()
        
        self.angularVelocity = VectorMessage()
        self.angularVelocityCovariance = [Any]()
        
        self.linearAcceleration = VectorMessage()
        self.linearAccelerationCovariance = [Any]()
    }
}
