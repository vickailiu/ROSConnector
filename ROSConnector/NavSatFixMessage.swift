//
//  NavSatFixMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation
import MapKit

public class NavSatFixMessage: ROSMessage {
    public var status: NavSetStatusMessage = NavSetStatusMessage()
    public var header: HeaderMessage = HeaderMessage()
    
    public var latitude: Double = 0
    public var longitude: Double = 0
    public var altitude: Double = 0
    
    public var positionCovariance: [Any] = [Any]()
    
    public var positionCocarianceType: NSNumber = 0
    
    public func getLocation() -> CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    public func getCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.latitude, self.longitude)
    }
    
    override public func setDefaults() {
        self.header = HeaderMessage()
        self.status = NavSetStatusMessage()
    }
}

