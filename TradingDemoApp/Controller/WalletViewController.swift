//
//  WalletViewController.swift
//  CryptoTracker
//
//  Created by user189998 on 5/22/21.
//

import Foundation
import UIKit
import Coinpaprika
import Parse



class WalletViewController: UIViewController{
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var btcPriceLabel: UILabel!
    @IBOutlet weak var ethLabel: UILabel!
    @IBOutlet weak var adaLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        balance.text = "$"+String(format: "%.2f", APIFuncs().getBalance())
        setBalances()
    }
    //get datas from databases
    func setBalances(){
        btcPriceLabel.text = "$"+String(format: "%.2f", APIFuncs().getData(id: "bitcoin"))//rounded to few decimal point because of UI constrainst issues
        ethLabel.text = "$"+String(format: "%.2f", APIFuncs().getData(id: "ethereum"))//rounded to few decimal point because of UI constrainst issues
        adaLabel.text = "$"+String(format: "%.2f", APIFuncs().getData(id: "cardano"))//rounded to few decimal point because of UI constrainst issues
        
    }
    
}
