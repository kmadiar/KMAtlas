//
//  RegionsListViewController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//
import UIKit

final class RegionsListController: ATRootViewController, RegionsListView {
    
    //controller handler
    var onItemSelect: ((RegionsListItem) -> ())?
    
    var dataService: ATDataService? {
        didSet {
            refreshData()
        }
    }
    
    var items = [RegionsListItem]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView?.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Regions"
    }
}

extension RegionsListController: UITableViewDelegate, UITableViewDataSource {
    
    func refreshData() {
        if let source = dataService {
            items = source.getRegions(completion: { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let regions):
                    strongSelf.items = regions.map({ RegionsListItem(name: $0.title(), code: $0.rawValue, group: false) })
                case .failure(let error):
                    strongSelf.alert.show(errorMessage: error.customDescription)
                }
            }).map({ RegionsListItem(name: $0.title(), code: $0.rawValue, group: false) })
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = item.name
//        cell.detailTextLabel?.text = item.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onItemSelect?(items[(indexPath as NSIndexPath).row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
