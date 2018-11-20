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
        var disposeBag: DisposeBag!
        var mainViewModel: MainViewModel!
        let mockRepository = MockRepositoryProtocol()
        let testScheduler = TestScheduler(initialClock: 0)
        
        beforeEach {
            disposeBag = DisposeBag()
            mainViewModel = MainViewModel(repository: mockRepository)
            mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
        }
        
        afterSuite {
            mainViewModel = nil
        }
        
        describe("MainViewModel initialization"){
            context("Initionalized correctly"){
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
                it("data is equal to number of articles from repository"){
                    mainViewModel.dataRequestTrigered.onNext(1)
                    expect(mainViewModel.data.count).to(equal(2))
                }
            }
        }
        
        describe("LoaderLogic"){
            context("when sending request"){
                let subscriber = testScheduler.createObserver(Bool.self)
                beforeEach {
                    mainViewModel.viewShowLoader.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    mainViewModel.dataRequestTrigered.onNext(1)
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
            context("user pull to refresh"){
                let subscriber = testScheduler.createObserver(Bool.self)
                beforeEach {
                mainViewModel.pullToRefreshTrigered.subscribe(subscriber).disposed(by: disposeBag)
                    testScheduler.start()
                    mainViewModel.pullToRefreshTrigered.onNext(true)
                }
                it("is refreshing data trigered"){
                    expect(subscriber.events.first!.value.element).to(be(true))
                }
                it("is calling viewModel to send request for first page"){
                    verify(mockRepository).getMostPopularArticles(pageNum: 1)
                }
            }
        }

//        describe("Infinite scroll logic"){
//            beforeEach {
//                mainViewModel.moreDataRequestTrigered.onNext(true)
//            }
//            context("more data request trigered"){
//                it("is calling repository method to get more data"){
//                    verify(mockRepository).getMostPopularArticles()
//                }
//            }
//        }
    }
}
