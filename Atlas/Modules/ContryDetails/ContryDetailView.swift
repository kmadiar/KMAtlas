//
//  ContryDetailView.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

protocol CountryDetailView: ATBaseView {
    var details: CountryDetails? { get set }
    var onItemSelect: ((CountryListItem) -> ())? { get set }
    var onBack: (() -> ())? { get set }
}
