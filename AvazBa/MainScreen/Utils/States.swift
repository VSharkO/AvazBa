//
//  States.swift
//  AvazBa
//
//  Created by Valentin Šarić on 09/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation

enum State{
    case idle
    case pullToRefresh
    case initialRequest
    case moreArticles
    case currentlySendingRequest
    case newTabOpened
}
