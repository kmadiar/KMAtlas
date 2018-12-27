//
//  SearchListController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/27/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit
import RxSwift

final class SearchListController: ATRootViewController, SearchListView {
    //controller handler
    var onItemSelect: ((CountryListItem) -> ())?
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar { return searchController.searchBar }
    
    var viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setToolbarHidden(true, animated: false)
        
        configureSearchController()
        
        viewModel.data
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { _, listItem, cell in
                guard let cell = cell as? CountryListTableViewCell else { return }
                cell.leftLabel.text = listItem.countryFlag
                cell.topLabel.text = listItem.name
            }.disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        viewModel.data.asDriver()
            .map { "\($0.count) matches found" }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CountryListItem.self)
            .subscribe(onNext: { [weak self] item in
                self?.onItemSelect?(item)
            }).disposed(by: disposeBag)
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] index in
                self?.tableView?.deselectRow(at: index, animated: false)
            }).disposed(by: disposeBag)
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = ""
        searchBar.placeholder = "Enter Country Name"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}
