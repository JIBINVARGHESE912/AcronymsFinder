//
//  AcronymSearchAPITests.swift
//  AcronymsFinderTests
//
//

import XCTest
@testable import AcronymsFinder

final class AcronymSearchAPITests: XCTestCase {
    
    var expectation:XCTestExpectation!
    var acronymSearchAPI:AcronymSearchAPI = AcronymSearchAPI()
    
    override func setUp() async throws {
        
        expectation = expectation(description: "Expectation")
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2.0)

    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2.0)

    }
    
    func testSuccessResponse(){
        
        let sf = "NASA"
        let lf = "National Aeronautics and Space Administration"
        let freq = 84
        let since = 1982
        var acronymlfValue = ""
        var acronymFrequnecy:Int?
        var acronymSince:Int?
        
        _ = """
            [{"sf": "NASA", "lfs": [{"lf": "National Aeronautics and Space Administration", "freq": 84, "since": 1982, "vars": [{"lf": "National Aeronautics and Space Administration", "freq": 81, "since": 1982}, {"lf": "National Aeronautic and Space Administration", "freq": 2, "since": 1992}, {"lf": "National Aeronautics and Space administration", "freq": 1, "since": 2000}]}]}]
        """
        
        self.acronymSearchAPI.getAcronymSearchDetails(searchText: sf) { acronymList in
            
            guard let acronym = acronymList.last else {
                return
            }
            
            if let lfs = acronym.lfs{
                
                for lf in lfs{
                    
                    if let lfValue = lf.lf{
                        
                        acronymlfValue = lfValue
                    }
                    
                    if let lfFrequency = lf.frequency{
                        
                        acronymFrequnecy = lfFrequency
                    }
                    
                    if let lfSince = lf.since{
                        
                        acronymSince = lfSince
                    }
                }
            }
            
            XCTAssertEqual(acronym.sf!.uppercased(), sf, "Incorrect sf")
            XCTAssertEqual(acronymlfValue,  lf, "Incorrect lf")
            XCTAssertEqual(acronymFrequnecy,  freq, "Incorrect frequency")
            XCTAssertEqual(acronymSince,  since, "Incorrect since")
            
            self.expectation.fulfill()
        } CompletionFail: { response in
            
            switch response{
                
            case .failure(let error):
                XCTFail("Error was not expected: \(error)")
                break
                
            case .statusCode(let code):
                XCTFail("Error was not expected: \(code)")
                break
                
            case .errorMessage(let message):
                XCTFail("Error was not expected: \(message)")
                break
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testFailureResponse(){
        
        self.acronymSearchAPI.getAcronymSearchDetails(searchText: "a") { acronymList in
            
            XCTAssertEqual(acronymList.count, 0, "Acronym is empty")
            
            self.expectation.fulfill()
        } CompletionFail: { response in
            
            switch response{
                
            case .failure(let error):
                XCTFail("Error was not expected: \(error)")
                break
                
            case .statusCode(let code):
                
                XCTAssertEqual(code, 403, "Unauthorised")
                XCTAssertEqual(code, 500, "Server Exception")
                break
                
            case .errorMessage(let message):
                XCTFail("Error was not expected: \(message)")
                break
            }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
}
