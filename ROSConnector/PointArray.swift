//
//  PointArray.swift
//  Pods-test
//
//  Created by mac on 22/11/17.
//

import Foundation


public class ArrayMessage: ROSMessage {
    public var data = [PointMessage]()
    
    override public func setDefaults() {
        self.data = [PointMessage]()
    }
}

