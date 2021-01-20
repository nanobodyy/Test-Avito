//
//  DataModel.swift
//  Test
//
//  Created by Гурген on 16.01.2021.
//

import Foundation
import UIKit

struct Screen {
    var title, actionTitle, selectedActionTitle: String
    var cellItem: [CellItem] = []
    
    init?(screenData: Welcome) {
        self.title = screenData.result.title
        self.actionTitle = screenData.result.actionTitle
        self.selectedActionTitle = screenData.result.selectedActionTitle
        
        for index in screenData.result.list {
            DispatchQueue.main.sync {

            let imageView = UIImageView()
            guard let url = URL(string: index.icon.the52X52),
                  let data = try? Data(contentsOf: url) else {return}
            imageView.image = UIImage(data: data)
            
            if index.isSelected == true {
                self.cellItem.append(CellItem(title: index.title, price: index.price, listDescription: index.listDescription, icon: imageView))
            }
            
            }
        }
    }
}


struct CellItem {
    let title: String
    let price: String
    let listDescription: String?
    var icon: UIImageView
    var isSelected = true
    
}
