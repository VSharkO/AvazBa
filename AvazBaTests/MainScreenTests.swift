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
        
        beforeSuite {
            disposeBag = DisposeBag()
            mainViewModel = MainViewModel(repository: mockRepository)
            mainViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
            
            stub(mockRepository) { mock in
                when(mock.getMostPopularArticles()).then({ _ -> Observable<[Article]> in
                    return Observable.just([Article(title: "title", description: "description", urlToImage: "imageUrl"),Article(title: "title2", description: "description2", urlToImage: "imageUrl2")])
                })
            }
        }
        
        afterSuite {
            mainViewModel = nil
        }
        
        describe("MainViewModel initialization"){
            context("Initionalized correctly"){
                it("is not nil"){
                    expect(mainViewModel).toNot(be(nil))
                }
                it("data is not empty"){
                    expect(mainViewModel.data.count).toNot(beEmpty())
                }
                it("data is equal to number of articles from repository"){
                    expect(mainViewModel.data.count).to(be(2))
                }
            }
        }
        
        describe("Pull to refresh logic"){
            beforeSuite {
                mainViewModel.pullToRefreshTriger.onNext(true)
            }
            context("refreshing data trigered"){
                it("is calling repository method to get data"){
                    verify(mockRepository).getMostPopularArticles()
                }
            }
            context("after refrashing is done"){
                it("data has changed"){
                    mainViewModel.pullToRefreshTriger.onNext(true)
                }
            }
        }
    }
}
