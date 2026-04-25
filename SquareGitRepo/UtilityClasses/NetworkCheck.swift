//
//  NetworkCheck.swift
//  SquareGitRepo
//
//  Created by RV on 25/04/26.
//

import Foundation
import Network

final class NetworkCheck {
    
    static let shared = NetworkCheck()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    private(set) var isConnected: Bool = true
    private(set) var isExpensive: Bool = false
    
    private init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            
            self.isConnected = path.status == .satisfied
            self.isExpensive = path.isExpensive
            
            print("Connected:", self.isConnected)
            print("Expensive (Cellular):", self.isExpensive)
        }
        
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
