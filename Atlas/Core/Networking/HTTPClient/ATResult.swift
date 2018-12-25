//
//  ATResult.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//
import Foundation

enum ATResult<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
