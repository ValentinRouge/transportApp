//
//  GeographicUtils.swift
//  StopIDF
//
//  Created by Valentin Rouge on 04/11/2023.
//

import Foundation

class GeographicUtils {
    static let corrValue = [
        (48.70549707,0.005785728116855182),
        (49.14757844, 0.00531246199160762),
        (48.86174050, 0.005616773503440697),
        (48.29362876, 0.006239943907111467)
    ]

    static func getCorrectionValue(latitude: Double) -> Double {
        
        let sortedData = corrValue.sorted { $0.0 < $1.0 }
        
        let closest = corrValue.min { abs($0.0 - latitude) < abs($1.0 - latitude) }

        // Effectuer un produit en croix pour trouver d
        let d = closest != nil ? closest!.1 * latitude / closest!.0 : nil
        
        return d ?? 0.005785728116855182
    }

    static func convertLambert93ToWGS84(x: Double, y: Double) -> (latitude: Double, longitude: Double) {
        let c = 11754255.4260960; //constante de la projection
        let e = 0.0818191910428; //première exentricité de l'ellipsoïde
        let n = 0.7256077650532670; //exposant de la projection
        let xs:Double = 700000.0; //coordonnées en projection du pole
        let ys = 12655612.0498760; //coordonnées en projection du pole
        
        // Conversion des coordonnées Lambert 93 en mètres
        let xMeters = x - xs
        let yMeters = y - ys
        
        let r = sqrt(pow(xMeters, 2) + pow(yMeters, 2))
        let a = log(c/(r)/n)
        let theta = atan(-(xMeters)/(yMeters))

        var lat = asin(tanh((log(c/r)/n)+e*atanh(e*(tanh(a+e*atanh(e*(tanh(a+e*atanh(e*(tanh(a+e*atanh(e*(tanh(a+e*atanh(e*(tanh(a+e*atanh(e*(tanh(a+e*atanh(e*sin(1))))))))))))))))))))))/Double.pi*180;
                
        lat = lat - getCorrectionValue(latitude: lat)
        
        let long = (theta/n+3/180*Double.pi)/Double.pi*180;
        
        return (lat, long)
    }

}

