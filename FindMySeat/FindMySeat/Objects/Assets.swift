//
//  Assets.swift
//  FindMySeat
//
//  Created by Anthony on 23/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import SpriteKit

protocol AssetsDelegate{
    func assetCreated(thisAsset : Asset)
}

class Assets{
    var set : [Asset]! = [Asset]()
    var cells : Cells
    var delegates = [AssetsDelegate]()
    
    init(cells : Cells, delegate : AssetsDelegate?){
        self.cells = cells
        if delegate != nil{
            self.delegates.append(delegate!)
        }
        
        self.createMyAssets()
    }
    
    private func createMyAssets(){
        if let cell = self.cells.getCell(id: 10){
            self.addAsset(type: AssetType.myondiek, cell: cell)
        }
        //
//        var cellRows = self.cells.getRowCells(row: 0)
//        cellRows.append(contentsOf: self.cells.getRowCells(row: 1))
//        for each in cellRows{
//            self.addAsset(type: AssetType.myondiek, cell: each)
//        }
    }
    
    private func addAsset(type : AssetType, cell : Cell){
        let asset = Asset(type: type, cell: cell)
        self.set.append(asset)

        for each in self.delegates{
            each.assetCreated(thisAsset: asset)
        }
    }
}
