//
//  MainViewController.swift
//  AvazBa
//
//  Created by Valentin Šarić on 16/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class MainViewController: UITableViewController {

    private var viewModel: MainViewModelProtocol!
    private let disposeBag = DisposeBag()
    
    init(viewModel: MainViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    override func viewDidLoad() {
        registerCells()
        initSubscripts()
        viewModel.initGetingDataFromRepository().disposed(by: self.disposeBag)
        viewModel.dataRequestTrigered(pageNum: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customeCell", for: indexPath) as? CustomCell{
            let article = viewModel.getData()[indexPath.row]
            cell.articleText.text = article.description
            cell.setPicture(image: article.image.original)
            cell.articleTitle.text = article.title
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    private func registerCells(){
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "customeCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getData().count
    }
    
    func initSubscripts(){
        viewModel.viewReloadData.subscribe { _ in
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    

}
