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
        let testBundle = Bundle.init(for: MainScreenTests.self)
        let supplyListUrl = testBundle.url(forResource: "single_screen_specific_article_success", withExtension: "json")!
        let supplyListData = try! Data(contentsOf: supplyListUrl)
        let supplyListResponse: SpecificArticle? =
        {
            do{
                let decoder = JSONDecoder()
                let responce = try decoder.decode(SpecificArticle.self, from: supplyListData)
                return responce
            }catch{
                return nil
            }
        }()

        var singleViewModel: SingleViewModel!
        let disposeBag = DisposeBag()
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
                        when(mock.getSpecificArticle(id: 2)).thenReturn(Observable.just(supplyListResponse!))
                    }
                    testScheduler = TestScheduler(initialClock: 0)
                    singleViewModel = SingleViewModel(repository: mockRepository, id: 2, scheduler: testScheduler)
                    singleViewModel.initGetingDataFromRepository().disposed(by: disposeBag)
                    testScheduler.start()
                    singleViewModel.getSpecificArticle()
                }
                it("sends request"){
                    verify(mockRepository).getSpecificArticle(id: 2)
                }
                it("data is not empty"){
                    expect(singleViewModel.data.count).toNot(equal(0))
                }
                it("data count is equal to desired number of cells(5 currently)"){
                    expect(singleViewModel.data.count).to(equal(7))
                }
                it("data order is correct"){
                    
                }
            }
        }
    }
}

