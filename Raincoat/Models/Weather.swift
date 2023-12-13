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
    
    init ( weatherData: WeatherSectionsStruct, user: User ) {
        
        let thisWeather = weatherData.main
        // round and cast double values to int
        current = Int(round(thisWeather.temp))
        feelsLike = Int(round(thisWeather.feels_like))
        min = Int(round(thisWeather.temp_min))
        max = Int(round(thisWeather.temp_max))
        humidity = Int(thisWeather.humidity)
        rainChance = Int(round(weatherData.pop * 100))
        message = Message()
    
        message = getTempMessage(user: user)
            
        
    } // init
    
    convenience init() {
        self.init(weatherData: WeatherSectionsStruct(main: WeatherStruct(temp: 0, feels_like: 0, temp_min: 0, temp_max: 0, humidity: 0), pop: 0), user: User())
        errorMessage = "No weather data"
    }
    
    func checkIfNeedsAdjusting(weatherData: WeatherSectionsStruct) {
        let tempmin = Int(round(weatherData.main.temp_min))
        let tempmax = Int(round(weatherData.main.temp_max))
        let temphumidity = Int(weatherData.main.humidity)
        let temprainChance = Int(round(weatherData.pop * 100))
        
        if tempmin < min {
            min = tempmin
        }
        if tempmax > max {
            max = tempmax
        }
        if temphumidity > humidity {
            humidity = temphumidity
        }
        if temprainChance > rainChance {
            rainChance = temprainChance
        }
    }
    
    func resetTempMessage(user: User) {
        message = getTempMessage(user: user)
    }
    
    // get all the information the homescreen needs
    func getTempMessage(user: User) -> Message {
        
        // prepare for the return so we can edit it throughout the function
        let message = Message()
        var dressForTemp: TempRange = .scorching
        
        // factor in the hot/cold
        let factored = factorTemp(hotcold: user.hotcold, useCelcius: user.useCelsius)
        var changed = false
        
        if (user.useCelsius) {
            // if warm outside, dress for warm, prepare for cold
            // do this first because you can always add layers but can't take off your bases
            changed = true
            
            if (factored.max > TempRange.cool.maxC) {
                // loop thorugh all the cases to find which ones match the min and max
                for range in TempRange.allCases {
                    
                    if (range.maxC > factored.max && range.minC <= factored.max) {
                        // dress for hot
                        message.image = "\(range).\(user.hair)"
                        dressForTemp = range
                    }
                    if (range.maxC > factored.min && range.minC <= factored.min) {
                        // prepare for cold
                        message.middle = range.item

                    }
                } // for all cases
            }
            // if cold outside, dress for cold, prepare for warm
            else if (factored.min < TempRange.cool.minC) {
                // loop thorugh all the cases to find which ones match the min and max
                
                message.beginning = "Wear a"
                message.end = "for the afternoon"
                for range in TempRange.allCases {
                    if (range.maxC > factored.max && range.minC <= factored.max) {
                        // prepare for hot
                        message.middle = range.item
                    }
                    if (range.maxC > factored.min && range.minC <= factored.min) {
                        // dress for cold
                        message.image = "\(range).\(user.hair)"
                        dressForTemp = range
                    }
                } // for all cases
            }
        } else {
            // if warm outside, dress for warm, prepare for cold
            // do this first because you can always add layers but can't take off your bases
            changed = true
            
            if (factored.max > TempRange.cool.maxF) {
                // loop thorugh all the cases to find which ones match the min and max
                for range in TempRange.allCases {
                    if (range.maxF > factored.max && range.minF <= factored.max) {
                        // set max for image, dress for hot
                        message.image = "\(range).\(user.hair)"
                        dressForTemp = range
                    }
                    if (range.maxF > factored.min && range.minF <= factored.min) {
                        // set min for message, prepare for cold
                        message.middle = range.item
                    }
                } // for all cases
            }
            // if cold outside, dress for cold, prepare for warm
            else if (factored.min > TempRange.cool.minF) {
                // loop thorugh all the cases to find which ones match the min and max
                changed = true
                
                message.beginning = "Wear a"
                message.end = "for the afternoon"
                for range in TempRange.allCases {
                    if (range.maxF > factored.max && range.minF <= factored.max) {
                        // set max for message, prepare for warm
                        message.middle = range.item
                    }
                    if (range.maxF > factored.min && range.minF <= factored.min) {
                        // set min for image, dress for cold
                        message.image = "\(range).\(user.hair)"
                        dressForTemp = range
                    }
                } // for all cases
            }
        }
        
        // if its that weird cool section, idk man best of luck to you
        if (!changed) {
            message.image = "cool.\(user.hair)"
            if humidity > 70 {
                message.beginning = "Wear a"
                message.middle = "t-shirt"
                message.end = "for the humidity"
            } else {
                message.beginning = "Dress in"
                message.middle = "layers"
                message.end = "because it may be warm in the sun and cool in the shade"
            }
        }
        
        // check for rain, adjust
        if (rainChance > 20) {
            message.middle += " and a " + dressForTemp.rainItem
        }
        
        return message
        
    } // getTempMessage()
    
    private func factorTemp(hotcold: Double, useCelcius: Bool) -> (min: Int, max: Int) {
        
        // TODO: This formula is v1 and could totally be improved
        let hotColdShift = getHotColdShift(hotcold: hotcold) // in celsius
        let humidityShift = feelsLike - current // get the api's feels like shift

        if (useCelcius) {
            // hotcold only effects when its not 50
            return (min+hotColdShift+humidityShift, max+hotColdShift+humidityShift)
        }
        // fahrenheit
        // turn the shift into farenheit
        let adjustedShift = Weather.celsiusToFahrenheit(temp: hotColdShift)
        
        return (min+adjustedShift+humidityShift, max+adjustedShift+humidityShift)
    }
    
    /// Calculate the effect of feeling hot or cold on the temperature
    ///  will be negaive for feeling hot, and positive for feeling cold
    ///    SHIFT IS IN CELSIUS
    private func getHotColdShift(hotcold: Double) -> Int{
        // I'm using x because this is a verrryyyy long equation
        /// i'm shifting hotcold so that no change (50) is at x=0 instead of x=50
        let x = hotcold - 50
        
        /// this formula is very long and particular to shift the max of 7 degrees C and exponentially less than that for the middle
        let part1 = -0.00002 * x * x * x
        let part2 = 0.00000000000000001 * x * x
        let part3 = 0.09 * x
        
        return Int(round(part1 + part2 - part3))
        
    }
    
    public static func fahrenheitToCelsius(temp: Int) -> Int {
        return Int((temp - 32) * (5/9))
    }
    public static func celsiusToFahrenheit(temp: Int) -> Int {
        return Int((9/5) * (temp + 32))
    }
   
    public func willSnow(user: User) -> Bool {
        if (user.useCelsius) { 
            return max < 0
        }
        // fahrenheit
        return max < 32
    }
    
} // Weather
