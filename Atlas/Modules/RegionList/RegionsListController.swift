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
    
    var itemsGroup = [RegionsListItem]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView?.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension RegionsListController: UITableViewDelegate, UITableViewDataSource {
    func refreshData() {
        guard let source = dataService else {
            return
        }
        items = source.getRegions(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let regions):
                strongSelf.items = regions.map({ RegionsListItem(name: $0.title(), code: $0.rawValue, group: false) })
            case .failure(let error):
                strongSelf.alert.show(errorMessage: error.customDescription)
            }
        }).map({ RegionsListItem(name: $0.title(), code: $0.rawValue, group: false) })
        
        itemsGroup = source.getRegionGroups(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let regionsGroup):
                strongSelf.itemsGroup = regionsGroup.map({ RegionsListItem(name: $0.title(), code: $0.rawValue, group: true) })
            case .failure(let error):
                strongSelf.alert.show(errorMessage: error.customDescription)
            }
        }).map({ RegionsListItem(name: $0.title(), code: $0.rawValue, group: false) })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sections = 0
        sections += items.count > 0 ? 1 : 0
        sections += itemsGroup.count > 0 ? 1 : 0
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return items.count
        }
        
        return itemsGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let section = (indexPath as NSIndexPath).section
        let item: RegionsListItem
        if section == 0 {
            item = items[(indexPath as NSIndexPath).row]
        } else {
            item = itemsGroup[(indexPath as NSIndexPath).row]
        }
        
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = (indexPath as NSIndexPath).section
        let item: RegionsListItem
        if section == 0 {
            item = items[(indexPath as NSIndexPath).row]
        } else {
            item = itemsGroup[(indexPath as NSIndexPath).row]
        }
        onItemSelect?(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 200, height: 50))
        label.text = section == 0 ? "Regions" : "Region Groups"
        label.textColor = .black
        view.addSubview(label)
//        view.atlas_pinAllEdgesOfSubview(subview: label)
        
        
        
        return view
    }
}
