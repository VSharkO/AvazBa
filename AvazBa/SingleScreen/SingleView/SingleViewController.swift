//
//  SingleViewController.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
import RxSwift

class SingleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LoaderManager{
    
    var viewModel: SingleViewModelProtocol!
    weak var singleDelegate: CoordinatorDelegate?
    private let disposeBag = DisposeBag()
    var loader : UIView?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: SingleViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        viewModel.initGetingDataFromRepository().disposed(by: self.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        registerCells()
        setupViews()
        setupConstraints()
        initSubscripts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getSpecificArticle()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.data[indexPath.row].cellType{
        case SingleArticleCellTypes.image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell{
                if let imageLink = viewModel.data[0].data as! String?{
                    cell.setImage(image: imageLink)
                }
                return cell
            }else{
                return UITableViewCell()
            }
        default: return UITableViewCell()
        }
    }
    
    private func setupViews(){
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCells(){
        self.tableView.register(ImageCell.self, forCellReuseIdentifier: "imageCell")
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
    }
    
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func displayLoader() {
        loader = displayLoader(onView: self.view)
    }
    
    func hideLoader() {
        if let loader = loader{
            removeLoader(loader: loader)
        }
    }
}

