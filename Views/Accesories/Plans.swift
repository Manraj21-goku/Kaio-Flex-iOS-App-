//
//  Plans.swift
//  Kaio
//
//  Created by Manraj Singh on 18/07/23.
//

/*import Foundation
class WorkoutViewModel: ObservableObject {
    @Published var workout: String?
    @Published var error: Error?

    func fetchWorkout() {
        let headers = [
            "X-RapidAPI-Key": "057f4dbf56mshc6bcd8df34c807bp11d719jsn0082e5d71778",
            "X-RapidAPI-Host": "workout-planner1.p.rapidapi.com"
        ]

        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=biceps&location=gym&equipment=dumbbells") else {
            return
        }
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=biceps&location=home&equipment=dumbbells") else {
            return
        }
        //
        
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=triceps&location=gym&equipment=dumbbells") else {
            return
        }
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=triceps&location=home&equipment=dumbbells") else {
            return
        }
        //
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=back&location=gym&equipment=dumbbells") else {
            return
        }
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=back&location=home&equipment=dumbbells") else {
            return
        }
        //
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=chest&location=gym&equipment=dumbbells") else {
            return
        }
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=chest&location=home&equipment=dumbbells") else {
            return
        }
        //
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=shoulders&location=gym&equipment=dumbbells") else {
            return
        }
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=shoulders&location=home&equipment=dumbbells") else {
            return
        }
        //
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=legs&location=gym&equipment=dumbbells") else {
            return
        }
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=legs&location=home&equipment=dumbbells") else {
            return
        }
        //
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=abs&location=gym&equipment=dumbbells") else {
            return
        }
        guard let url = URL(string: "https://workout-planner1.p.rapidapi.com/?time=60&muscle=abs&location=home&equipment=dumbbells") else {
            return
        }
//
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.error = error
                    return
                }

                if let data = data {
                    // Parse the response data here based on your requirements
                    if let workout = String(data: data, encoding: .utf8) {
                        self.workout = workout
                    }
                }
            }
        }

        dataTask.resume()
    }
}
*/
