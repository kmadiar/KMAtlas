//
//  CountryListView.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

protocol CountryListView: ATBaseView {
    var onItemSelect: ((CountryListItem) -> ())? { get set }
}
