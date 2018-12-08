//
//  SingleViewController.swift
//  AvazBa
//
//  Created by Valentin Šarić on 05/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import UIKit
import RxSwift

class SingleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var viewModel: SingleViewModelProtocol!
    weak var singleDelegate: CoordinatorDelegate?
    private let disposeBag = DisposeBag()
    
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
        super.viewDidLoad()
        registerCells()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getSpecificArticle()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
    }
    
    private func registerCells(){
        self.tableView.register(ImageCell.self, forCellReuseIdentifier: "imageCell")
    }
}

