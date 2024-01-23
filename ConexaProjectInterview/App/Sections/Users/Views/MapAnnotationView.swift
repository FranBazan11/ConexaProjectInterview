//
//  MapAnnotationView.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 02/01/2024.
//

import SwiftUI

struct MapAnnotationView: View {
    
    // MARK: - PROPERTIES
    let image: String
    @State private var animation: Double = 0.0
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.accentColor)
                .frame(width: 54, height: 54, alignment: .center)
            Circle()
                .stroke(Color.accentColor, lineWidth: 2)
                .frame(width: 52, height: 52, alignment: .center)
                .scaleEffect(animation + 1)
                .opacity(1 - animation)
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 48, height: 48, alignment: .center)
                .clipShape(Circle())
        } //: ZStack
        .onAppear {
            withAnimation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false)) {
                animation = 1
            }
        }
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView(image: "mappin")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
