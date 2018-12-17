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
    weak var singleCoordinatorDelegate: SingleCoordinatorDelegate?
    private let disposeBag = DisposeBag()
    var loader : UIView?
    
    enum Section: Int{
        case thisSpecificArticle = 0 ,relatedArticles, mostReadArticles
    }
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
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
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case Section.thisSpecificArticle.rawValue:
            return 0.0
        default:
            return 47.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.data.count > 0{
            return viewModel.data[section].count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if viewModel.data.count > 0{
        switch section{
        case Section.thisSpecificArticle.rawValue:
            return nil
        case Section.relatedArticles.rawValue:
            if viewModel.data[section][0].cellType == SingleArticleCellTypes.relatedNews, let cell = tableView.dequeueReusableCell(withIdentifier: "\(RelatedTitleCell.self)", for: IndexPath(item: 0, section: section)) as? RelatedTitleCell{
                cell.relatedTitle.text = Constants.related
                return cell
            }else if let cell = tableView.dequeueReusableCell(withIdentifier: "\(RelatedTitleCell.self)", for: IndexPath(item: 0, section: section)) as? RelatedTitleCell{
                cell.relatedTitle.text = Constants.mostRead
                return cell
            }
            else{
                return nil
            }
        case Section.mostReadArticles.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(RelatedTitleCell.self)", for: IndexPath(item: 0, section: section)) as? RelatedTitleCell{
                cell.relatedTitle.text = Constants.mostRead
                return cell
            }else{
                return UITableViewCell()
            }
        default: return nil
            }
        }else{
            return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.data[indexPath.section][indexPath.row].cellType{
        case SingleArticleCellTypes.image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageCell.self)", for: indexPath) as? ImageCell{
                if let article = viewModel.data[indexPath.section][indexPath.row].data as? SpecificArticle{
                    cell.setImage(image: article.featuredImage.xxl)
                    cell.categoryText.text = article.category.capitalized
                    cell.setupImageSource(description: article.imageSource)
                    cell.setupImageDescription(description: article.imageDescription)
                }
                return cell
            }else{
                return UITableViewCell()
            }
        case SingleArticleCellTypes.upperTitle:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(UpperTitleCell.self)", for: indexPath) as? UpperTitleCell{
                if let upperTitle = viewModel.data[indexPath.section][indexPath.row].data as? String{
                    cell.articleUpperTitle.text = upperTitle
                    cell.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
                }
                return cell
            }else{
                return UITableViewCell()
            }
        case SingleArticleCellTypes.title:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(TitleCell.self)", for: indexPath) as? TitleCell{
                if let title = viewModel.data[indexPath.section][indexPath.row].data as? String{
                    cell.articleTitle.text = title
                }
                return cell
            }else{
                return UITableViewCell()
            }
        case SingleArticleCellTypes.text:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(TextCell.self)", for: indexPath) as? TextCell{
                if let text = viewModel.data[indexPath.section][indexPath.row].data as? String{
                    cell.articleText.text = text.htmlToString
                }
                return cell
            }else{
                return UITableViewCell()
            }
        case SingleArticleCellTypes.relatedNews:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(RelatedArticleCell.self)", for: indexPath) as? RelatedArticleCell{
                if let relatedArticle = viewModel.data[indexPath.section][indexPath.row].data as? ContentOfRelatedArticle{
                    cell.setImage(image: relatedArticle.image.xl)
                    cell.categoryText.text = relatedArticle.category.capitalized
                    cell.articleText.text = relatedArticle.description
                    cell.publishedText.text = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: relatedArticle.publishedAt.date, currentDate: Date())
                    cell.shareNumText.text = String(relatedArticle.shares)
                }
                return cell
            }else{
                return UITableViewCell()
            }
            
        case SingleArticleCellTypes.mostReadNews:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(MostReadArticleCell.self)", for: indexPath) as? MostReadArticleCell{
                if let mostReadArticle = viewModel.data[indexPath.section][indexPath.row].data as? Article{
                    cell.setImage(image: mostReadArticle.image.xl)
                    cell.categoryText.text = mostReadArticle.category.capitalized
                    cell.articleText.text = mostReadArticle.description
                    cell.shareNumText.text = String(mostReadArticle.shares)
                }
                return cell
            }else{
                return UITableViewCell()
            }
        case SingleArticleCellTypes.titleRow:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(TitleRowCell.self)", for: indexPath) as? TitleRowCell{
                if let rowTitle = viewModel.data[indexPath.section][indexPath.row].data as? String{
                    cell.articleTitle.text = rowTitle
                }
                return cell
            }else{
                return UITableViewCell()
            }
            
        case SingleArticleCellTypes.publishedCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(PublishedCell.self)", for: indexPath) as? PublishedCell{
                if let article = viewModel.data[indexPath.section][indexPath.row].data as? SpecificArticle{
                    cell.publishedBeforeText.text = DateToBeforeCurrentTimeConverter.toBeforeCurrentTime(dateInPast: article.publishedAt.date, currentDate: Date())
                    cell.publishedDateText.text = Constants.published + article.publishedAtHumans.split(separator: " ")[0] + "."
                    cell.authorText.text = article.author
                    cell.shareNumText.text = String(article.shares)
                }
                return cell
            }else{
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToSingleScreenWithIndex(clickedNewsSection: indexPath.section, clickedNewsRow: indexPath.row)
    }
    
    private func registerCells(){
        self.tableView.register(ImageCell.self, forCellReuseIdentifier: "\(ImageCell.self)")
        self.tableView.register(UpperTitleCell.self, forCellReuseIdentifier: "\(UpperTitleCell.self)")
        self.tableView.register(TitleCell.self, forCellReuseIdentifier: "\(TitleCell.self)")
        self.tableView.register(TextCell.self, forCellReuseIdentifier: "\(TextCell.self)")
        self.tableView.register(RelatedTitleCell.self, forCellReuseIdentifier: "\(RelatedTitleCell.self)")
        self.tableView.register(RelatedArticleCell.self, forCellReuseIdentifier: "\(RelatedArticleCell.self)")
        self.tableView.register(MostReadArticleCell.self, forCellReuseIdentifier: "\(MostReadArticleCell.self)")
        self.tableView.register(TitleRowCell.self, forCellReuseIdentifier: "\(TitleRowCell.self)")
        self.tableView.register(PublishedCell.self, forCellReuseIdentifier: "\(PublishedCell.self)")
    }
    
    private func setupViews(){
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
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
    
    private func showLoader() {
        loader = displayLoader(onView: self.view)
        loader?.backgroundColor = .gray
        loader?.alpha = 0.3
    }
    
    private func hideLoader() {
        if let loader = loader{
            removeLoader(loader: loader)
        }
    }
    
    @objc func moveToSingleScreenWithIndex(clickedNewsSection: Int, clickedNewsRow: Int){
        var id = -1
        if let article = viewModel.data[clickedNewsSection][clickedNewsRow].data as? ContentOfRelatedArticle?{
            id = article!.id
        }else if let article = viewModel.data[clickedNewsSection][clickedNewsRow].data as? Article?{
            id = article!.id
        }
        if id != -1{
            singleCoordinatorDelegate?.openSingle(withId: id)
        }
    }
}

