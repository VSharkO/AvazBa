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
        let mockRepository = MockRepositoryProtocol()
        afterSuite {
            mainViewModel = nil
        }
        describe("MainViewModel initialization"){
            context("Initionalized correctly"){
                beforeEach {
                    let testScheduler = TestScheduler(initialClock: 0)
                    mainViewModel = MainViewModel(repository: mockRepository, schedulare: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    testScheduler.start()
                }
                stub(mockRepository) { mock in
                    when(mock.getMostPopularArticles(pageNum: 1)).then({ _ -> Observable<[Article]> in
                        return Observable.just([Article(title: "title", description: "description", image: FeaturedImage.init(original: "Str")),Article(title: "title2", description: "description2", image: FeaturedImage.init(original: "Str"))])
                    })
                }
                it("is not nil"){
                    expect(mainViewModel).toNot(be(nil))
                }
                it("data is not empty"){
                    expect(mainViewModel.data.count).to(be(0))
                }
            }
            context("Called data from repo first time"){
                beforeEach {
                    let testScheduler = TestScheduler(initialClock: 0)
                    mainViewModel = MainViewModel(repository: mockRepository, schedulare: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    testScheduler.start()
                }
                it("data is equal to number of articles from repository"){
                    mainViewModel.dataRequestTrigered.onNext(1)
                    expect(mainViewModel.data.count).to(equal(2))
                }
            }
        }
        
        describe("LoaderLogic"){
            let mockRepository = MockRepositoryProtocol()  //Kad ovo maknem onda ne radi test zadnji.
            context("when sending request"){
                var testScheduler = TestScheduler(initialClock: 0)
                var subscriber = testScheduler.createObserver(Bool.self)
                beforeEach {
                    testScheduler = TestScheduler(initialClock: 0)
                    subscriber = testScheduler.createObserver(Bool.self)
                    mainViewModel = MainViewModel(repository: mockRepository, schedulare: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    mainViewModel.viewShowLoader.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    mainViewModel.dataRequestTrigered.onNext(1)
                }
                stub(mockRepository) { mock in
                    when(mock.getMostPopularArticles(pageNum: 1)).then({ _ -> Observable<[Article]> in
                        return Observable.just([Article(title: "title", description: "description", image: FeaturedImage.init(original: "Str")),Article(title: "title2", description: "description2", image: FeaturedImage.init(original: "Str"))])
                    })
                }
                it("loader is shown on start of request"){
                    expect(subscriber.events.first!.value.element).to(be(true))
                }
                it("loader is hiden after receiving data"){
                    expect(subscriber.events.last!.value.element).to(be(false))
                }
            }
        }
        
        describe("Pull to refresh logic"){
//            let mockRepository = MockRepositoryProtocol()  --- bez ovog radi
            context("user pull to refresh"){
                var testScheduler = TestScheduler(initialClock: 0)
                var subscriber = testScheduler.createObserver(Bool.self)
                beforeEach {
                    testScheduler = TestScheduler(initialClock: 0)
                    subscriber = testScheduler.createObserver(Bool.self)
                    mainViewModel = MainViewModel(repository: mockRepository, schedulare: testScheduler)
                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    mainViewModel.pullToRefreshTrigered.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    mainViewModel.pullToRefreshTrigered.onNext(true)
                }
                it("is refreshing data trigered"){
                    expect(subscriber.events.first!.value.element).to(equal(true))
                }
                it("is calling viewModel to send request for first page"){
                    verify(mockRepository, times(1)).getMostPopularArticles(pageNum: 1)
                }
            }
        }
        
//        describe("Infinite scroll logic"){
////            let mockRepository = MockRepositoryProtocol()  --- bez ovog radi
//            context("more data request trigered"){
//                var testScheduler = TestScheduler(initialClock: 0)
//                var subscriber = testScheduler.createObserver(Bool.self)
//                beforeEach {
//                    testScheduler = TestScheduler(initialClock: 0)
//                    subscriber = testScheduler.createObserver(Int.self)
//                    mainViewModel = MainViewModel(repository: mockRepository, schedulare: testScheduler)
//                    mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
//                    mainViewModel.moreDataRequestTrigered.subscribe(subscriber).disposed(by: disposeBag)
//                    testScheduler.start()
//                    mainViewModel.moreDataRequestTrigered.onNext(2)
//                    mainViewModel.moreDataRequestTrigered.onNext(4)
//                }
//                it("is refreshing data trigered"){
//                    expect(subscriber.events.first!.value.element).to(equal(2))
//                    expect(subscriber.events.last!.value.element).to(equal(4))
//                }
//                it("is calling repository method to get more data"){
//                    verify(mockRepository).getMostPopularArticles(2)
//                    verify(mockRepository).getMostPopularArticles(4)
//                }
//            }
//        }
    }
}
