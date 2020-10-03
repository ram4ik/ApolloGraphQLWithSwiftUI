//
//  ContentView.swift
//  ApolloGraphQLWithSwiftUI
//
//  Created by Ramill Ibragimov on 03.10.2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var launchData: LaunchListData = LaunchListData()
    
    var body: some View {
        return List(launchData.sites) { site in
            Text(site)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension String: Identifiable {
    public var id: String { self }
}

class LaunchListData: ObservableObject {
    @Published var sites: [String]
    
    init() {
        print("running loadData")
        self.sites = [String]()
        loadData()
    }
    
    func loadData() {
        Network.shared.apollo.fetch(query: LaunchListQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                for launch in graphQLResult.data!.launches.launches {
                    if launch != nil {
                        if launch!.site != nil {
                            self.sites.append(launch!.site!)
                        }
                    }
                }
                
                print("Success! Result: \(String(describing: self.sites))")
                
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
}
