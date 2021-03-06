//
//  MainCoordinatorDelegate.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

protocol MainCoordinatorDelegate: CoordinatorDelegate {
    func openNextScreen(ids: [Int], focusedItem: Int)
}
