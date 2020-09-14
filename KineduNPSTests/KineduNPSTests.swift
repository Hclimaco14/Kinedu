//
//  KineduNPSTests.swift
//  KineduNPSTests
//
//  Created by Hector Climaco on 13/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import XCTest
@testable import KineduNPS


class KineduNPSTests: XCTestCase {
  
  private var expectation:XCTestExpectation!
  
  let services = NPSServices()
  private let customInterval:TimeInterval =  60
  
  override func setUp() {
    expectation = self.expectation(description: "waitingRespons")
    configuereService()
  }
  
  func testgetNPS() {
    services.getNPS(loadFromFile:false) { (NPSRespnse, error) in
      if error != nil {
        XCTAssert(false, "getNPS fue incorrecto")
        self.expectation.fulfill()
      } else {
        print("Response", String(describing: NPSRespnse))
        XCTAssert(true, "getNPS fue correcto")
        self.expectation.fulfill()
      }
    }
    waitForExpectations(timeout: customInterval, handler: nil)
  }
  
  func testGetDataFromFile() {
    if let jsonData = services.readLocalFile(forName: "npsData") {
        print(String(describing: jsonData))
        XCTAssert(true, "getNPS fue correcto")
        self.expectation.fulfill()
    } else {
      XCTAssert(false, "getNPS fue incorrecto")
      self.expectation.fulfill()
    }
    waitForExpectations(timeout: customInterval, handler: nil)
  }
  
  func configuereService() {
    services.showLoading = {
      print("Show loading")
    }
    
    services.hideLoading = {
      print("Show hideloading")
    }
    
  }
  
}
