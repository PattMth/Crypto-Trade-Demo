//
//  CoinPaprikaFunc.swift
//  CryptoTracker
//
//  Created by user189998 on 5/23/21.
//

import Foundation
import Coinpaprika
import Parse

class APIFuncs {//class for db and api functions
    public func gettingFunction(name: String, _ completion: @escaping (Result<Double, Error>) -> Void) {//get price of inputted coin name in parameter
    
        Coinpaprika.API.ticker(id: name, quotes: [.usd]).perform { (response) in
            switch response{
            case .success(let ticker):
                let double = Double(truncating: ticker[.usd].price as NSNumber)
                completion(.success(double))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    public func getPriceAndChange(name: String, time: Int, _ completion: @escaping (Result<Double, Error>) -> Void) {//get price and gain loss
    
        Coinpaprika.API.ticker(id: name, quotes: [.usd]).perform { (response) in
            switch response{
            case .success(let ticker):
                var double: Double
                switch time {
                case 1:
                    double = Double(truncating: ticker[.usd].percentChange1h as NSNumber)
                    completion(.success(double))
                case 12:
                    double = Double(truncating: ticker[.usd].percentChange12h as NSNumber)
                    completion(.success(double))
                case 24:
                    double = Double(truncating: ticker[.usd].percentChange24h as NSNumber)
                    completion(.success(double))
                case 7:
                    double = Double(truncating: ticker[.usd].percentChange7d as NSNumber)
                    completion(.success(double))
                case 30:
                    double = Double(truncating: ticker[.usd].percentChange30d as NSNumber)
                    completion(.success(double))
                default:
                    double = Double(truncating: ticker[.usd].percentChange1h as NSNumber)
                    completion(.success(double))                    
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    public func setBalance(balance: Double){//set balance of current logged user
        if let currentUser = PFUser.current(){
            currentUser["Balance"] = balance.description
            currentUser.saveInBackground()
        }
    }
    public func getBalance() -> Double {//get balance of current logged user
        if let currentUser = PFUser.current(){
            if let parsedBalance = Double(currentUser["Balance"] as! String){
                return parsedBalance
            }
        }
        return 0.0
    }
   
    public func setData(data: Double,id: String){//to set other collumn in db
        if let currentUser = PFUser.current(){
            currentUser["\(id)"] = data.description
            currentUser.saveInBackground()
        }
    }
    
    public func getData(id: String) -> Double{//to get other collumn datas in db
        if let currentUser = PFUser.current(){
            if let data = Double(currentUser["\(id)"] as! String){
            print(data)
            return data
        }
      }
        return 0.0
    }
    
    public func getString(id: String) -> String{//string type of get data
        if let currentUser = PFUser.current(){
            if let data = currentUser["\(id)"] as? String {
                return data
            }
            
        }
        return "N/A"
    }
}
