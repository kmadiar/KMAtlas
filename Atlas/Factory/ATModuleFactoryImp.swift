//
//  ATModuleFactoryImp.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

final class ATModuleFactoryImp: ATModuleFactory {
    func makeRegions(dataService: ATDataService) -> RegionsListView {
        let vc = RegionsListController.atlas_controllerFromStoryboard(.regions)
        vc.dataService = dataService
        
        return vc
    }
}
