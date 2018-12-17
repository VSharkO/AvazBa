//
//  SingleScreenTests.swift
//  AvazBaTests
//
//  Created by Valentin Šarić on 07/12/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Foundation
import Cuckoo
import Quick
import RxTest
import RxSwift
import Nimble
@testable import AvazBa

class SingleScreenTests : QuickSpec{
    
    override func spec() {
        let testBundle = Bundle.init(for: SingleScreenTests.self)
        let supplyListUrl = testBundle.url(forResource: "single_screen_specific_article_success", withExtension: "json")!
        let supplyListData = try! Data(contentsOf: supplyListUrl)
        let supplyListResponse: SpecificArticle? =
        {
            do{
                let responce = try ArticlesDecoderFactory.getDecoder().decode(SpecificArticle.self, from: supplyListData)
                return responce
            }catch{
                return nil
            }
        }()
        let disposeBag = DisposeBag()
        let testBundleSingle = Bundle.init(for: SingleScreenTests.self)
        let supplyListUrlSingle = testBundleSingle.url(forResource: "main_screen_articles_success", withExtension: "json")!
        let supplyListDataSingle = try! Data(contentsOf: supplyListUrlSingle)
        let supplyListResponseSingle: [Article] =
        {
            do{
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.000000"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let responce = try decoder.decode(Response.self, from: supplyListDataSingle)
                return responce.articles
            }catch{
                return []
            }
            
        }()

        var singleViewModel: SingleViewModel!
        afterSuite {
            singleViewModel = nil
        }

        describe("SingleViewModel initialization"){
            context("Initialized properly and send first request"){
                var testScheduler = TestScheduler(initialClock: 0)
                var mockRepository = MockRepositoryProtocol()
                beforeEach {
                    mockRepository = MockRepositoryProtocol()
                    stub(mockRepository) { mock in
                        when(mock.getSpecificArticle(id: anyInt())).thenReturn(Observable.just(supplyListResponse!))
                    }
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: anyInt(), category: Constants.mostReadApi)).thenReturn(Observable.just(supplyListResponseSingle))
                    }
                    testScheduler = TestScheduler(initialClock: 0)
                    singleViewModel = SingleViewModel(repository: mockRepository, id: 2, scheduler: testScheduler)
                    singleViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    testScheduler.start()
                    singleViewModel.getSpecificArticle()
                }
                it("sends request for both specificArticle and mostReadArticle at once"){
                    verify(mockRepository).getSpecificArticle(id: 2)
                    verify(mockRepository).getMostPopularArticles(pageNum: 1, category: Constants.mostReadApi)
                }
                it("data is not empty"){
                    expect(singleViewModel.data.count).toNot(equal(0))
                }
                it("data count is equal to desired number of cells(3 currently)"){
                    expect(singleViewModel.data.count).to(equal(3))
                }
                it("data order is correct"){
                    expect(singleViewModel.data[0].data[0].cellType).to(equal(SingleArticleCellTypes.image))
                    expect(singleViewModel.data[0].data[1].cellType).to(equal(SingleArticleCellTypes.upperTitle))
                    expect(singleViewModel.data[0].data[2].cellType).to(equal(SingleArticleCellTypes.title))
                    expect(singleViewModel.data[0].data[3].cellType).to(equal(SingleArticleCellTypes.titleRow))
                    expect(singleViewModel.data[0].data[4].cellType).to(equal(SingleArticleCellTypes.publishedCell))
                    expect(singleViewModel.data[0].data[5].cellType).to(equal(SingleArticleCellTypes.text))
                    for i in 0...2{
                        expect(singleViewModel.data[1].data[i].cellType).to(equal(SingleArticleCellTypes.relatedNews))
                    }
                    for i in 0...4{
                        expect(singleViewModel.data[2].data[i].cellType).to(equal(SingleArticleCellTypes.mostReadNews))
                    }
                }
            }
        }
        
        describe("Loaders logic"){
            context("request sent"){
                var testScheduler = TestScheduler(initialClock: 0)
                var mockRepository = MockRepositoryProtocol()
                let subscriber = testScheduler.createObserver(Bool.self)
                beforeEach {
                    mockRepository = MockRepositoryProtocol()
                    stub(mockRepository) { mock in
                        when(mock.getSpecificArticle(id: 2)).thenReturn(Observable.just(supplyListResponse!))
                    }
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: anyInt(), category: Constants.mostReadApi)).thenReturn(Observable.just(supplyListResponseSingle))
                    }
                    testScheduler = TestScheduler(initialClock: 0)
                    singleViewModel = SingleViewModel(repository: mockRepository, id: 2, scheduler: testScheduler)
                    singleViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    singleViewModel.viewShowLoader.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    singleViewModel.getSpecificArticle()
                }
                it("loader shows up on start of request and hide after response"){
                    expect(subscriber.events.first!.value.element).to(equal(true))
                    expect(subscriber.events.last!.value.element).to(equal(false))
                }
            }
        }
    }
}
