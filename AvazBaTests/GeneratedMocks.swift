// MARK: - Mocks generated from file: AvazBa/Repository/RepositoryProtocol.swift at 2018-12-18 07:06:14 +0000

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

    

    

    
    // ["name": "getMostPopularArticles", "returnSignature": " -> Observable<Response>", "fullyQualifiedName": "getMostPopularArticles(pageNum: Int, category: String) -> Observable<Response>", "parameterSignature": "pageNum: Int, category: String", "parameterSignatureWithoutNames": "pageNum: Int, category: String", "inputTypes": "Int, String", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "pageNum, category", "call": "pageNum: pageNum, category: category", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("pageNum"), name: "pageNum", type: "Int", range: CountableRange(253..<265), nameRange: CountableRange(253..<260)), CuckooGeneratorFramework.MethodParameter(label: Optional("category"), name: "category", type: "String", range: CountableRange(267..<283), nameRange: CountableRange(267..<275))], "returnType": "Observable<Response>", "isOptional": false, "escapingParameterNames": "pageNum, category", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func getMostPopularArticles(pageNum: Int, category: String)  -> Observable<Response> {
        
            return cuckoo_manager.call("getMostPopularArticles(pageNum: Int, category: String) -> Observable<Response>",
                parameters: (pageNum, category),
                escapingParameters: (pageNum, category),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.getMostPopularArticles(pageNum: pageNum, category: category))
        
    }
    
    // ["name": "getSpecificArticle", "returnSignature": " -> Observable<SpecificArticle>", "fullyQualifiedName": "getSpecificArticle(id: Int) -> Observable<SpecificArticle>", "parameterSignature": "id: Int", "parameterSignatureWithoutNames": "id: Int", "inputTypes": "Int", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "id", "call": "id: id", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("id"), name: "id", type: "Int", range: CountableRange(337..<344), nameRange: CountableRange(337..<339))], "returnType": "Observable<SpecificArticle>", "isOptional": false, "escapingParameterNames": "id", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func getSpecificArticle(id: Int)  -> Observable<SpecificArticle> {
        
            return cuckoo_manager.call("getSpecificArticle(id: Int) -> Observable<SpecificArticle>",
                parameters: (id),
                escapingParameters: (id),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.getSpecificArticle(id: id))
        
    }
    

	struct __StubbingProxy_RepositoryProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getMostPopularArticles<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(pageNum: M1, category: M2) -> Cuckoo.ProtocolStubFunction<(Int, String), Observable<Response>> where M1.MatchedType == Int, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String)>] = [wrap(matchable: pageNum) { $0.0 }, wrap(matchable: category) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRepositoryProtocol.self, method: "getMostPopularArticles(pageNum: Int, category: String) -> Observable<Response>", parameterMatchers: matchers))
	    }
	    
	    func getSpecificArticle<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ProtocolStubFunction<(Int), Observable<SpecificArticle>> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRepositoryProtocol.self, method: "getSpecificArticle(id: Int) -> Observable<SpecificArticle>", parameterMatchers: matchers))
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
	    func getMostPopularArticles<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(pageNum: M1, category: M2) -> Cuckoo.__DoNotUse<Observable<Response>> where M1.MatchedType == Int, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String)>] = [wrap(matchable: pageNum) { $0.0 }, wrap(matchable: category) { $0.1 }]
	        return cuckoo_manager.verify("getMostPopularArticles(pageNum: Int, category: String) -> Observable<Response>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getSpecificArticle<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<Observable<SpecificArticle>> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getSpecificArticle(id: Int) -> Observable<SpecificArticle>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class RepositoryProtocolStub: RepositoryProtocol {
    

    

    
     func getMostPopularArticles(pageNum: Int, category: String)  -> Observable<Response> {
        return DefaultValueRegistry.defaultValue(for: Observable<Response>.self)
    }
    
     func getSpecificArticle(id: Int)  -> Observable<SpecificArticle> {
        return DefaultValueRegistry.defaultValue(for: Observable<SpecificArticle>.self)
    }
    
}

