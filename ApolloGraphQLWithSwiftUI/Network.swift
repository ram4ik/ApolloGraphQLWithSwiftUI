//
//  Network.swift
//  ApolloGraphQLWithSwiftUI
//
//  Created by Ramill Ibragimov on 03.10.2020.
//

import Foundation
import Apollo

class Network {
    
    static let shared = Network()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/")!)
}
