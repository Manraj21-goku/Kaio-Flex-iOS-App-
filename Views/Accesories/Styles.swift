//
//  Styles.swift
//  Kaio
//
//  Created by Manraj Singh on 16/07/23.
//

import Foundation
import SwiftUI
import UIKit

struct CheckBoxToggleStyle: ToggleStyle{
    func makeBody(configuration: Configuration) -> some View{
        HStack{
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25,height: 25)
                .cornerRadius(5.0)
                .overlay{
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                    
                }
                .onTapGesture {
                    withAnimation(.spring()){
                        configuration.isOn.toggle()
                    }
                }
            configuration.label
        }
    }
}
