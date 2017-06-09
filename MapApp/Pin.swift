//
//  Pin.swift
//  MapApp
//
//  Created by David Winnicki on 2017-06-09.
//  Copyright © 2017 Winnicki. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
