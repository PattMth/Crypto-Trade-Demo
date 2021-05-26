//
//  ViewController.swift
//  CryptoTracker
//
//  Created by user189998 on 5/12/21.
//

import UIKit

class CryptoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView: UITableView = {//create tableview
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        return tableView
    }()
    
    private var viewModels = [CryptoTableViewCellViewModel]() //mutable arr
    
    static let numberFormatter: NumberFormatter = {//format for each coin price
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.formatterBehavior = .default
        
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        GetCrypto.shared.getAllCryptoData {[weak self] result in //fetch data from api
            switch result {
            case .success(let coins):
                
                self?.viewModels = coins.compactMap({ coins in
                    let price = coins.price_usd ?? 0
                    let iconUrl = URL(string: GetCrypto.shared.icons.filter({ icon in
                        icon.asset_id == coins.asset_id
                    }).first?.url ?? "")
                    return CryptoTableViewCellViewModel(
                        name: coins.name ?? "N/A",
                        symbol: coins.asset_id,
                        price: CryptoListViewController.numberFormatter.string(from: NSNumber(value: price)) ?? "N/A",
                        iconUrl: iconUrl
                )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    override func viewDidLayoutSubviews() {
        
            super.viewDidLayoutSubviews()
            tableView.frame = view.bounds//set tableview to fullscreen
            
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count//set tableview length
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier,for: indexPath
        ) as? CryptoTableViewCell else {
            fatalError()
            }
        cell.configure(with: viewModels[indexPath.row])//using specific viewmodels from crypto table view cell
        return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80//increase height of each cell
    }
    }




