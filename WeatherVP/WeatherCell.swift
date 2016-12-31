//
//  WeatherCell.swift
//  WeatherVP
//
//  Created by Danyl Semmache on 12/22/2016.
//  Copyright © 2016 Danyl Semmache. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!

    func configureCell(forecast: Forecast) {
        lowTemp.text = "\(forecast.lowTemp)°C"
        highTemp.text = "\(forecast.highTemp)°C"
        weatherDescription.text = forecast.weatherDescription.capitalized
        weatherIcon.image = UIImage(named: forecast.weatherType)
        dayLabel.text = forecast.date.capitalized
    }
}
