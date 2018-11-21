// MARK: - Mocks generated from file: AvazBa/Repository/RepositoryProtocol.swift at 2018-11-21 10:05:23 +0000

//
//  RepositoryProtocol.swift
//  AvazBa
//
//  Created by Valentin Šarić on 16/11/2018.
//  Copyright © 2018 Valentin Šarić. All rights reserved.
import Cuckoo
@testable import AvazBa

import Foundation
import RxSwift

class MockRepositoryProtocol: RepositoryProtocol, Cuckoo.ProtocolMock {
    typealias MocksType = RepositoryProtocol
    typealias Stubbing = __StubbingProxy_RepositoryProtocol
    typealias Verification = __VerificationProxy_RepositoryProtocol

    private var __defaultImplStub: RepositoryProtocol?

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    func enableDefaultImplementation(_ stub: RepositoryProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    // ["name": "getMostPopularArticles", "returnSignature": " -> Observable<[Article]>", "fullyQualifiedName": "getMostPopularArticles(pageNum: Int) -> Observable<[Article]>", "parameterSignature": "pageNum: Int", "parameterSignatureWithoutNames": "pageNum: Int", "inputTypes": "Int", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "pageNum", "call": "pageNum: pageNum", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("pageNum"), name: "pageNum", type: "Int", range: CountableRange(253..<265), nameRange: CountableRange(253..<260))], "returnType": "Observable<[Article]>", "isOptional": false, "escapingParameterNames": "pageNum", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func getMostPopularArticles(pageNum: Int)  -> Observable<[Article]> {
        
            return cuckoo_manager.call("getMostPopularArticles(pageNum: Int) -> Observable<[Article]>",
                parameters: (pageNum),
                escapingParameters: (pageNum),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.getMostPopularArticles(pageNum: pageNum))
        
    }
    

	struct __StubbingProxy_RepositoryProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getMostPopularArticles<M1: Cuckoo.Matchable>(pageNum: M1) -> Cuckoo.ProtocolStubFunction<(Int), Observable<[Article]>> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pageNum) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRepositoryProtocol.self, method: "getMostPopularArticles(pageNum: Int) -> Observable<[Article]>", parameterMatchers: matchers))
	    }
	    
	}

	struct __VerificationProxy_RepositoryProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getMostPopularArticles<M1: Cuckoo.Matchable>(pageNum: M1) -> Cuckoo.__DoNotUse<Observable<[Article]>> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: pageNum) { $0 }]
	        return cuckoo_manager.verify("getMostPopularArticles(pageNum: Int) -> Observable<[Article]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class RepositoryProtocolStub: RepositoryProtocol {
    

    

    
     func getMostPopularArticles(pageNum: Int)  -> Observable<[Article]> {
        return DefaultValueRegistry.defaultValue(for: Observable<[Article]>.self)
    }
    
}

