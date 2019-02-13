//
//  API.swift
//  Lite Weather
//
//  Created by sHiKoOo on 2/13/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API: NSObject {

    
    class func getWeather(parameters: [String: String], completion: @escaping (_ success: Bool) -> Void) {
        
        Alamofire.request(WEATHER_URL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                // parsing JSON
                let json = JSON(value)
                let tempResult = json["main"]["temp"].doubleValue
                WeatherDataModel.instance.temperature = Int(tempResult - 273.15)
                WeatherDataModel.instance.city = json["name"].stringValue
                WeatherDataModel.instance.condition = json["weather"][0]["id"].intValue
                WeatherDataModel.instance.weatherIconName = WeatherDataModel.instance.updateWeatherIcon(condition: WeatherDataModel.instance.condition)
                completion(true)
                print(json)
            case .failure(let error):
                completion(false)
                print(error)
            }
        }
    }

}
