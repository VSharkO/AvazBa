//
//  SingleData.swift
//  AvazBa
//
//  Created by Valentin Šarić on 16/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

class SingleData{
    var articleSection = [Cell]()
    var relatedSection = [Cell]()
    var mostReadSection = [Cell]()
    
    func getNumberOfItemsInSection(section : Int) -> Int{
        switch section{
        case 0:
            return articleSection.count
        case 1:
            if relatedSection.count > 0{
                return relatedSection.count
            }else{
                return mostReadSection.count
            }
        case 2:
            return mostReadSection.count
        default: return 0
        }
    }
    
    func addItem(item: Cell){
        switch item.cellType {
        case SingleArticleCellTypes.mostReadNews:
            mostReadSection.append(item)
        case SingleArticleCellTypes.relatedNews:
            relatedSection.append(item)
        default:
            articleSection.append(item)
        }
    }
    
    func getNumberOfSections() -> Int{
        if articleSection.count > 0 && mostReadSection.count > 0{
            if relatedSection.count > 0{
                return 3
            }else{
                return 2
            }
        }else{
            return 0
        }
    }
    
    func getItem(section: Int, row: Int) -> Cell{
        switch section{
        case 0:
            return articleSection[row]
        case 1:
            if relatedSection.count > 0{
                return relatedSection[row]
            }else{
                return mostReadSection[row]
            }
        case 2:
            return mostReadSection[row]
        default:
            return Cell(cellType: SingleArticleCellTypes.noCell, data: nil)
        }
    }
}
