//
//  ViewController.swift
//  Converter
//
//  Created by Сергей Денисов on 16.04.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var converterLabel: UILabel!
    @IBOutlet weak var jpyRubLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let url = "https://www.cbr-xml-daily.ru/daily_json.js"

        Alamofire.request(url, method: .get).validate().responseJSON {
            response in
            print(response.result)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let jpy = json["Valute"]["JPY"]["Value"].double!
                self.jpyRubLabel.text = "100 JPY = \(jpy) RUB"
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

