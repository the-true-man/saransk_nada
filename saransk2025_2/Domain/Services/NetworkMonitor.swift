//
//  NetworkMonitor.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 05.04.2025.
//

import Foundation
import Network
import SwiftUI

final class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()
    @Published var isConnected = false
    private init() {
        let np = NWPathMonitor()
        let queue = DispatchQueue(label: "networkMonitor")
        np.start(queue: queue)
        np.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
}
