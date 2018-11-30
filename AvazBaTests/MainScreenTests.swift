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
                        when(mock.getMostPopularArticles(pageNum: 1, category: constants.newestApi)).then({ _ -> Observable<[Article]> in
                            return Observable.just([Article(title: "title", description: "description", image: FeaturedImage.init(original: "Str")),Article(title: "title2", description: "description2", image: FeaturedImage.init(original: "Str"))])
                        })
                    }
                    let testScheduler = TestScheduler(initialClock: 0)
                    mainViewModel = MainViewModel(repository: mockRepository, schedulare: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    testScheduler.start()
                }
                it("is not nil"){
                    expect(mainViewModel).toNot(be(nil))
                }
                it("data is not empty"){
                    expect(mainViewModel.data.count).to(be(0))
                }
            }
            context("Called data from repo first time"){
                var mockRepository = MockRepositoryProtocol()
                beforeEach {
                    mockRepository = MockRepositoryProtocol()
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: 1, category: constants.newestApi)).then({ _ -> Observable<[Article]> in
                            return Observable.just([Article(title: "title", description: "description", image: FeaturedImage.init(original: "Str")),Article(title: "title2", description: "description2", image: FeaturedImage.init(original: "Str"))])
                        })
                    }
                    let testScheduler = TestScheduler(initialClock: 0)
                    mainViewModel = MainViewModel(repository: mockRepository, schedulare: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    testScheduler.start()
                }
                it("data is equal to number of articles from repository"){
                    mainViewModel.dataRequestTriger.onNext(true)
                    expect(mainViewModel.data.count).to(equal(2))
                }
            }
        }

        describe("LoaderLogic"){
            context("when sending request"){
                var testScheduler = TestScheduler(initialClock: 0)
                var subscriber = testScheduler.createObserver(Bool.self)
                beforeEach {
                    let mockRepository = MockRepositoryProtocol()
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: 1, category: constants.newestApi)).then({ _ -> Observable<[Article]> in
                            return Observable.just([Article(title: "title", description: "description", image: FeaturedImage.init(original: "Str")),Article(title: "title2", description: "description2", image: FeaturedImage.init(original: "Str"))])
                        })
                    }
                    testScheduler = TestScheduler(initialClock: 0)
                    subscriber = testScheduler.createObserver(Bool.self)
                    mainViewModel = MainViewModel(repository: mockRepository, schedulare: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    mainViewModel.viewShowLoader.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    mainViewModel.dataRequestTriger.onNext(true)
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
            context("user pull to refresh"){
                var testScheduler = TestScheduler(initialClock: 0)
                var subscriber = testScheduler.createObserver(Bool.self)
                var mockRepository = MockRepositoryProtocol()
                beforeEach {
                    mockRepository = MockRepositoryProtocol()
                    stub(mockRepository) { mock in
                        when(mock.getMostPopularArticles(pageNum: 1, category: constants.newestApi)).then({ _ -> Observable<[Article]> in
                            return Observable.just([Article(title: "title", description: "description", image: FeaturedImage.init(original: "Str")),Article(title: "title2", description: "description2", image: FeaturedImage.init(original: "Str"))])
                        })
                    }
                    testScheduler = TestScheduler(initialClock: 0)
                    subscriber = testScheduler.createObserver(Bool.self)
                    mainViewModel = MainViewModel(repository: mockRepository, schedulare: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    mainViewModel.dataRequestTriger.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    mainViewModel.pullToRefresh()
                }
                it("is trigered event for request in viewModel"){
                    expect(subscriber.events.first!.value.element).to(equal(true))
                }
                it("is calling viewModel to send request for first page"){
                    verify(mockRepository, times(1)).getMostPopularArticles(pageNum: 1, category: constants.newestApi)
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
                        when(mock.getMostPopularArticles(pageNum: anyInt(), category: constants.newestApi)).then({ _ -> Observable<[Article]> in
                            return Observable.just([Article(title: "title", description: "description", image: FeaturedImage.init(original: "Str")),Article(title: "title2", description: "description2", image: FeaturedImage.init(original: "Str"))])
                        })
                    }
                    testScheduler = TestScheduler(initialClock: 0)
                    subscriber = testScheduler.createObserver(Bool.self)
                    mainViewModel = MainViewModel(repository: mockRepository, schedulare: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    mainViewModel.dataRequestTriger.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    
                    mainViewModel.dataRequestTriger.onNext(true)
                    mainViewModel.dataRequestTriger.onNext(true)
                    mainViewModel.dataRequestTriger.onNext(true)
                }
                it("is refreshing data trigered"){
                    expect(subscriber.events.first!.value.element).to(equal(true))
                    expect(subscriber.events[1].value.element).to(equal(true))
                    expect(subscriber.events.last!.value.element).to(equal(true))
                }
                it("is calling repository method to get more data"){
                    verify(mockRepository).getMostPopularArticles(pageNum: 1, category: constants.newestApi)
                    verify(mockRepository).getMostPopularArticles(pageNum: 2, category: constants.newestApi)
                    verify(mockRepository).getMostPopularArticles(pageNum: 3, category: constants.newestApi)
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
    }
}

