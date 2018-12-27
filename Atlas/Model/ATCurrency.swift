//
//  ATCurrency.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

struct ATCurrency: Decodable {
    var code: String?
    var name: String?
    var symbol: String?
}

/*
{
    "code":"EUR",
    "name":"Euro",
    "symbol":"€"
}
*/
