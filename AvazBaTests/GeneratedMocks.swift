// MARK: - Mocks generated from file: AvazBa/Repository/RepositoryProtocol.swift at 2018-11-16 12:40:30 +0000

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

    

    

    
    // ["name": "getMostPopularArticles", "returnSignature": " -> Observable<[Article]>", "fullyQualifiedName": "getMostPopularArticles() -> Observable<[Article]>", "parameterSignature": "", "parameterSignatureWithoutNames": "", "inputTypes": "", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "", "call": "", "parameters": [], "returnType": "Observable<[Article]>", "isOptional": false, "escapingParameterNames": "", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func getMostPopularArticles()  -> Observable<[Article]> {
        
            return cuckoo_manager.call("getMostPopularArticles() -> Observable<[Article]>",
                parameters: (),
                escapingParameters: (),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.getMostPopularArticles())
        
    }
    

	struct __StubbingProxy_RepositoryProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getMostPopularArticles() -> Cuckoo.ProtocolStubFunction<(), Observable<[Article]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockRepositoryProtocol.self, method: "getMostPopularArticles() -> Observable<[Article]>", parameterMatchers: matchers))
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
	    func getMostPopularArticles() -> Cuckoo.__DoNotUse<Observable<[Article]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getMostPopularArticles() -> Observable<[Article]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class RepositoryProtocolStub: RepositoryProtocol {
    

    

    
     func getMostPopularArticles()  -> Observable<[Article]> {
        return DefaultValueRegistry.defaultValue(for: Observable<[Article]>.self)
    }
    
}

