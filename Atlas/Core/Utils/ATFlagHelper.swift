//
//  ATFlagHelper.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

class ATFlagHelper {
    private static var flags: [ATFlag] = []
    
    public static func emoji(by code: String) -> String {
        if flags.count == 0 {
            load()
        }
        return flags.first(where: { $0.code == code })?.emoji ?? "🏴"
    }
    
    private static func load() {
        let fileName = "Flags"
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            flags = try JSONDecoder().decode([ATFlag].self, from: data)
        } catch {
            print(error)
        }
    }
}
