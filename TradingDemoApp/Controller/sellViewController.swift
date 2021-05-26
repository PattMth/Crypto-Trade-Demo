//
//  sellViewController.swift
//  CryptoTracker
//
//  Created by user189998 on 5/24/21.
//

import Foundation
import UIKit
import Coinpaprika
import Parse

class sellViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var coinField: UITextField!
    @IBOutlet weak var usdField: UITextField!
    @IBOutlet weak var nameCoin: UILabel!
    @IBOutlet weak var ownedLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    var coinID = ""
    var balance: Double = 0.0
    var dbID = ""
    var amount = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        coinField.delegate = self
        usdField.delegate = self
        balance = APIFuncs().getBalance()
        balanceLabel.text = "$"+String(format: "%.2f", balance)
        if coinID == "btc-bitcoin"{
            dbID = "bitcoin"
            nameCoin.text = "Sell Bitcoin"
        }else if coinID == "eth-ethereum"{
            dbID = "ethereum"
            nameCoin.text = "Sell Ethereum"
        }else if coinID == "ada-cardano"{
            dbID = "cardano"
            nameCoin.text = "Sell Cardano"
        }
        ownedLabel.text = "$"+APIFuncs().getData(id: dbID).description

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        coinField.resignFirstResponder()
        usdField.resignFirstResponder()
        return true
    }
    private func checkBalance() -> Bool{ //check and deduct coin owned and add funds to account
        let sellAmount = Double(usdField.text!)
        let coinBalance = APIFuncs().getData(id: dbID)
        
        if (sellAmount! < coinBalance){
            let sold = coinBalance - sellAmount!
            print(sold)
            let addBalance = balance + sellAmount!
            APIFuncs().setData(data: sold, id: dbID)
            APIFuncs().setBalance(balance: addBalance)
            return true
        }
        return false
    }
    //when press sell button pop up an alert
    @IBAction func sellPressed(_ sender: Any) {
        let status = checkBalance()
        if status == true {
            let alert = UIAlertController(title: "Sell Success", message: "Successfully sold \(coinField.text) \(dbID)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
                _ = self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
            
            
        }else{
            let alert = UIAlertController(title: "Sell Failed", message: "Cannot process your transaction", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
        
    }
    //dynamically convert to usd when typing in coin price
    @IBAction func coinChange(_ sender: Any) {
        Coinpaprika.API.ticker(id: coinID, quotes: [.usd,.btc]).perform { (response) in
            switch response{
            case .success(let ticker):
                if let text = Double(self.coinField.text!){
                let price = Double(truncating: ticker[.usd].price as NSNumber)
                let calc = text * price
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
    //dynamically show bitcoin price when type in usd
    @IBAction func usdChange(_ sender: Any) {
        Coinpaprika.API.ticker(id: coinID, quotes: [.usd,.btc]).perform { (response) in
            switch response{
            case .success(let ticker):
                if let text = Double(self.usdField.text!){
                let price = Double(truncating: ticker[.usd].price as NSNumber)
                print(text)
                print(price)
                let total = text/price
                print(total)
                let str = String(format: "%.6f", total)
                self.coinField.text = str
                }else {
                    self.coinField.text = ""
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
