//
//  MapView.swift
//  StopIDF
//
//  Created by Valentin Rouge on 04/11/2023.
//

import SwiftUI
import MapKit
import SwiftData


struct MapView: View {
    @Environment(\.modelContext) var context
    
    @State private var visibleRect: MKCoordinateRegion?
    @State var allZones: [SDZones] = []
    @StateObject var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .userLocation( fallback: .item( MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 48.8534100, longitude: 2.3488000))), allowsAutomaticPitch: false))
    
    @State private var showDetailOfStop: Bool = false
    @State private var selectedZone:SDZones?
    
    @State private var gridLatitudeNumber = 10.0
    @State private var gridLongitudeNumber = 5.0
    
    @State private var maxLatitude: Double = 48.8534100
    @State private var maxLongitude: Double = 2.3488000
    
    @State private var latitudeGrid = 1.0
    @State private var longitudeGrid = 1.0
    
    var body: some View {
        Map(position: $position, selection: $selectedZone) {
            UserAnnotation()
            
            let grid = Dictionary(grouping: allZones) { zone -> String in
                return "\(Int((maxLatitude - zone.latitude)/latitudeGrid))-\(Int((maxLongitude - zone.longitude)/longitudeGrid))-\(zone.mode)"
                
            }
            
            ForEach(Array(grid.keys), id: \.self) { key in
                let markers = grid[key] ?? []
                let markerCount = Double(markers.count)
                if (markerCount > 4.0) {
                    
                    let (latitude, longitude) = getMeanLatLong(markers: markers, count: markerCount)
                    
                    Annotation(
                        "",
                        coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    ) {
                        MultiMarkerTransportModeView(transportMode: markers.first?.mode ?? "bus")
                    }
                } else {
                    ForEach(markers, id: \.id) {zone in
                        
                        Annotation(
                            zone.name,
                            coordinate: CLLocationCoordinate2D(latitude: zone.latitude, longitude: zone.longitude)
                        ) {
                            TransportModeSymbolView(transportMode: zone.mode)
                        }
                        .tag(zone)
                        
                    }
                }
            }
            
        }
        .mapControls {
            MapUserLocationButton()
            MapScaleView(anchorEdge: .leading)
            MapCompass()
        }
        .mapStyle(.standard(pointsOfInterest: .excluding([.restaurant, .bakery, .bank, .cafe, .foodMarket, .nightlife, .winery])))
        .onMapCameraChange { context in
            maxLatitude = context.region.center.latitude + context.region.span.latitudeDelta
            maxLongitude = context.region.center.longitude + context.region.span.longitudeDelta
            
            latitudeGrid = context.region.span.latitudeDelta/gridLatitudeNumber
            longitudeGrid = context.region.span.longitudeDelta/gridLongitudeNumber
            
            visibleRect = context.region
            fetchStopsOnView()
        }
        .sheet(isPresented: $showDetailOfStop, onDismiss: {
            selectedZone = nil
        }) {
            if let zone = selectedZone {
                OneStopDetailView(Zone: zone)
                    .presentationDetents([.fraction(0.40) ,.large])
                    .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.40)))
            } else {
                Text("Zone incorrecte")
            }
    
        }
        .onChange(of: selectedZone) {
            if (selectedZone != nil) {
                showDetailOfStop = true
            } else {
                showDetailOfStop = false
            }
        }

    }
    
    func fetchStopsOnView() {
        Task {
            let minLatitude = Double(visibleRect?.center.latitude ?? 0) - Double(visibleRect?.span.latitudeDelta ?? 0)/2
            let maxLatitude = Double(visibleRect?.center.latitude ?? 0) + Double(visibleRect?.span.latitudeDelta ?? 0)/2
            
            let minLongitude = Double(visibleRect?.center.longitude ?? 0) - Double(visibleRect?.span.longitudeDelta ?? 0)/2
            let maxLongitude = Double(visibleRect?.center.longitude ?? 0) + Double(visibleRect?.span.longitudeDelta ?? 0)/2

            
            let predicate = #Predicate<SDZones> {
                (minLatitude ... maxLatitude).contains($0.latitude)
                &&
                (minLongitude ... maxLongitude).contains($0.longitude)
            }
            
            let fetchDescriptor:FetchDescriptor = FetchDescriptor(predicate: predicate, sortBy: [SortDescriptor(\SDZones.town, order: .forward), SortDescriptor(\SDZones.name, order: .forward)])
            
            do {
                allZones = try context.fetch(fetchDescriptor)
            } catch {
                allZones = []
            }
        }
    }
    
    func getMeanLatLong(markers: [SDZones], count: Double) -> (Double, Double) {
        var sumOfLatitude = 0.0
        var sumOfLongitude = 0.0
        
        markers.forEach { zone in
            sumOfLatitude = sumOfLatitude + zone.latitude
            sumOfLongitude = sumOfLongitude + zone.longitude
        }
        
        let latitude = sumOfLatitude / count
        let longitude = sumOfLongitude / count
        
        return (latitude, longitude)
    }
       
        
}

#Preview {
    MapView()
}
