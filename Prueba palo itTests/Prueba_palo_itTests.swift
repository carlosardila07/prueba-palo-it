//
//  Prueba_palo_itTests.swift
//  Prueba palo itTests
//
//  Created by Carlos Ardila on 14/03/22.
//

import XCTest
import RxSwift

@testable import Prueba_palo_it

class Prueba_palo_itTests: XCTestCase {
    
    private var sut: ViewController!
    
    override func setUp() {
        super.setUp()
        sut = ViewController()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadData() throws {
        sut.viewModel.postResult.subscribe(onNext: { result in
            assert(result.count > 0)
        }).disposed(by: sut.disposeBag)
        sut.viewModel.postResult.onNext([Post(userId: 1, id: 1, title: "", body: "")])
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
