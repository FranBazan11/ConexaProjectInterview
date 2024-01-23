//
//  MapUserView.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 30/12/2023.
//

import SwiftUI
import MapKit

struct IdentifiableCoordinate: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapUserView: View {
    
    // MARK: - PROPERTIES
    let user: UserModel
    
    @State private var animation: Double = 0.0
    
    var locationCoordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: convertLatAndLngFromStringToDouble().0,
                                      longitude: convertLatAndLngFromStringToDouble().1)
    }
    
    var location: IdentifiableCoordinate {
        IdentifiableCoordinate(coordinate: locationCoordinate2D)
    }
    
    // MARK: - BODY
    var body: some View {
        let coordinate = locationCoordinate2D
        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        Map(coordinateRegion: .constant(region),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinate) {
                MapAnnotationView(image: "mappin.circle.fill")
                
            }
        } //: Map
            .overlay(
                HStack(alignment: .center, spacing: 12, content: {
                    Image(systemName: "safari")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48, alignment: .center)
                        .foregroundColor(.yellow)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Latitude:")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(.yellow)
                            Spacer()
                            Text("\(region.center.latitude)")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        Divider()
                        HStack {
                            Text("Longitude:")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(.yellow)
                            Spacer()
                            Text("\(region.center.longitude)")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                    }
                })
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    Color.black
                        .opacity(0.6)
                        .cornerRadius(8)
                )
                .padding()
                , alignment: .top
            )
        .navigationTitle("Map")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .horizontal)
        .ignoresSafeArea(edges: .bottom)
        
    }
    
    // MARK: - PRIVATE FUNCS
    private func convertLatAndLngFromStringToDouble() -> (Double , Double) {
        let doubleLat = Double(user.address.geo.lat)
        let doubleLng = Double(user.address.geo.lng)
        guard let doubleLat = doubleLat,
              let doubleLng = doubleLng else { return (0.0 , 0.0) }
        return (doubleLat, doubleLng)
    }
}

// MARK: - PREVIEW
struct MapUserView_Previews: PreviewProvider {
    static var previews: some View {
        MapUserView(user: Mock.user)
    }
}
