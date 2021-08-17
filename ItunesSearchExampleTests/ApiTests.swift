//
//  ApiTests.swift
//  ItunesSearchExampleTests
//
//  Created by Erdi Tunçalp on 17.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import XCTest
@testable import ItunesSearchExample

class ApiTests: XCTestCase {

    func testApi() {
        var resultCount = 0
        let expectation = self.expectation(description: "Api")
        let request = SearchRequest(query: "dark", media: MediaType.movie.rawValue, offset: 0)
        NetworkManager.shared.execute(request: request) { response in
            expectation.fulfill()
            switch response.result {
            case .success(let result):
                if let results = result.results {
                    resultCount = results.count
                }
            case .failure(let error):
                print(error)
                XCTFail("Fail \(error)")
            }
        }

        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertEqual(resultCount, 10)
    }

}
