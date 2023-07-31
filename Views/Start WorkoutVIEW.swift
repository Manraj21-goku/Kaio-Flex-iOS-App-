//
//  Start WorkoutVIEW.swift
//  Kaio
//
//  Created by Manraj Singh on 17/07/23.
//

import SwiftUI

struct Start_WorkoutVIEW: View {
    var videos : [Video] = VideoList.topTen
    var body: some View {
        NavigationView{
            List(videos, id: \.id){ video in
                NavigationLink(destination: Workout_detailView(video: video)) {
                 VideoCell(video: video)
                }
               
            }
            .navigationTitle("Workout")
        }
    }
}
struct VideoCell: View{
  
    var video: Video
    var body: some View{
        HStack{
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .cornerRadius(10)
                .padding(.vertical,5)
            
            VStack(alignment: .leading,spacing: 5){
                Text(video.title)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .font(.system(size: 20))
                
             
            }
        }
    }
}
struct Start_WorkoutVIEW_Previews: PreviewProvider {
    static var previews: some View {
        Start_WorkoutVIEW()
    }
}
