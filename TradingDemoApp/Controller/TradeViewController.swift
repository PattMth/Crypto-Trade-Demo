//
//  TradeViewController.swift
//  CryptoTracker
//
//  Created by user189998 on 5/17/21.
//

import Foundation
import UIKit

class TradeViewController: UIViewController{
    var coinId = ""
    var userBalance : Float = 100000.00;
    @IBOutlet weak var balance: UILabel!
    
    @IBOutlet weak var coinName: UILabel!
    
    @IBOutlet weak var priceCoin: UILabel!
    
    override func viewDidLoad() {
        
        balance.text  = "$"+String(format: "%.2f", APIFuncs().getBalance())
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        balance.text = "$" + String(format: "%.2f", APIFuncs().getBalance())
    }
    
    //dynamically change to btc coin details if clicked
    @IBAction func btcPrice(_ sender: Any) {
        coinId = "btc-bitcoin"
        APIFuncs().gettingFunction(name: coinId) { result in// get price of following coin
            switch result {
            case .success(let price):
                self.priceCoin.text = "$"+String(format: "%.2f", price)
            case .failure(let error):
                print("Error is:", error)
            }
        }
        coinName.text = "BTC";
        
    }
    //dynamically change to eth coin details if clicked
    @IBAction func ethPrice(_ sender: Any) {
        coinId = "eth-ethereum"
        APIFuncs().gettingFunction(name: coinId) { result in//get price of following coin
            switch result {
            case .success(let price):
                self.priceCoin.text = "$"+String(format: "%.2f", price)
            case .failure(let error):
                print("Error is:", error)
            }
        }
        coinName.text = "ETH";
        
    }
    //dynamically change to ada coin details if clicked
    @IBAction func adaPrice(_ sender: Any) {
        coinId = "ada-cardano"
        APIFuncs().gettingFunction(name: coinId) { result in//get price of following coin
            switch result {
            case .success(let price):
                self.priceCoin.text = "$"+String(format: "%.2f", price)
            case .failure(let error):
                print("Error is:", error)
            }
        }
        coinName.text = "ADA";
        
    }
    
    //to make code update simpler
    @IBAction func buyCoin(_ sender: Any) {
        
    }
    //to make code update simpler
    @IBAction func sellCoin(_ sender: Any) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//get price of following coin
        if segue.identifier == "buy" {
            let VC = segue.destination as! buyViewController
            VC.coinID = coinId
            
        }else if segue.identifier == "sell"{
            let VC = segue.destination as! sellViewController
            VC.coinID = coinId
            
        }
    }
    
}
