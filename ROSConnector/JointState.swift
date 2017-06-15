//
//  JointState.swift
//  ROSTest
//
//  Created by Timofey Makeev on 25.05.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

public class JointState: ROSMessage {
    public var name = [String]()
    public var position = [Float64]()
    public var velocity = [Float64]()
    public var effort = [Float64]()
    
    override public func setDefaults() {
        self.name = [String]()
        self.position = [Float64]()
        self.velocity = [Float64]()
        self.effort = [Float64]()
    }
}
