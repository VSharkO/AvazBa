//
//  AvazBaTests.swift
//  AvazBaTests
//
//  Created by Valentin Šarić on 15/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
//

import Cuckoo
import Quick
import RxTest
import RxSwift
import Nimble
@testable import AvazBa

class MainScreenTests: QuickSpec {
    
    override func spec() {
        let testBundle = Bundle.init(for: MainScreenTests.self)
        let supplyListUrl = testBundle.url(forResource: "main_screen_articles_success", withExtension: "json")!
        let supplyListData = try! Data(contentsOf: supplyListUrl)
        let supplyListResponse: Response =
        {
            do{
                let responce = try ArticlesDecoderFactory.getDecoder().decode(Response.self, from: supplyListData)
                return responce
            }catch{
                return Response(name: "", slug: "", category_id: "", articles: [])
            }
            
        }()
        
        var mainViewModel: MainViewModel!
        let disposeBag = DisposeBag()
        afterSuite {
            mainViewModel = nil
        }
        describe("MainViewModel initialization"){
            context("Initionalized correctly"){
                beforeEach {
                    let mockRepository = MockRepositoryProtocol()
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: 1, category: Constants.newestApi)).thenReturn(Observable.just(supplyListResponse))
                    }
                    let testScheduler = TestScheduler(initialClock: 0)
                    mainViewModel = MainViewModel(repository: mockRepository, scheduler: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    testScheduler.start()
                }
                it("is not nil"){
                    expect(mainViewModel).toNot(be(nil))
                }
                it("data count is 0"){
                    expect(mainViewModel.data.count).to(be(0))
                }
            }
            context("Called data from repo first time"){
                var mockRepository = MockRepositoryProtocol()
                beforeEach {
                    mockRepository = MockRepositoryProtocol()
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: 1, category: Constants.newestApi)).thenReturn(Observable.just(supplyListResponse))
                    }
                    let testScheduler = TestScheduler(initialClock: 0)
                    mainViewModel = MainViewModel(repository: mockRepository, scheduler: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    testScheduler.start()
                }
                it("data is equal to number of articles from repository"){
                    mainViewModel.initialDataRequest()
                    expect(mainViewModel.data.count).to(equal(16))
                }
            }
        }

        describe("Loader logic"){
            context("when sending request"){
                var testScheduler = TestScheduler(initialClock: 0)
                var subscriber = testScheduler.createObserver(Bool.self)
                beforeEach {
                    let mockRepository = MockRepositoryProtocol()
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: 1, category: Constants.newestApi)).thenReturn(Observable.just(supplyListResponse))
                    }
                    testScheduler = TestScheduler(initialClock: 0)
                    subscriber = testScheduler.createObserver(Bool.self)
                    mainViewModel = MainViewModel(repository: mockRepository, scheduler: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    mainViewModel.viewShowLoader.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    mainViewModel.initialDataRequest()
                }
                it("loader is shown on start of request"){
                    expect(subscriber.events.first!.value.element).to(equal(true))
                }
                it("loader is hiden after receiving data"){
                    expect(subscriber.events.last!.value.element).to(be(false))
                }
            }
        }

        describe("Pull to refresh logic"){
            context("user pulls to refresh"){
                var testScheduler = TestScheduler(initialClock: 0)
                var subscriber = testScheduler.createObserver(Bool.self)
                var mockRepository = MockRepositoryProtocol()
                beforeEach {
                    mockRepository = MockRepositoryProtocol()
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: 1, category: Constants.newestApi)).thenReturn(Observable.just(supplyListResponse))
                    }
                    testScheduler = TestScheduler(initialClock: 0)
                    subscriber = testScheduler.createObserver(Bool.self)
                    mainViewModel = MainViewModel(repository: mockRepository, scheduler: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    mainViewModel.dataRequestTriger.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    mainViewModel.initialDataRequest()
                }
                it("trigeres event for request in viewModel"){
                    expect(subscriber.events.first!.value.element).to(equal(true))
                }
                it("is calling viewModel to send request for first page"){
                    verify(mockRepository, times(1)).getMostPopularArticles(pageNum: 1, category: Constants.newestApi)
                }
            }
        }

        describe("Infinite scroll logic"){
            context("more data request trigered"){
                var testScheduler = TestScheduler(initialClock: 0)
                var subscriber = testScheduler.createObserver(Bool.self)
                var mockRepository = MockRepositoryProtocol()
                beforeEach {
                    mockRepository = MockRepositoryProtocol()
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: anyInt(), category: Constants.newestApi)).thenReturn(Observable.just(supplyListResponse))
                    }
                    testScheduler = TestScheduler(initialClock: 0)
                    subscriber = testScheduler.createObserver(Bool.self)
                    mainViewModel = MainViewModel(repository: mockRepository, scheduler: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    mainViewModel.dataRequestTriger.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    
                    mainViewModel.initialDataRequest()
                    mainViewModel.moreDataRequest()
                    mainViewModel.moreDataRequest()
                }
                it("is refreshing data trigered"){
                    expect(subscriber.events.first!.value.element).to(equal(true))
                    expect(subscriber.events[1].value.element).to(equal(true))
                    expect(subscriber.events.last!.value.element).to(equal(true))
                }
                it("is calling repository method to get more data"){
                    verify(mockRepository).getMostPopularArticles(pageNum: 1, category: Constants.newestApi)
                    verify(mockRepository).getMostPopularArticles(pageNum: 2, category: Constants.newestApi)
                    verify(mockRepository).getMostPopularArticles(pageNum: 3, category: Constants.newestApi)
                }
                it("last item is not loader"){
                    expect(mainViewModel.data[mainViewModel.data.count-1].cellType).notTo(equal(CellType.loader))
                }
                it("all other items in tableview are articles"){
                    expect(mainViewModel.data[mainViewModel.data.count-2].cellType).to(equal(CellType.article))
                    expect(mainViewModel.data[0].cellType).to(equal(CellType.article))
                    expect(mainViewModel.data[mainViewModel.data.count/2].cellType).to(equal(CellType.article))
                }
            }
        }
        
        describe("tab selection logic"){
            context("tab is changed"){
                var testScheduler = TestScheduler(initialClock: 0)
                var subscriber = testScheduler.createObserver(Bool.self)
                var mockRepository = MockRepositoryProtocol()
                beforeEach {
                    mockRepository = MockRepositoryProtocol()
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: anyInt(), category: Constants.newest)).thenReturn(Observable.just(supplyListResponse))
                    }
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: anyInt(), category: Constants.mostRead)).thenReturn(Observable.just(supplyListResponse))
                    }
                    testScheduler = TestScheduler(initialClock: 0)
                    subscriber = testScheduler.createObserver(Bool.self)
                    mainViewModel = MainViewModel(repository: mockRepository, scheduler: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    mainViewModel.dataRequestTriger.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    mainViewModel.selectedTab = Constants.mostRead
                    mainViewModel.newTabOpened()
                    mainViewModel.selectedTab = Constants.newest
                    mainViewModel.newTabOpened()
                    mainViewModel.selectedTab = Constants.mostRead
                    mainViewModel.newTabOpened()
                }
                it("send request with new category in api call"){
                    verify(mockRepository,times(2)).getMostPopularArticles(pageNum: 1, category: Constants.mostRead)
                    verify(mockRepository).getMostPopularArticles(pageNum: 1, category: Constants.newest)
                }
            }
        }
        
    }
}

