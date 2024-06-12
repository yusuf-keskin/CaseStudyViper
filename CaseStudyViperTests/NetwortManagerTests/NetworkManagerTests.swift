//
//  NetworkManagerTests.swift
//  CaseStudyViperTests
//
//  Created by YUSUF KESKİN on 12.06.2024.
//

import XCTest
@testable import CaseStudyViper

final class NetworkManagerTests: XCTestCase {
    
    var sut : NetworkManager!

    override func setUpWithError() throws {
        sut = NetworkManager()
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    func testNetworkManagerWhenValidUrlGivenReturnsDecodedData() async throws {
        let url = URL(string:"http://private-d3ae2-n11case.apiary-mock.com/listing/1")!
        let data = try? await sut.download(type: ProductsCollectionModel.self, from: url)
        XCTAssertNotNil(data)
    }
    
    func testNetworkManagerWhenUnvalidUrlGivenReturnsError() async throws {
        let url = URL(string:"http://private-d3ae2-n11case.apiary-mock.com/listin")!
        do {
            let _ = try await sut.download(type: ProductsCollectionModel.self, from: url)
        } catch NetworkingError.responseError {
            return
        } catch {
            XCTFail("Unvalid response supposed to throw let NetworkingError.responseError")
        }
    }
}
