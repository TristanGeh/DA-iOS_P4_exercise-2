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
    
    // MARK: OutPuts's tests

    func testUsersInitialValue() {
        XCTAssertTrue(viewModel.users.isEmpty, "Users should be intially empty")
    }
    
    func testisLoadingChanges() {
            // Given
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false")
        
            // When
        viewModel.isLoading = true
        
            // Then
        XCTAssertTrue(viewModel.isLoading, "isLoading should be true")
    }
    
    func testisGridViewChanges() {
            // Given
        XCTAssertFalse(viewModel.isGridView, "isGridView should be false")
        
            // When
        viewModel.isGridView = true
        
            // Then
        XCTAssertTrue(viewModel.isGridView, "isGridView should be true")
    }
    
    func testShouldLoadMoreData() {
        // Given
        let John = User(user: UserListResponse.User(
            name: UserListResponse.User.Name(title: "Mr", first: "John", last: "Doe"),
            dob: UserListResponse.User.Dob(date: "1980-01-01", age: 40),
            picture: UserListResponse.User.Picture(large: "large_url", medium: "medium_url", thumbnail: "thumbnail_url")
        ))

        let Jane = User(user: UserListResponse.User(
            name: UserListResponse.User.Name(title: "Ms", first: "Jane", last: "Doe"),
            dob: UserListResponse.User.Dob(date: "1985-02-02", age: 35),
            picture: UserListResponse.User.Picture(large: "large_url_2", medium: "medium_url_2", thumbnail: "thumbnail_url_2")
        ))
        
        
        viewModel.users = [John, Jane]
        
            // When
        viewModel.isLoading = false
        XCTAssertFalse(viewModel.shouldLoadMoreData(currentItem: John), "Should return false for non-last item")
        XCTAssertTrue(viewModel.shouldLoadMoreData(currentItem: Jane), "Should return true for the last item when not loading")

            // When
        viewModel.isLoading = true
            // Then
        XCTAssertFalse(viewModel.shouldLoadMoreData(currentItem: Jane), "Should return false when isLoading is true")

            // When
        viewModel.users = []
            // Then
        XCTAssertFalse(viewModel.shouldLoadMoreData(currentItem: Jane), "Should return false when users list is empty")
        
    }
    
    // MARK: Inputs's tests

    func testReloadUsers() {
            // Given
        viewModel.users = [User(user: UserListResponse.User(
            name: UserListResponse.User.Name(title: "Mr", first: "John", last: "Doe"),
            dob: UserListResponse.User.Dob(date: "1980-01-01", age: 40),
            picture: UserListResponse.User.Picture(large: "large_url", medium: "medium_url", thumbnail: "thumbnail_url")
        ))]
            // When
        viewModel.reloadUsers()
        
            // Then
        XCTAssertTrue(viewModel.users.isEmpty)
    }
    
    func testFetchUsers() {
            // Given
        XCTAssertFalse(viewModel.isLoading, "isLoading should be initially false")
        XCTAssertTrue(viewModel.users.isEmpty, "users should be initially empty")

            // When
        viewModel.fetchUsers()
        let expectation = XCTestExpectation(description: "fetchUsers completes")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 2)

            // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetch")
        XCTAssertFalse(viewModel.users.isEmpty, "users should not be empty after fetch")
        }
}
