//
//  CountryDetailController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit
import MapKit

final class CountryDetailController: ATRootViewController, CountryDetailView {
    //controller handler
    var onItemSelect: ((CountryListItem) -> ())?
    
//    var dataService: ATDataService? {
//        didSet {
//            refreshData()
//        }
//    }
    var details: CountryDetails? {
        didSet {
            title = details?.name
            refreshData()
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
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        refreshData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension CountryDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func refreshData() {
        guard let d = details else {
            return
        }
        
        items = d.items
        let lat = d.location[0]
        let lon = d.location[1]
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0))
        
        mapView?.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        mapView?.addAnnotation(annotation)
        
        flagLabel?.text = d.flag
        moneyLabel?.text = d.currency
        languageLabel?.text = d.languages
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
