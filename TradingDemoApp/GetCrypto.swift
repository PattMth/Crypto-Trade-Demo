//
//  GetCrypto.swift
//  CryptoTracker
//
//  Created by user189998 on 5/12/21.
//

import Foundation

final class GetCrypto {
    static let shared = GetCrypto()
   
    
    private init() {}
    
    public var icons: [Logo] = []
    
    private var blockIcon: ((Result<[Coins], Error>) -> Void)?
   
    
    public func getAllCryptoData(completionHandler: @escaping (Result<[Coins], Error>) -> Void)//func to fetch api datas
    {//check if icon empty
        guard !icons.isEmpty else {
            blockIcon =  completionHandler
            return
        }
        //set api url
        guard let url = URL(string: "https://rest-sandbox.coinapi.io/v1/assets/?apikey=C26A6674-30DF-4F20-A5D2-EC656AB42DF4") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in//data task to fetch api
            guard let data = data, error == nil else {
                return
            
            }
            do{
                let cryptos = try JSONDecoder().decode([Coins].self , from: data)//decode api json
                print(cryptos)
                let sorted = cryptos.sorted{first, second -> Bool in//sort by price
                    return first.price_usd ?? 0 > second.price_usd ?? 0
                }
                completionHandler(.success(sorted))
            }
            catch{
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
   
    //get the icons of each coin
    public func getAllIcons() {

        guard let url = URL(string: "https://rest-sandbox.coinapi.io/v1/assets/icons/55/?apikey=C26A6674-30DF-4F20-A5D2-EC656AB42DF4") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            
            }
            do{
                self?.icons = try JSONDecoder().decode([Logo].self , from: data)
                if let completion = self?.blockIcon{
                    self?.getAllCryptoData(completionHandler: completion)
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }}
