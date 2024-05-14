//
//  DataViewModel.swift
//  Getter
//
//  Created by Maija Philip on 11/7/23.
//

import Foundation
import Combine
import SwiftUI

@Observable
class DataViewModel {
    
    // output
    var data: Weather? = nil
    var errorMessage = ""
    var error = false
    var isDone = true
    
    private var task: AnyCancellable? = nil
    
    func fetch(user: ModelUser) {
        
        // let units = user.useCelsius ? "metric" : "imperial"
        let units = "metric"
        let lat = user.location.latitude
        let long = user.location.longitude
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&cnt=8&units=\(units)&appid=9ec235daafa8f93bad9066f04ac55f07"
        
        // make sure url is valid
        guard let url = URL(string: urlString) else {
            error = true
            isDone = true
            errorMessage = "Problem with url string"
            return
        }
        
        // this is the combined version of dataTask
        // goes to the url and gets data back
        task = URLSession.shared.dataTaskPublisher(for: url)
            // takes what we get back and tries to map it to data
            .tryMap { data, response in
                // check if response is an HTTP status code
                guard let httpResponse = response as? HTTPURLResponse
                else {
                    self.error = true
                    // self.errorMessage = "Bad response"
                    self.errorMessage = "Please make sure that you have internet connection. We can't fetch the weather without internet."
                    throw URLError(.badServerResponse)
                }
                
                // check if status code is 200
                guard httpResponse.statusCode == 200 else {
                    // return "Bad Status Code: \(httpResponse.statusCode)"
                    self.error = true
                    self.errorMessage = "Bad Status Code";
                    print(httpResponse.statusCode)
                    return Weather()
                }
                
                // print(httpResponse)
                
                let decoder = JSONDecoder()
                let weatherList = try! decoder.decode(WeatherListStruct.self, from: data)
                if weatherList.list.count < 1 {
                    self.error = true
                    self.errorMessage = "We were not able to get the data. Check your internet connection"
                    return Weather()
                }
                let weatherObj = Weather(weatherData: weatherList.list[0], user: user)
                for weatherSection in weatherList.list {
                    weatherObj.checkIfNeedsAdjusting(weatherData: weatherSection)
                }
                weatherObj.resetTempMessage(user: user)
                return weatherObj
                
                // convert to string for now bc that is what we are expecting
//                let encoder = JSONEncoder()
//                let parkData = try! encoder.encode(parkList.self)
//                let parkStr = String.init(data: parkData, encoding: .utf8)
//                return parkStr ?? ""
                
                // what comes back from the task is binary data
                // we are gonna convert it to a string
                // return String(data: data, encoding: String.Encoding(rawValue: String.Encoding.ascii.rawValue)) ?? ""
            }
            // go from the background loop to the foreground so we can display errors
            // data map is the faucet and the sink is the drain
            .receive(on: RunLoop.main) // so we can update on the main thread for errors as well as our sink
            .catch({ Error -> Just<Weather> in
                // converts the error we threw above to a string
                print(Error)
                self.error = true
                self.errorMessage = "Bad Response"
                return Just<Weather>(Weather())
            })
            // want just a string
            .eraseToAnyPublisher() // gets rid of extra return types, type modifiers
            .sink(receiveValue: { results in
                // we are getting the string we returned here
                self.isDone = true
                self.data = results
            })
        
        
    } // fetch
    
} // class
