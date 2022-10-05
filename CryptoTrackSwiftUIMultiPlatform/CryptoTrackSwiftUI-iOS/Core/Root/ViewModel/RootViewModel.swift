//
//  RootViewModel.swift
//  CryptoTrackSwiftUI-iOS
//
//  Created by Baris OZGEN on 5.10.2022.
//

import Foundation
import ActivityKit

class RootViewModel:  ObservableObject {
    
    private var activity: Activity<ActivityAttributesDynamicIsland>? = nil
    
    func setActiviy() {
        
        startActivity()
        
        Task{
           try await Task.sleep(nanoseconds: UInt64(60 * Double(NSEC_PER_SEC)))
            stopActivity()
        }
       
      
    }
    
    private func startActivity() {
        let attributes = ActivityAttributesDynamicIsland(name: "Bitcoin")
        let contentState = ActivityAttributesDynamicIsland.ContentState(price: 20297.92)
        
      activity = try? Activity<ActivityAttributesDynamicIsland>.request(attributes: attributes, contentState: contentState, pushType: nil)
        
    }
    
    private func stopActivity() {
        let contentState = ActivityAttributesDynamicIsland.ContentState(price: 20297.92)
        
        Task{
            await activity?.end(using: contentState, dismissalPolicy: .immediate)
        }
        
    }
    
    private func updateActivity() {
        let contentState = ActivityAttributesDynamicIsland.ContentState(price: 20297.92)
        
        Task{
            await activity?.update(using: contentState)
        }
        
    }
}
