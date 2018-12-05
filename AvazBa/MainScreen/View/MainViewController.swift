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
    var mainCoordinatorDelegate: MainCoordinatorDelegate?
    
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
        viewModel.initGetingDataFromRepository().disposed(by: self.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupViews()
        registerCells()
        initSubscripts()
        setupRefreshControl()
        setupTabBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                cell.publishedText.text = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: article.publishedAt.date, currentDate: Date())
                cell.shareNumText.text = String(article.shares)
                return cell
            }else{
                return UITableViewCell()
            }
        case CellType.loader:
                return LoaderCell()
        }
    }
    
    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
        if let title = item.title{
            switch title {
            case constants.newest:
                viewModel.selectedTab = constants.newestApi
            case constants.mostRead:
                viewModel.selectedTab = constants.mostReadApi
            default:
                viewModel.selectedTab = constants.newestApi
            }
            viewModel.newTabOpened()
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
            if Double(indexPath.row) >= Double(viewModel.data.count-1){
                viewModel.moreDataRequest()
            }
        }
    }
    
    private func registerCells(){
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "customeCell")
        self.tableView.register(LoaderCell.self, forCellReuseIdentifier: "loaderCell")
    }
    
    private func initSubscripts(){
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
        
        viewModel.viewReloadRowsForNewTab.observeOn(MainScheduler.instance).subscribe(onNext:{ (numOfArticlesToAdd,numOfArticlesToDelete) in
            self.tableView.performBatchUpdates({
                var arrayOfIndexPathsToDelete = [IndexPath]()
                for element in Array(numOfArticlesToAdd..<numOfArticlesToDelete){
                    arrayOfIndexPathsToDelete.append(IndexPath.init(row: element, section: 0))
                }
                var arrayOfIndexPathsToAdd = [IndexPath]()
                for element in Array(0..<numOfArticlesToAdd){
                    arrayOfIndexPathsToAdd.append(IndexPath.init(row: element, section: 0))
                }
                self.tableView.deleteRows(at: arrayOfIndexPathsToDelete, with: .automatic)
                self.tableView.reloadRows(at: arrayOfIndexPathsToAdd, with: .automatic)
            }, completion: { isFinished in
                if isFinished{
                    let indexPath = IndexPath(row: 0, section:  0)
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                }
            })
        }).disposed(by: disposeBag)
    }
    
    private func setupViews(){
        self.view.backgroundColor = .white
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
            UITabBarItem(title: constants.newest, image: nil, tag: 0),
            UITabBarItem(title: constants.mostRead, image: nil, tag: 0),
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
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tabBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
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
    
    @objc func moveToSingleScreenWithIndex(clickedNews: Int){
        var ids : [Int] = []
        for article in viewModel.data{
            if let currentArticle = article as? Article{
                ids.append(currentArticle.id)
            }
        }
        mainCoordinatorDelegate?.openNextScreen(ids: ids, focusedItem: clickedNews)
    }

}
