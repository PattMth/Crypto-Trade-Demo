//
//  MainViewController.swift
//  CryptoTracker
//
//  Created by user189998 on 5/17/21.
//
import UIKit
import Foundation

class MainViewController: UIViewController{
    @IBOutlet weak var btcPrice: UILabel!
    @IBOutlet weak var ethPrice: UILabel!
    @IBOutlet weak var adaPrice: UILabel!
    @IBOutlet weak var btcChange: UILabel!
    @IBOutlet weak var ethChange: UILabel!
    @IBOutlet weak var adaChange: UILabel!
    @IBOutlet weak var daySegement: UISegmentedControl!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var btcBg: UILabel!
    @IBOutlet weak var ethBg: UILabel!
    @IBOutlet weak var adaBg: UILabel!
    @IBOutlet weak var tradeBtn: UIButton!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAll(times: 1)
        let name = APIFuncs().getString(id: "username")
        welcomeLabel.text = "Welcome, \(name)"
        
        
    }
    private func setupUI(){// make visual update to ui
        btcBg?.layer.masksToBounds = true
        btcBg.layer.cornerRadius = 20.0
        ethBg?.layer.masksToBounds = true
        ethBg.layer.cornerRadius = 20.0
        adaBg?.layer.masksToBounds = true
        adaBg.layer.cornerRadius = 20.0
        tradeBtn.layer.cornerRadius = 20.0
    }
    //get prices and profit gain/loss for BTC
    private func setupPriceBTC(time: Int){
        APIFuncs().gettingFunction(name: "btc-bitcoin") { result in// set price of btc
            switch result{
            case .success(let price):
                self.btcPrice.text = "$"+String(format: "%.2f", price)
            case .failure(let error):
                print(error)
            
            }
        }
    
        APIFuncs().getPriceAndChange(name: "btc-bitcoin", time: time) { result in//set profit gain and loss for btc
            switch result{
            case .success(let change):
                if change < 0.0{
                    self.btcChange.textColor = .red
                }else{
                    self.btcChange.textColor = .green
                }
                self.btcChange.text = String(format: "%.2f", change)+"%"
                if self.btcChange.textColor == .green{
                    self.btcChange.text = "+" + self.btcChange.text!
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    //get prices and profit gain/loss for ETH
    private func setupPriceETH(time: Int){
        APIFuncs().gettingFunction(name: "eth-ethereum") { result in// set price of eth
            switch result{
            case .success(let price):
                self.ethPrice.text = "$"+String(format: "%.2f", price)
            case .failure(let error):
                print(error)
            
            }
        }
    
        APIFuncs().getPriceAndChange(name: "eth-ethereum", time: time) { result in// set profit gain and loss of eth
            switch result{
            case .success(let change):
                if change < 0.0{
                    self.ethChange.textColor = .red
                }else{
                    self.ethChange.textColor = .green
                }
                self.ethChange.text = String(format: "%.2f", change)+"%"
                if self.ethChange.textColor == .green{
                    self.ethChange.text = "+" + self.ethChange.text!
                }            case .failure(let error):
                print(error)
            }
        }
    }
    //get prices and profit gain/loss for ADA
    private func setupPriceADA(time: Int){
        APIFuncs().gettingFunction(name: "ada-cardano") { result in// set price of ada
            switch result{
            case .success(let price):
                self.adaPrice.text = "$"+String(format: "%.2f", price)
            case .failure(let error):
                print(error)
            
            }
        }
    
        APIFuncs().getPriceAndChange(name: "ada-cardano", time: time) { result in// set profit gain and loss of ada
            switch result{
            case .success(let change):
                if change < 0.0{
                    self.adaChange.textColor = .red
                }else{
                    self.adaChange.textColor = .green
                }
                self.adaChange.text = String(format: "%.2f", change)+"%"
                if self.adaChange.textColor == .green{
                    self.adaChange.text = "+" + self.adaChange.text!
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    private func setupAll(times: Int){
        setupPriceBTC(time: times)
        setupPriceETH(time: times)
        setupPriceADA(time: times)
        
    }
    //using segment to show different times of profit gain and loss
    @IBAction func changeSegment(_ sender: Any) {
        switch daySegement.selectedSegmentIndex {
        case 0:
            setupAll(times: 1)
        case 1:
            setupAll(times: 12)
        case 2:
            setupAll(times: 24)
        case 3:
            setupAll(times: 7)
        case 4:
            setupAll(times: 30)
        default:
            break
        }
    }
}
