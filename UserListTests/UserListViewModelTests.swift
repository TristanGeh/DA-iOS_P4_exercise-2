//
//  UserListViewModelTests.swift
//  UserListTests
//
//  Created by Tristan Géhanne on 21/01/2024.
//

import XCTest
@testable import UserList

final class UserListViewModelTests: XCTestCase {
    
    private var viewModel : UserListViewModel!

    override func setUpWithError() throws {
        super.setUp()
        viewModel = UserListViewModel()
    }

    override func tearDownWithError() throws {
       viewModel = nil
        super.tearDown()
    }
    
    func testisGridViewChanges() {
        // Given
        let result = viewModel.isGridView
        
        // When
        viewModel.isGridView = true
        
        // Then
        
        XCTAssertTrue(viewModel.isGridView, "isGridView should be true")
        
    }

}
