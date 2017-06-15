//
//  NavSatFixMessage.swift
//  ROSTest
//
//  Created by Timofey Makeev on 20.04.17.
//  Copyright © 2017 dobro. All rights reserved.
//

import Foundation
import MapKit

class NavSatFixMessage: ROSMessage {
    var status: NavSetStatusMessage = NavSetStatusMessage()
    var header: HeaderMessage = HeaderMessage()
    
    var latitude: Double = 0
    var longitude: Double = 0
    var altitude: Double = 0
    
    var positionCovariance: [Any] = [Any]()
    
    var positionCocarianceType: NSNumber = 0
    
    func getLocation() -> CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    func getCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.latitude, self.longitude)
    }
    
    override func setDefaults() {
        self.header = HeaderMessage()
        self.status = NavSetStatusMessage()
    }
}

