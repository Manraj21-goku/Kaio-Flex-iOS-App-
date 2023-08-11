//
//  list2.swift
//  Kaio
//
//  Created by Manraj Singh on 11/08/23.
//

import SwiftUI
import Foundation
import Combine
import UIKit
import SDWebImageSwiftUI
import FirebaseStorage
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct Exercise: Hashable,Codable,Identifiable{
    let name : String
    let bodyPart : String
    let equipment : String
    let gifUrl : String
    let id  : String
    let target : String
}
struct ExerciseList: View {
    @State private var searchText = ""
    @StateObject private var exerciseFetcher = ExerciseFetcher()
    var body: some View {
        NavigationView {
            Group{
                List(exerciseFetcher.filteredExercises, id: \.id) { exercise in
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                            .font(.headline)
                        Text(exercise.bodyPart)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(exercise.equipment)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(exercise.target)
                            .font(.subheadline)
                            .foregroundColor(.red)
                        AnimatedImage(url: URL(string: exercise.gifUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onAppear{
                                SDWebImagePrefetcher.shared.prefetchURLs([URL(string: exercise.gifUrl)].compactMap{$0})
                                
                            }
                            .onDisappear{
                                SDWebImagePrefetcher.shared.cancelPrefetching()
                            }
                        
                            .frame(height:300)
                        
                    }
                }
                
                
            }
            .navigationTitle("Exercises")
            .searchable(text: $searchText,prompt: "Search Exercises")
            .onChange(of: searchText) { newText in
                exerciseFetcher.filterExercises(with: newText)
            }
        }
    }
}

struct ExerciseList_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseList()
    }
}




class DataManager {
    static let shared = DataManager()
    
    func fetchAndStoreExercises(completion: @escaping (Error?) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "057f4dbf56mshc6bcd8df34c807bp11d719jsn0082e5d71778",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        ]
        
        guard let url = URL(string: "https://exercisedb.p.rapidapi.com/exercises") else {
            completion(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError(domain: "No data received", code: -1, userInfo: nil))
                return
            }
            
            do {
                let exercises = try JSONDecoder().decode([Exercise].self, from: data)
                FirebaseManager.shared.storeExercises(exercises)
                completion(nil)
            } catch {
                completion(error)
            }
        }.resume()
    }
}

class FirebaseManager {
    static let shared = FirebaseManager()
    
    func storeExercises(_ exercises: [Exercise]) {
        let db = Firestore.firestore()
        
        for exercise in exercises {
            db.collection("gif").document(exercise.id).setData([
                "name": exercise.name,
                "bodyPart": exercise.bodyPart,
                "equipment": exercise.equipment,
                "gifUrl": exercise.gifUrl,
                "id": exercise.id,
                "target": exercise.target
            ])
        }
    }
}


class ExerciseFetcher: ObservableObject {
    
    @Published var exercises: [Exercise] = []
    @Published var filteredExercises: [Exercise] = []
    init() {
        fetchData()
    }
    func fetchData() {
        let db = Firestore.firestore()
        
        db.collection("gif").getDocuments { querySnapshot, _ in
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            self.exercises = documents.compactMap { document in
                guard let data = document.data() as? [String: Any],
                      let name = data["name"] as? String,
                      let bodyPart = data["bodyPart"] as? String,
                      let equipment = data["equipment"] as? String,
                      let gifUrl = data["gifUrl"] as? String,
                      let id = data["id"] as? String,
                      let target = data["target"] as? String
                else {
                    return nil
                }
                
                return Exercise(
                    name: name,
                    bodyPart: bodyPart,
                    equipment: equipment,
                    gifUrl: gifUrl,
                    id: id,
                    target: target
                )
            }
            self.filterExercises(with: "")
        }
    }
    func filterExercises(with searchText:String){
        if searchText.isEmpty {
            filteredExercises = exercises
        }
        else{
            filteredExercises = exercises.filter{exercise in
                exercise.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
    }
    /*  var filteredExercises: [Exercise] {
     guard !searchText.isEmpty else{return exercises}
     return exercises.filter {$0.name.localizedCaseInsensitiveContains(searchText)}
     }*/
}
