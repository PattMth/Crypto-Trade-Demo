//
//  buyViewController.swift
//  CryptoTracker
//
//  Created by user189998 on 5/23/21.
//

import Foundation
import UIKit
import Coinpaprika
import Parse

class buyViewController: UIViewController, UITextFieldDelegate{
    var coinID = ""
    var balance: Double = 0.0
    var dbID = ""
    
    @IBOutlet weak var coinField: UITextField!
    @IBOutlet weak var usdField: UITextField!
    
    @IBOutlet weak var buyLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var ownedLabel: UILabel!
    @IBOutlet weak var balanceField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setPrice()
        coinField.delegate = self
        usdField.delegate = self
        balance = APIFuncs().getBalance()
        balanceLabel.text = "$"+String(format: "%.2f", balance)
        if coinID == "btc-bitcoin"{//set db to use based on coin id from segue
            dbID = "bitcoin"
            buyLabel.text = "Buy BTC"
        }else if coinID == "eth-ethereum"{
            dbID = "ethereum"
            buyLabel.text = "Buy ETH"
        }else{
            dbID = "cardano"
            buyLabel.text = "Buy ADA"
        }
        ownedLabel.text = "$"+APIFuncs().getData(id: dbID).description
        
    }
    /*private func setPrice(){
        APIFuncs().gettingFunction(name: coinID) { result in
            switch result{
            case .success(let price):
                self.coinField.text = String(format: "%.2f", price)
            case .failure(let error):
                print(error)
            
            }
        }
    }*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {//to hide keyboard
        coinField.resignFirstResponder()
        usdField.resignFirstResponder()
        return true
    }
    private func deductBalance(price: Double) -> Bool{//deduct balance based on price
        let buyAmount = Double(usdField.text!)
        if balance >= buyAmount ?? 0.0{
            balance -= buyAmount!
            APIFuncs().setBalance(balance: balance)//set balance in db
            let currentCoin = APIFuncs().getData(id: dbID)
            let newAmount = currentCoin + buyAmount!
            APIFuncs().setData(data: newAmount, id: dbID)
            return true
        }else{
            return false
        }
    }
    @IBAction func buyPressed(_ sender: Any) {
        APIFuncs().gettingFunction(name: coinID) { result in//fetch price
            switch result{
            case .success(let price):
                let response = self.deductBalance(price: price)//deduct balance
                if response {
                    APIFuncs().setData(data: price, id: self.dbID)//set new coin balance on db
                    if let coin = self.coinField.text{
                    let alert = UIAlertController(title: "Buy Success", message: "Succesfully bought \(coin)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                            _ = self.navigationController?.popViewController(animated: true)
                        }))
                    self.present(alert, animated: true)
                    }
                }
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "Buy Failed", message: "Cannot process your transaction", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    //dynamically show usd price when typing on coin text field
    @IBAction func coinChange(_ sender: Any) {
        Coinpaprika.API.ticker(id: coinID, quotes: [.usd,.btc]).perform { (response) in
            switch response{
            case .success(let ticker):
                if let text = Double(self.coinField.text!){
                let price = Double(truncating: ticker[.usd].price as NSNumber)
                let calc = text * price//calculate total price based on quantity
                print(calc)
                let str = String(format: "%.2f", calc)
                self.usdField.text = str
                }else {
                    self.usdField.text = ""
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    //dynamically show coin price when typing on usd text fields
    @IBAction func usdChange(_ sender: Any) {
        Coinpaprika.API.ticker(id: coinID, quotes: [.usd,.btc]).perform { (response) in
            switch response{
            case .success(let ticker):
                if let text = Double(self.usdField.text!){
                let price = Double(truncating: ticker[.usd].price as NSNumber)
                print(text)
                print(price)
                let total = text/price//calculate coin price per 1 usd since theres no data from fiats in api
                print(total)
                let str = String(format: "%.6f", total)
                self.coinField.text = str
                }else {
                    self.coinField.text = ""
                }
            case .failure(let error):
                print(error)
            }
            
        }    }
    
    
            
        
    }
