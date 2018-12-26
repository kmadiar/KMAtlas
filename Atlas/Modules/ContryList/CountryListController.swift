//
//  CountryListViewController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

final class CountryListController: ATRootViewController, CountryListView {
    //controller handler
    var onItemSelect: ((CountryListItem) -> ())?
    
    var dataService: ATDataService? {
        didSet {
            refreshData()
        }
    }
    var params: CountryListParam? {
        didSet {
            refreshData()
            title = params?.name
        }
    }
    
    var items = [CountryListItem]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView?.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension CountryListController: UITableViewDelegate, UITableViewDataSource {
    
    func refreshData() {
        guard let source = dataService, let p = params else {
            return
        }
        
        let finish: (ATResult<[ATCountry], ATAPIError>) -> () = { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let countries):
                strongSelf.items = countries.map({ CountryListItem(countryFlag: $0.flag, name: $0.name, nativeName: $0.nativeName) })
            case .failure(let error):
                strongSelf.alert.show(errorMessage: error.customDescription)
            }
        }
        
        var countries: [ATCountry] = []
        
        if let rid = p.regionId {
            guard let region = ATRegion(rawValue: rid) else { return }
            countries = source.getCountries(by: region, completion: { result in
                finish(result)
            })
        } else if let rgid = p.regionGroupId {
            guard let regionGroup = ATRegionGroup(rawValue: rgid) else { return }
            countries = source.getCountries(by: regionGroup, completion: { result in
                finish(result)
            })
        }
        
        items = countries.map({ CountryListItem(countryFlag: $0.flag, name: $0.name, nativeName: $0.nativeName) })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CountryListTableViewCell
        let item = items[(indexPath as NSIndexPath).row]
        cell.topLabel.text = item.name
        cell.bottomLabel.text = item.nativeName
        cell.leftLabel.text = item.countryFlag
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onItemSelect?(items[(indexPath as NSIndexPath).row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
