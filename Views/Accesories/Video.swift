//
//  Video.swift
//  SwiftUI-List-Starter
//
//  Created by Sean Allen on 4/23/21.
//

import SwiftUI

struct Video : Identifiable{
    let id = UUID()
   
    let exer: Int
    let time: String
    let imageName: String
    let title: String
    let description: String
    let viewCount: Int
    let uploadDate: String
    let one: String
    let two: String
    let three: String
    let four: String
    let five: String
    let six: String
    let seven: String
    let eight: String
    let a: Int
    let url: URL
    let work: [String]
}

struct VideoList {
    
    
    static let topTen = [
        Video(exer: 6,
              time: "1-1.5 hr",
            imageName: "chest-tri2",
              title: "Chest and Triceps",
              description: "Strengthen and sculpt your upper body with our Chest Tricep Exercise! This effective workout targets the chest and triceps muscles, enhancing overall upper body strength and definition. Get ready to push yourself to new limits and achieve your fitness goals with this dynamic routine. Note: you can always change variation as your level,but make sure to train hard!",
              viewCount: 370222,
              uploadDate: "February 17, 2019",
              one: "Bench Press/Dumbbell Press",
              two:  "Deadlift",
              three: "Stiff Leg Deadlift",//"Stiff Leg Deadlift"
              four: "Crunches",
              five: "Seated Overhead Press",
              six: "Barbell Squats",
              seven: "Deadlifts",
              eight: "Jumping Squats",
              a: 1,
              url: URL(string: "https://youtu.be/EgpKu1tAVMY")!,
              work: ["Bench Press/Dumbbell Press","Incline Bench Press","Dips"]),
            
        
        Video(
            exer: 6,
            time: "1-1.5 hr",
            imageName: "back-bi",
              title: "Back and Biceps",
              description: "Transform your back and biceps with our Back Bicep Exercise! This powerful workout focuses on building a strong and chiseled upper body, targeting the back and biceps muscles. Elevate your fitness journey and unleash your full potential with this engaging and rewarding routine.Note: you can always change variation as your level,but make sure to train hard!",
              viewCount: 239150,
              uploadDate: "May 6, 2017",
              one:  "Incline Bench Press/Dumbbell Press",
              two:  "Horizontal Rows",
              three: "Barbell Squats",//"Barbell Squats"
              four: "Leg-Raises",
              five: "Lateral Raises",
              six: "Bench Press",
            seven: "Romanian Deadlifts",
            eight: "One Arm Dumbbell Row",
            a: 2,
            url: URL(string: "https://youtu.be/aiXvvL1wNUc")!, work: [""]
        ),
        
        Video(exer: 6,
              time: "1-1.5 hr",
              imageName: "legs",
              title: "Legs and Shoulders",
              description: "Get ready to conquer your fitness goals with our Legs and Shoulders Exercise! This intense workout is designed to tone and strengthen the legs and shoulders, providing a well-rounded lower and upper body workout. Take on the challenge and sculpt a powerful physique with this effective and engaging routine.Note: you can always change variation as your level,but make sure to train hard!",
              viewCount: 162897,
              uploadDate: "May 19, 2017",
              one: "Dips",//"Dips"
              two:  "Wide grip Lat Pulldown",
              three: "Hamstring Extension",
              four: "Planks",
              five: "Reverse Pec Deck Fly",
              six: "Barbell Row",
              seven: "Machine OHP",
              eight: "Chest Fly",
              a: 3,
              url: URL(string: "https://youtu.be/FtO5QT2D_H8")!, work: [""]),
              
        Video(exer: 6,
              time: "1-1.5 hr",
              imageName: "core",
              title: "Core",
              description: "Achieve a strong and stable core with our Core Exercise! This targeted workout focuses on strengthening the abdominal muscles, obliques, and lower back, helping you improve posture and overall functional strength. Challenge yourself to a fitter and more balanced you with this dynamic and rewarding routine.Note: you can always change variation as your level,but make sure to train hard!",
              viewCount: 119115,
              uploadDate: "May 21, 2017",
              one: "Triceps Extension",//"Triceps Extension"
              two:  "Dumbbell Curls",
              three: "Split Squats",
              four: "Russian Twists",
              five: "Preacher Curls",
              six: "SkullCrushers",
              seven: "Pull-Ups",
              eight: "Seated Arnold Press",
              a: 4,
              url: URL(string: "https://youtu.be/DBWu6TnhLeY")!, work: [""]),
        
        Video(exer: 6,
              time: "1-1.5 hr",
              imageName: "shoulders",
              title: "Arms",
              description: "Build impressive arm strength and definition with our Arm Sculpting Workout! This specialized exercise routine hones in on the biceps, triceps, and forearms, creating toned and powerful arms. Embrace the challenge and witness remarkable arm gains with this targeted and rewarding workout.Note: you can always change variation as your level,but make sure to train hard!",
              viewCount: 112213,
              uploadDate: "July 7, 2017",
              one: "Lateral Raises",//"Lateral Raises"
              two:  "Hammer Curls",
              three: "Seated Shoulder Press",
              four: "",
              five: "J and M Press",
              six: "Preacher Curls",
              seven: "Barbell Shrugs",
              eight: "Cable Tricep Extensions",
              a: 5,
              url: URL(string: "https://youtu.be/Y0qCWQDRWDw")!, work: [""]),
        
        Video(exer: 6,
              time: "1-1.5 hr",
              imageName: "full body",
              title: "Full-Body 1",
              description: "Experience the ultimate full-body transformation with our Full Body Workout! This comprehensive exercise routine engages every major muscle group, delivering a total-body challenge that boosts strength, stamina, and overall fitness. Embrace the journey to a healthier, fitter you with this dynamic and rewarding workout for your entire body.Note: you can always change variation as your level,but make sure to train hard!",
              viewCount: 106021,
              uploadDate: "October 4, 2019",
              one: "Triceps Overhead Extension",//Triceps Overhead Extension"
              two:  "Cable Pulls",
              three:"Seated Calf Raises",
              four: "",
              five: "Cable Curls",
              six: "Ab Wheel Workout",
              seven: "Planks",
              eight: "Spider Curls",
              a: 6,
              url: URL(string: "https://youtu.be/jZ_BzV0DA58")!, work: [""]),
        
        Video(exer: 6,
              time: "1-1.5 hr",
              imageName: "full body",
              title: "Full-Body 2",
              description: "Ignite your metabolism and sculpt your physique with our High-Intensity Interval Training (HIIT) Workout! This dynamic exercise routine combines bursts of intense activity with short recovery periods, maximizing calorie burn and improving cardiovascular endurance. Take your fitness to the next level with this exhilarating and time-efficient full-body workout.Note: you can always change variation as your level,but make sure to train hard!",
              viewCount: 92292,
              uploadDate: "January 28, 2020",
              one: "Deadlift",
              two:  "Romanian Deadlift",
              three: "Seated Overhead Press",
              four: "",
              five: "Dips",
              six: "Standing Calf Raise",
              seven: "",
              eight: "",
              a: 7,
              url: URL(string: "https://youtu.be/00o8oBjhdhk")!, work: [""]),
        
        Video(exer: 6,
              time: "1-1.5 hr",
              imageName: "full body",
              title: "Full-Body 3",
              description: "Unleash your inner athlete with our Circuit Training Workout! This action-packed routine rotates through a series of exercises targeting various muscle groups, providing a challenging and effective total-body workout. Elevate your fitness game and achieve remarkable results with this versatile and fun circuit training program.Note: you can always change variation as your level,but make sure to train hard!",
              viewCount: 87569,
              uploadDate: "January 24, 2019",
              one: "Jumping Squats",
              two:  "Push-Ups",
              three: "Pull-Ups",
              four: "",
              five: "Bodyweight dips",
              six: "Planks",
              seven: "",
              eight: "",
              a: 8,
              url: URL(string: "https://youtu.be/T1v_E0yuVBw")!, work: [""]),
        
        /*Video(imageName: "xcode-12",
              title: "What's New in Xcode 12 | WWDC 2020",
              description: "In this video I showcase the new features in Xcode 12. I am running the macOS Big Sur beta, but that is NOT required to download the Xcode 12 beta (although you must be in Apple's Developer Program to download).",
              viewCount: 76224,
              uploadDate: "June 24, 2020",
              url: URL(string: "https://youtu.be/MMoJiZZWoCA")!),
        
        Video(imageName: "swiftui-basics",
              title: "SwiftUI Basics Tutorial",
              description: "This video is a compilation of the first 8 videos in my SwiftUI Fundamentals course as a free preview. In this set of videos we learn the basics of building your app with SwiftUI by creating the user interface for a standard weather app.",
              viewCount: 54024,
              uploadDate: "Dec 2, 2020",
              url: URL(string: "https://youtu.be/HXoVSbwWUIk")!)*/
    ]
}
