//
//  RecipeTests.swift
//  RecipeTests
//
//  Created by Sherif Abd El-Moniem on 29/11/2021.
//

import XCTest
@testable import Recipe
@testable import OHHTTPStubs

class RecipeTests: XCTestCase {
    
    var manager : RecipeService!
    var recipeViewController : ReciepeViewController!
    var recipePresenter : RecipeListViewPresenter!
    

    override func setUpWithError() throws {
        super.setUp()
        manager = RecipeService()
 
        
        recipeViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReciepeViewController") as! ReciepeViewController)
        _ = recipeViewController.view
        
        recipePresenter = RecipeListViewPresenter.init(delegate: recipeViewController)
        
        
        
        stub { (URLRequest) -> Bool in
            return URLRequest.url?.absoluteString.contains("/recipes") ?? false
        } response: { (URLRequest) -> HTTPStubsResponse in
                return HTTPStubsResponse(fileAtPath: Bundle.unitTest.path(forResource: "stub", ofType: "json")!, statusCode: 200, headers: nil)
        }

    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        manager = nil
        recipeViewController = nil
        recipePresenter = nil
    }
        

    func testAPIRequest() throws {
    

        manager.getRecipeList(searchText: "BURGER", from: 0, to: 10) { response in
            XCTAssertNotNil(response)
            print(response)
        } failure: {
            print("error")
        }
    }
    
    func testRecipeView_TableViewShouldNotBeNil() {
        XCTAssertNotNil(recipeViewController.recipeTable)
        XCTAssertNotNil(recipeViewController.searchTable)
    }
    
    
    func testSaveword(){
        let index = recipePresenter.fetchLatestWord()
        recipePresenter.saveSearchText(searchText: "Lemon")
        XCTAssertTrue(recipePresenter.fetchLatestWord() > index)
    }
    
    
    // MARK: Data Source
    func testDataSource_ViewDidLoad_SetsTableViewDataSource() {
        // recipeTable
        XCTAssertNotNil(recipeViewController.recipeTable.dataSource)
        XCTAssertTrue(recipeViewController.recipeTable.dataSource is ReciepeViewController)
        
        // searchTable
        XCTAssertNotNil(recipeViewController.searchTable.dataSource)
        XCTAssertTrue(recipeViewController.searchTable.dataSource is ReciepeViewController)
        
    }
    
    // MARK: Delegate
    func testDelegate_ViewDidLoad_SetsTableViewDelegate() {
        // recipeTable
        XCTAssertNotNil(recipeViewController.recipeTable.delegate)
        XCTAssertTrue(recipeViewController.recipeTable.delegate is ReciepeViewController)
        
        // searchTable
        XCTAssertNotNil(recipeViewController.searchTable.delegate)
        XCTAssertTrue(recipeViewController.searchTable.delegate is ReciepeViewController)
    }
    
}
