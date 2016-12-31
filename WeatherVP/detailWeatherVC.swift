//
//  detailWeatherVC.swift
//  WeatherVP
//
//  Created by Danyl Semmache on 12/22/2016.
//  Copyright © 2016 Danyl Semmache. All rights reserved.
//

import UIKit

class detailWeatherVC: UIViewController {

    @IBOutlet weak var daySelected: UILabel!
    @IBOutlet weak var descriptionSelected: UILabel!
    @IBOutlet weak var minTempSelected: UILabel!
    @IBOutlet weak var maxTempSelected: UILabel!
    @IBOutlet weak var weatherTypeSelected: UIImageView!
    
    var dayWeather = String()
    var descriptionWeather = String()
    var typeWeather = String()
    var minTempWeather = String()
    var maxtempWeather = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        daySelected.text = dayWeather
        descriptionSelected.text = descriptionWeather.capitalized
        weatherTypeSelected.image = UIImage(named: typeWeather)
        minTempSelected.text = "Minimum : \(minTempWeather)°C"
        maxTempSelected.text = "Maximum : \(maxtempWeather)°C"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
