//
//  JointState.swift
//  ROSTest
//
//  Created by Timofey Makeev on 25.05.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation

class JointState: ROSMessage {
    var name = [String]()
    var position = [Float64]()
    var velocity = [Float64]()
    var effort = [Float64]()
    
    override func setDefaults() {
        self.name = [String]()
        self.position = [Float64]()
        self.velocity = [Float64]()
        self.effort = [Float64]()
    }
}
