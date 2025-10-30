//
//  GPSCoordonateStruct.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//
import Foundation
import CoreLocation

struct GPSCoordinateStruct: Codable {
    var latitude: Double?
    var longitude: Double?

    init(coordinate: CLLocationCoordinate2D?) {
        self.latitude = coordinate?.latitude
        self.longitude = coordinate?.longitude
    }
}
