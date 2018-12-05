//
//  SingleViewController.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource */{
    
    var viewModel: SingleViewModelProtocol!
    weak var singleDelegate: CoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: SingleViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func registerCells(){
//        self.tableView.register(SingleImageCell.self, forCellReuseIdentifier: "imageCell")
//        self.tableView.register(SingleTitleCell.self, forCellReuseIdentifier: "titleCell")
//        return viewModel.data.count
//    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
    
}
