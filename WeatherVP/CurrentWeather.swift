//
//  CurrentWeather.swift
//  WeatherVP
//
//  Created by Danyl Semmache on 22/12/2016.
//  Copyright © 2016 Danyl Semmache. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _weatherDescription: String!
    var _currentTemp: Int!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date:String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Aujourd'hui \n \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var weatherDescription: String {
        if _weatherDescription == nil {
            _weatherDescription = ""
        }
        return _weatherDescription
    }
    
    var currentTemp: Int {
        if _currentTemp == nil {
            _currentTemp = 0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Alamofire download
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        print(CURRENT_WEATHER_URL)
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                    if let main = weather[0]["description"] as? String {
                        self._weatherDescription = main.capitalized
                        print(self._weatherDescription)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Int {
                        self._currentTemp = currentTemperature
                        print(self._currentTemp)
                    }
                }
            }
            completed()
        }
    }
}
