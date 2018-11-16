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
        
        describe("Test mainViewModel initialization"){
            context("Initionalized correctly"){
                it("is not nil"){
                    expect(mainViewModel).toNot(be(nil))
                }
                it("data is not empty"){
                    expect(mainViewModel.data.count).toNot(beEmpty())
                }
                it("data is equal to nuber of mocks"){
                    expect(mainViewModel.data.count).to(be(2))
                }
            }
        }
        
        describe("Test pull to refresh logic"){
            context("refreshing data trigered"){
                it("is called func to get data from repository"){
                    verify(mockRepository).getMostPopularArticles()
                }
            }
        }
    }
}
