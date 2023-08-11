//
//  ExerciseList.swift
//  Kaio
//
//  Created by Manraj Singh on 16/07/23.
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
    
    
    
    let headers = [
        "X-RapidAPI-Key": "057f4dbf56mshc6bcd8df34c807bp11d719jsn0082e5d71778",
        "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
    ]
    @State private var isDataLoaded = false
    @State private var isInitialLoad = true
    @State private var exercises: [Exercise] = []
    @State private var searchText = ""
    @AppStorage("exercisesData") var storedExercisesData: Data?
    var filteredExercises: [Exercise] {
        guard !searchText.isEmpty else{return exercises}
        return exercises.filter {$0.name.localizedCaseInsensitiveContains(searchText)}
    }
    func loadData(){
        if let savedExercises = UserDefaults.standard.value(forKey: "exercises") as? Data{
            let decoder = JSONDecoder()
            if let decodedExercises = try? decoder.decode([Exercise].self, from: savedExercises){
                exercises = decodedExercises
                isDataLoaded = true
                return
            }
        }
        guard let url = URL(string: "https://exercisedb.p.rapidapi.com/exercises") else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data,response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Exercise].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:{ completion in
                switch completion{
                case .failure(let error): print (error)
                case.finished: break
                }
                
            } , receiveValue: { decodedResponse in
                exercises = decodedResponse
                print(decodedResponse)
                
                let encoder = JSONEncoder()
                if let encodedData = try? JSONEncoder().encode(decodedResponse){
                    UserDefaults.standard.set(encodedData,forKey: "exercises")
                    isDataLoaded = true
                }
            })
            .store(in: &cancellables)
        
    }
    @State private var cancellables = Set<AnyCancellable>()
    var body: some View {
        
        NavigationView{
            Group{
                if isDataLoaded{
                    List(filteredExercises, id: \.name){ exercise in
                        VStack(alignment: .leading){
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
                else{
                    ProgressView()
                }
            }
            
            .navigationTitle("Exercises")
            .searchable(text: $searchText,prompt: "Search Exercises")
            
            }
        .onAppear{
            if !isDataLoaded{
                loadData()
            }
        }
    }
    
    
  
}

struct ExerciseList_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseList()
    }
}
