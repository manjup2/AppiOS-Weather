//
//  ViewController.swift
//  WeatherVP
//
//  Created by Danyl Semmache on 12/22/2016.
//  Copyright © 2016 Danyl Semmache. All rights reserved.
//

import UIKit
import Alamofire

//Hello there and welcome to my weatherVP project ! :)

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    var test : WeatherCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        test = WeatherCell()
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
       
            //Setup UI to load downloaded data
            self.downloadForecastData {
            self.updateMainUI()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let detailWeatherController = segue.destination as! detailWeatherVC
            detailWeatherController.dayWeather = forecasts[selectedRow].date
            detailWeatherController.descriptionWeather = forecasts[selectedRow].weatherDescription
            detailWeatherController.typeWeather = forecasts[selectedRow].weatherType
            detailWeatherController.minTempWeather = forecasts[selectedRow].lowTemp
            detailWeatherController.maxtempWeather = forecasts[selectedRow].highTemp
        }
    }

    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date.capitalized
        currentTempLabel.text = "\(currentWeather.currentTemp)°C"
        currentWeatherTypeLabel.text = currentWeather.weatherDescription.capitalized
        locationLabel.text = currentWeather.cityName.capitalized
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        }
}
