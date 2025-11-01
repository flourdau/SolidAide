//
//  GPSCoordonateStruct.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import MapKit

struct GPSCoordinateStruct: Codable {
    var latitude: Double
    var longitude: Double
    
    init(
        coordinate: CLLocationCoordinate2D?
    ) {
        self.latitude = coordinate?.latitude ?? 0.0
        self.longitude = coordinate?.longitude ?? 0.0
    }
}
