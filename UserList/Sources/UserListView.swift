import SwiftUI

struct UserListView: View {
    @StateObject var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            if !viewModel.isGridView {
                List(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        UserListGridView(user: user)
                    }
                    .onAppear {
                        if viewModel.shouldLoadMoreData(currentItem: user) {
                            viewModel.fetchUsers()
                        }
                    }
                }
                .navigationTitle("Users")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        UserListToolBarView(isGridView: $viewModel.isGridView, reloadButton: viewModel.reloadUsers)
                    }
                    
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(viewModel.users) { user in
                            NavigationLink(destination: UserDetailView(user: user)) {
                                UserListRowView(user: user)
                            }
                            .onAppear {
                                if viewModel.shouldLoadMoreData(currentItem: user) {
                                    viewModel.fetchUsers()
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Users")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        UserListToolBarView(isGridView: $viewModel.isGridView, reloadButton: viewModel.reloadUsers)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
