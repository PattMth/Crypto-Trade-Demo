//
//  GetSomeCrypto.swift
//  CryptoTracker
//
//  Created by user189998 on 5/22/21.
//

import Foundation

final class GetSomeCrypto{
    static let shared = GetSomeCrypto()
    
    private init () {}

public func getSomeCryptoData(completionHandler: @escaping (Result<[simpleCoin], Error>) -> Void)
{
    guard let url = URL(string: "https://rest-sandbox.coinapi.io/v1/assets/BTC,ETH,ADA?apikey=C26A6674-30DF-4F20-A5D2-EC656AB42DF4") else {
        return
    }
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else {
            return
        
        }
        do{
            let cryptos = try JSONDecoder().decode([simpleCoin].self , from: data)
            let sorted = cryptos.sorted{first, second -> Bool in
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
}
