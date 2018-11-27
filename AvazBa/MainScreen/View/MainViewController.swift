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
import MaterialComponents.MaterialTabs

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MDCTabBarDelegate, LoaderManager{

    private var viewModel: MainViewModelProtocol!
    private let disposeBag = DisposeBag()
    var loaderController: UIRefreshControl?
    var loader : UIView?
    var refreshController: UIRefreshControl?
    var selectedTab = "najnovije"
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let tabBar: UIView = {
        let costumeView = UIView()
        costumeView.translatesAutoresizingMaskIntoConstraints = false
        return costumeView
    }()
    
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
        setupTabBar()
        viewModel.initGetingDataFromRepository().disposed(by: self.disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
        viewModel.moreDataRequest()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.data[indexPath.row].cellType{
        case CellType.article:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "customeCell", for: indexPath) as? CustomCell{
                let article = viewModel.data[indexPath.row] as! Article
                cell.articleText.text = article.description
                cell.setPicture(image: article.image.original)
                cell.articleTitle.text = article.title
                return cell
            }else{
                return UITableViewCell()
            }
        case CellType.loader:
                return LoaderCell()
        }
    }
    
    func tabBar(_ tabBar: MDCTabBar, willSelect item: UITabBarItem) {
        if let title = item.title{
            switch title {
            case "Najnovije":
                selectedTab = "najnovije"
                viewModel.selectedTab = "najnovije"
            case "Najčitanije":
                selectedTab = "najcitanije"
                viewModel.selectedTab = "najcitanije"
            default:
                selectedTab = "najnovije"
                viewModel.selectedTab = "najnovije"
            }
            viewModel.moreDataRequest()
            refreshData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(viewModel.data.count != 0){
            if Double(indexPath.row) >= Double(viewModel.data.count-1) * 0.9{
                viewModel.moreDataRequest()
            }
        }
    }
    
    private func registerCells(){
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "customeCell")
        self.tableView.register(LoaderCell.self, forCellReuseIdentifier: "loaderCell")
    }
    
    func initSubscripts(){
        viewModel.viewReloadData.observeOn(MainScheduler.instance).subscribe(onNext:{ _ in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.viewShowLoader.observeOn(MainScheduler.instance).subscribe(onNext:{ isActive in
            if isActive{
                self.displayLoader()
            }else{
                self.hideLoader()
            }
        }).disposed(by: disposeBag)
        
        viewModel.viewInsertRows.observeOn(MainScheduler.instance).subscribe(onNext:{
            indexes in
            self.tableView.performBatchUpdates({
                self.tableView.insertRows(at: indexes, with: .automatic)
                })
        }).disposed(by: disposeBag)
        
        viewModel.viewReloadRows.observeOn(MainScheduler.instance).subscribe(onNext:{ indexes in
            self.tableView.performBatchUpdates({
                 self.tableView.reloadRows(at: indexes, with: .automatic)
            }, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    private func setupViews(){
        self.view.addSubview(tabBar)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraints()
    }
    
    private func setupTabBar(){
        let tabBar = MDCTabBar(frame: self.tabBar.bounds)
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
        tabBar.items = [
            UITabBarItem(title: "Najnovije", image: nil, tag: 0),
            UITabBarItem(title: "Najčitanije", image: nil, tag: 0),
        ]
        tabBar.itemAppearance = .titles
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor.red
        tabBar.alignment = .justified
        tabBar.setTitleColor(UIColor.black, for: .normal)
        tabBar.setTitleColor(UIColor.black, for: .selected)
        tabBar.delegate = self
        self.tabBar.addSubview(tabBar)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 48)
            ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tabBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
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
