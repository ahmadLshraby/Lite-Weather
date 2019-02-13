//
//  ChangeCityVC.swift
//  Lite Weather
//
//  Created by sHiKoOo on 2/13/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func newCity(city: String)
}

class ChangeCityVC: UIViewController {
    
    var delegate: ChangeCityDelegate?

    @IBOutlet weak var changeCityTxt: CityTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aniButton()
    }
    
    func aniButton() {
        let aniButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        aniButton.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        aniButton.setTitle("Get Weather", for: .normal)
        aniButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        aniButton.addTarget(self, action: #selector(ChangeCityVC.getWeather), for: .touchUpInside)
        // add to textFields
        changeCityTxt.inputAccessoryView = aniButton
    }
    @objc func getWeather() {
        if let city = changeCityTxt.text {
           view.endEditing(true)
            delegate?.newCity(city: city)
            self.dismiss(animated: true, completion: nil)
  
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
