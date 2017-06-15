//
//  IMUMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class IMUMessage: ROSMessage {
    public var header: HeaderMessage = HeaderMessage()
    
    public var orientation: QuaternionMessage = QuaternionMessage()
    public var orientationCovariance: [Any] = [Any]()
    
    public var angularVelocity: VectorMessage = VectorMessage()
    public var angularVelocityCovariance: [Any] = [Any]()
    
    public var linearAcceleration: VectorMessage = VectorMessage()
    public var linearAccelerationCovariance: [Any] = [Any]()
    
    override public func setDefaults() {
        self.header = HeaderMessage()
        
        self.orientation = QuaternionMessage()
        self.orientationCovariance = [Any]()
        
        self.angularVelocity = VectorMessage()
        self.angularVelocityCovariance = [Any]()
        
        self.linearAcceleration = VectorMessage()
        self.linearAccelerationCovariance = [Any]()
    }
}
