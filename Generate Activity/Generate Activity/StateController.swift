//
//  StateController.swift
//  Generate Activity
//
//  Created by Pierre Buclez on 20/03/2023.
//

import Foundation

class StateController: ObservableObject {
    
    var suggestedActivity: String
    var numberOfParticipants: Int
    
    init() {
        suggestedActivity = ""
        numberOfParticipants = 0
    }
    
    func getData() {
        
        guard let url = URL(string: "https://www.boredapi.com/api/activity?") else {
                return
            }

        URLSession.shared.dataTask(with: url) {data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data returned")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Activity.self, from: data)
                    self.suggestedActivity = result.activity
                    self.numberOfParticipants = result.participants
                    print(self.suggestedActivity)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }.resume()
        
    }
    


    
    
}
