//
//  Weather.swift
//  Raincoat
//
//  Created by Maija Philip on 11/9/23.
//

import Foundation

class Weather {
    
    var current: Int
    var feelsLike: Int
    var min: Int
    var max: Int
    var humidity: Int
    var rainChance: Int
    var message: Message
    
    var errorMessage: String = ""
    
    init ( weatherData: WeatherListStruct, user: User ) {
        
            // if there are no weather sections in list, there is no weather data to put in
            if weatherData.list.count < 1 {
                current = 0
                feelsLike = 0
                min = 0
                max = 0
                humidity = 0
                rainChance = 0
                errorMessage = "No weather data"
                message = Message()
                return
            }
            
            let thisWeather = weatherData.list[0]
            // round and cast double values to int
            current = Int(round(thisWeather.main.temp))
            feelsLike = Int(round(thisWeather.main.feels_like))
            min = Int(round(thisWeather.main.temp_min))
            max = Int(round(thisWeather.main.temp_max))
            humidity = Int(thisWeather.main.humidity)
            rainChance = Int(round(thisWeather.pop * 100))
            message = Message()
        
            message = getTempMessage(user: user)
            
        
    } // init
    
    convenience init() {
        self.init(weatherData: WeatherListStruct(list: []), user: User())
    }
    
    // get all the information the homescreen needs
    func getTempMessage(user: User) -> Message {
        
        // prepare for the return so we can edit it throughout the function
        let message = Message()
        var dressForTemp: TempRange = .scorching
        
        // factor in the hot/cold
        let factored = factorTemp(hotcold: user.hotcold, useCelcius: user.useCelsius)
        
        // if warm outside, dress for warm, prepare for cold
        // do this first because you can always add layers but can't take off your bases
        if (factored.max > TempRange.cool.max) {
            // loop thorugh all the cases to find which ones match the min and max
            for range in TempRange.allCases {
                if (range.max > factored.max && range.min <= factored.max) {
                    // set max for image, dress for hot
                    message.image = "\(range).\(user.hair)"
                    dressForTemp = range
                }
                if (range.max > factored.min && range.min <= factored.min) {
                    // set min for message, prepare for cold
                    message.middle = range.item
                }
            } // for all cases
        }
        // if cold outside, dress for cold, prepare for warm
        else if (factored.min > TempRange.cool.min) {
            // loop thorugh all the cases to find which ones match the min and max
            message.beginning = "Wear a "
            message.end = " for the afternoon"
            for range in TempRange.allCases {
                if (range.max > factored.max && range.min <= factored.max) {
                    // set max for message, prepare for warm
                    message.middle = range.item
                }
                if (range.max > factored.min && range.min <= factored.min) {
                    // set min for image, dress for cold
                    message.image = "\(range).\(user.hair)"
                    dressForTemp = range
                }
            } // for all cases
        }
        // if its that weird cool section, idk man best of luck to you
        else {
            message.image = "cool.\(user.hair)"
            if humidity > 70 {
                message.beginning = "Wear a "
                message.middle = "t-shirt"
                message.end = " for the humidity"
            } else {
                message.beginning = "Dress in "
                message.middle = "layers"
                message.end = " because it may be warm in the sun and cool in the shade"
            }
        }
        
        // check for rain, adjust
        if (rainChance > 20) {
            message.middle += " and a " + dressForTemp.rainItem
        }
        
        var temp = TempRange.scorching
        message.image = "\(temp).\(user.hair)"
        return message
        
    } // getTempMessage()
    
    private func factorTemp(hotcold: Double, useCelcius: Bool) -> (min: Int, max: Int) {
        // TODO: factor in hot cold
        // TODO: factor in humidity
        if (useCelcius) {
            return (min, max)
        }
        // fahrenheit
        return (min, max)
    }
    
    public static func fahrenheitToCelsius(temp: Int) -> Int {
        return Int((temp - 32) * (5/9))
    }
    public static func celsiusToFahrenheit(temp: Int) -> Int {
        return Int((9/5) * (temp + 32))
    }
   
    
} // Weather
