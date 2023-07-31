//
//  picker.swift
//  Kaio
//
//  Created by Manraj Singh on 17/07/23.
//

import SwiftUI

struct picker: View {
    @State private var selectedAge = 18
    let ageRange = 1...100
    var body: some View {
        Picker("Age",selection: $selectedAge){
             ForEach(ageRange, id: \.self){ age in
                 Text("\(age)")
             }
         }
         .pickerStyle(.wheel)
         .foregroundColor(.red)
       
    }
}

struct picker_Previews: PreviewProvider {
    static var previews: some View {
        picker()
    }
}
