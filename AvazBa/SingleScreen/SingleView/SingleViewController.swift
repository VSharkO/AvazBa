//
//  SingleViewController.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
import RxSwift

class SingleViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource */{
    
    var viewModel: SingleViewModelProtocol!
    weak var singleDelegate: CoordinatorDelegate?
    private let disposeBag = DisposeBag()
    
    let proba: UITextView = {
        let title = UITextView()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
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
        super.viewDidLoad()
        setupView()
        viewModel.getSpecificArticle()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
//    private func registerCells(){
//        self.tableView.register(SingleImageCell.self, forCellReuseIdentifier: "imageCell")
//        self.tableView.register(SingleTitleCell.self, forCellReuseIdentifier: "titleCell")
//        return viewModel.data.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
    func setupView(){
        self.view.addSubview(proba)
        
        NSLayoutConstraint.activate([
            proba.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5),
            proba.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            proba.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            proba.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5)
            ])
    }
}
