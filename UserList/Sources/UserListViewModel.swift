//
//  UserListViewModel.swift
//  UserList
//
//  Created by Tristan Géhanne on 15/01/2024.
//

import Foundation

class UserListViewModel: ObservableObject {
    let repository = UserListRepository()
    
    // OutPut :
    @Published  var users: [User] = []
    @Published  var isLoading = false
    @Published  var isGridView = false
    
    // TODO: - Should be an OutPut
     func shouldLoadMoreData(currentItem item: User) -> Bool {
        guard let lastItem = users.last else { return false }
        return !isLoading && item.id == lastItem.id
    }
    
    //Input :
    
     func reloadUsers() {
        users.removeAll()
        fetchUsers()
    }
     func fetchUsers() {
        isLoading = true
        Task {
            do {
                let users = try await repository.fetchUsers(quantity: 20)
                await MainActor.run{
                    self.users.append(contentsOf: users)
                    isLoading = false
                }
            } catch {
                print("Error fetching users: \(error.localizedDescription)")
            }
        }
    }
    
}




