//
//  ViewController.swift
//  CuCo
//
//  Created by Сергей Денисов on 20.04.2021.
//

import UIKit
import Alamofire
import SWXMLHash

class ViewController: UIViewController{


    struct Valute: XMLIndexerDeserializable {
        var numCode: Int
        var charCode: String
        var nominal: Int
        var name: String
        var value: Double
        var id: String
    }
    static func deserialize(_ node: XMLIndexer) throws -> Valute {
        return try Valute(
            numCode: node["NumCode"].value(),
            charCode: node["CharCode"].value(),
            nominal: node["Nominal"].value(),
            name: node["Name"].value(),
            value: node["Value"].value(),
            id: node.value(ofAttribute: "ID"))
    }
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var jpyRubLabel: UILabel!
    
            override func viewDidLoad() {
            super.viewDidLoad()
            
            Alamofire.request("http://www.cbr.ru/scripts/XML_daily.asp", parameters: nil)
                 .response { response in
                    if let data = response.data {
                        let xml = SWXMLHash.parse(data)
                        
                        let jpy = xml["ValCurs"]["Valute"].filterAll{ elem, _ in elem.attribute(by: "ID")!.text == "R01820" }
                        let jpyValue = jpy.children[4].element!.text
                        
                       self.jpyRubLabel.text = "100 JPY = \(jpyValue) RUB"

                        }
                    }
                }
            }
    

