//
//  TabBarButton.swift
//  Kaio
//
//  Created by Manraj Singh on 19/07/23.
//

import SwiftUI

struct TabBarButton: View {
    var buttonText : String
    var imageName: String
    var isActive: Bool
    var body: some View {
        GeometryReader{ geo in
            if isActive{
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geo.size.width/2,height: 4)
                    .padding(.leading,geo.size.width/4)
            }
            VStack(alignment: .center, spacing: 4){
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32,height: 32)
                Text(buttonText)
                  //  .font(Font.custom("LexendDeca-Regular", size: 17))
                
            }
            .frame(width: geo.size.width,height: geo.size.height)
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(buttonText: "Home", imageName: "house", isActive: true)
    }
}
