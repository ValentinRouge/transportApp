//
//  MKCoordinateRegionExtension.swift
//  StopIDF
//
//  Created by Valentin Rouge on 19/11/2023.
//

import Foundation
import MapKit

extension MKCoordinateRegion{
    static let paris = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 48.8534100,
            longitude: 2.3488000),
        span: MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1)
    )
}

