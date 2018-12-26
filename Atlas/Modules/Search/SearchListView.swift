//
//  SearchListView.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/27/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

protocol SearchListView: ATBaseView {
    var onItemSelect: ((CountryListItem) -> ())? { get set }
}
