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

class MainViewController: UITableViewController, LoaderManager {

    private var viewModel: MainViewModelProtocol!
    private let disposeBag = DisposeBag()
    var loaderController: UIRefreshControl?
    var loader : UIView?
    var refreshController: UIRefreshControl?
   
    
    init(viewModel: MainViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        registerCells()
        initSubscripts()
        setupRefreshControl()
        viewModel.initGetingDataFromRepository().disposed(by: self.disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.moreDataRequest()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customeCell", for: indexPath) as? CustomCell{
            let article = viewModel.data[indexPath.row]
            cell.articleText.text = article.description
            cell.setPicture(image: article.image.original)
            cell.articleTitle.text = article.title
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(viewModel.data.count != 0){
            if Double(indexPath.row) >= Double(viewModel.data.count) * 0.85 {
                viewModel.moreDataRequest()
            }
        }
    }
    
    private func registerCells(){
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "customeCell")
        self.tableView.register(LoaderCell.self, forCellReuseIdentifier: "loaderCell")
    }
    
    func initSubscripts(){
        viewModel.viewReloadData.subscribe { _ in
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.viewShowLoader.subscribe{ isActive in
            if isActive.element!{
                self.displayLoader()
            }else{
                self.hideLoader()
            }
        }.disposed(by: disposeBag)
    }
    
    private func setupRefreshControl(){
        refreshController = UIRefreshControl()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshController
        } else {
            self.tableView.addSubview(refreshController!)
        }
        refreshController?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func displayLoader() {
        loader = displayLoader(onView: self.view)
    }
    
    func hideLoader() {
        if let loader = loader{
            removeLoader(loader: loader)
        }
        hideSpinner()
    }
    
    func hideSpinner(){
        refreshController?.endRefreshing()
    }
    
    @objc func refreshData(){
        viewModel.pullToRefresh()
    }

}
