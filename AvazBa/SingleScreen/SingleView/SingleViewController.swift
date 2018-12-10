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
        tableView.separatorStyle = .none
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
        viewModel.getSpecificArticle()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.0
        case 1:
            return 47.0
        default:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.data.count > 0{
            switch section{
            case 0:
                return viewModel.data[0].count
            case 1:
                    return viewModel.data[1].count
                //        case 2:
            //            return viewModel.data[2].count
            default: return 0
            }
        }else{
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section{
        case 0:
            return nil
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "relatedTitle", for: IndexPath(item: 0, section: section)) as? RelatedTitleCell{
                cell.relatedTitle.text = "Povezano"
                return cell
            }else{
                return UITableViewCell()
            }
        default: return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.data[indexPath.section][indexPath.row].cellType{
        case SingleArticleCellTypes.image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageCell{
                if let imageLink = viewModel.data[indexPath.section][indexPath.row].data as! String?{
                    cell.setImage(image: imageLink)
                    cell.layoutMargins = UIEdgeInsets.zero
                }
                return cell
            }else{
                return UITableViewCell()
            }
        case SingleArticleCellTypes.upperTitle:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "upperTitle", for: indexPath) as? UpperTitleCell{
                if let upperTitle = viewModel.data[indexPath.section][indexPath.row].data as! String?{
                    cell.articleUpperTitle.text = upperTitle
                    cell.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
                }
                return cell
            }else{
                return UITableViewCell()
            }
        case SingleArticleCellTypes.title:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as? TitleCell{
                if let title = viewModel.data[indexPath.section][indexPath.row].data as! String?{
                    cell.articleTitle.text = title
                }
                return cell
            }else{
                return UITableViewCell()
            }
        case SingleArticleCellTypes.text:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "text", for: indexPath) as? TextCell{
                if let text = viewModel.data[indexPath.section][indexPath.row].data as! String?{
                    cell.articleText.text = text.htmlToString
                    cell.layoutSubviews()
                }
                return cell
            }else{
                return UITableViewCell()
            }
//        case SingleArticleCellTypes.relatedNews:
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "relatedNews", for: indexPath) as? RelatedArticleCell{
//                if let relatedArticle = viewModel.data[indexPath.section][indexPath.row].data as! Article?{
//                    cell.setImage(image: relatedArticle.image.original)
//                    cell.layoutSubviews()
//                }
//                return cell
//            }else{
//                return UITableViewCell()
//            }
        default: return UITableViewCell()
        }
    }
    
    private func setupViews(){
        self.view.addSubview(tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCells(){
        self.tableView.register(ImageCell.self, forCellReuseIdentifier: "imageCell")
        self.tableView.register(UpperTitleCell.self, forCellReuseIdentifier: "upperTitle")
        self.tableView.register(TitleCell.self, forCellReuseIdentifier: "title")
        self.tableView.register(TextCell.self, forCellReuseIdentifier: "text")
        self.tableView.register(RelatedTitleCell.self, forCellReuseIdentifier: "relatedTitle")
        self.tableView.register(RelatedArticleCell.self, forCellReuseIdentifier: "relatedNews")
    }
    
    private func initSubscripts(){
        viewModel.viewReloadData.observeOn(MainScheduler.instance).subscribe(onNext:{ _ in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.viewShowLoader.observeOn(MainScheduler.instance).subscribe(onNext:{ isActive in
            if isActive{
                self.showLoader()
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
    
    func showLoader() {
        loader = displayLoader(onView: self.view)
        loader?.backgroundColor = .gray
    }
    
    func hideLoader() {
        if let loader = loader{
            removeLoader(loader: loader)
        }
    }
}

