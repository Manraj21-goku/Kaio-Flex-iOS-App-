//
//  Workout_detailView.swift
//  Kaio
//
//  Created by Manraj Singh on 22/07/23.
//

import SwiftUI

struct Workout_detailView: View {
    
    @State private var navigateToWorkout = false
    var video: Video
    var body: some View {
        var b = video.a
        NavigationView{
            VStack(spacing: 25){
                Spacer()
                Image(video.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .cornerRadius(12)
                Text(video.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,5)
                
                HStack(spacing: 40){
                    Label("\(video.time)",systemImage: "clock.fill")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Label("\(video.exer)",systemImage: "dumbbell.fill")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                }
                Text(video.description)
                    .font(.body)
                    .lineLimit(30)
                    .padding()
                    .minimumScaleFactor(0.5)
                Spacer()
                Button {
                    navigateToWorkout = true
                } label: {
                    Text("Start Workout")
                        .bold()
                        .font(.title2)
                        .frame(width: 280,height: 50)
                        .background(Color(.systemRed))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $navigateToWorkout) {
                    WorkoutTab( Sets: "", reps: "",Sets1: "",reps1: "",Sets2: "",reps2: "",Sets3: "",reps3: "",b:b, video: VideoList.topTen.first!)
                }
                

              /*  NavigationLink(destination: WorkoutTab()) {
                    Text("Start Workout")
                        .bold()
                        .font(.title2)
                        .frame(width: 280,height: 50)
                        .background(Color(.systemRed))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }*/
               
                
                /* Link(destination: video.url) {
                 Text("Start Workout")
                 .bold()
                 .font(.title2)
                 .frame(width: 280,height: 50)
                 .background(Color(.systemRed))
                 .foregroundColor(.white)
                 .cornerRadius(10)
                 }*/
                .padding(.bottom,40)
            }
        }
    }
}

struct Workout_detailView_Previews: PreviewProvider {
    static var previews: some View {
        Workout_detailView(video: VideoList.topTen.first!)
    }
}
