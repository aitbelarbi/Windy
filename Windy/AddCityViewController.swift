//
//  AddCityViewController.swift
//  Windy
//
//  Created by ait belarbi mohamed amine on 18/01/2021.
//

import UIKit
import WindyDataSDK

final class AddCityViewController: UIViewController {

    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        }
    }
    
    private var allCities: CitiesModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    private func getCities(text: String) {
        let service = WindyService()
        service.getCities(prefix: text, success: { [weak self] allCities in
            self?.allCities = allCities
        })
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Voulez-vous ajouter cette ville ?", message: nil, preferredStyle: .alert)
        let alertActionAbout = UIAlertAction(title: "Ajouter", style: .default, handler: { _ in

        })
        let alertActionCancel = UIAlertAction(title: "Annuler", style: .cancel, handler: {
            action in })
        alert.addAction(alertActionAbout)
        alert.addAction(alertActionCancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension AddCityViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        hideEmptyState()
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            getCities(text: searchText)
        }
    }
}


extension AddCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCities?.cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel?.text = allCities?.cities?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert()
    }
}
