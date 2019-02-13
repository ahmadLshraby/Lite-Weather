//
//  WeatherVC.swift
//  Lite Weather
//
//  Created by sHiKoOo on 2/13/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        
    }
    
    func getLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Did update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            self.locationManager.stopUpdatingLocation()
            print("lon= \(location.coordinate.longitude), lat= \(location.coordinate.latitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params = ["lat": latitude, "lon": longitude, "appid": APP_ID]
            
            API.getWeather(parameters: params) { (success) in
                if success == true {
                    self.cityLbl.text = WeatherDataModel.instance.city
                    self.tempLbl.text = "\(WeatherDataModel.instance.temperature)°"
                }else {
                    self.cityLbl.text = "Connection Problem"
                }
            }
        }
    }
    
    // Did fail location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityLbl.text = "Location Error"
        print(error)
    }
    
    // User Entered new city delegate protocol
    func newCity(city: String) {
        let params = ["q": city, "appid": APP_ID]
        API.getWeather(parameters: params) { (success) in
            if success == true {
                self.cityLbl.text = WeatherDataModel.instance.city
                self.tempLbl.text = "\(WeatherDataModel.instance.temperature) °"
            }else {
                self.cityLbl.text = "Connection Problem"
            }
        }
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_CITY_SEGUE {
            let destinationVC = segue.destination as! ChangeCityVC
            destinationVC.delegate = self
        }
    }
    
    
    
    
    
}
