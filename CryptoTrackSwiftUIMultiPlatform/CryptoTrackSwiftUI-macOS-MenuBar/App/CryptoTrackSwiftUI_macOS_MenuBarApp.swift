//
//  CryptoTrackSwiftUI_macOS_MenuBarApp.swift
//  CryptoTrackSwiftUI-macOS-MenuBar
//
//  Created by Baris OZGEN on 4.10.2022.
//

import SwiftUI

@main
struct CryptoTrackSwiftUI_macOS_MenuBarApp: App {
    
    @StateObject var marketViewModel = MarketViewModel()
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
           
           HomeView()
                .environmentObject(marketViewModel)
                .preferredColorScheme(.dark)
        }
        .windowStyle(.hiddenTitleBar)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    private var marketViewModel : MarketViewModel!
    
    @MainActor
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        self.marketViewModel = MarketViewModel()
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusItemButton = statusItem.button {
            
            statusItemButton.image = NSImage(systemSymbolName: "bitcoinsign.circle.fill", accessibilityDescription: "Bitcoin")
                        
            statusItemButton.title = (19729.92).toUSDCurrency()
            
            statusItemButton.action = #selector(togglePopover)
        }
        
        setupPopover()
    }
    
    private func setupPopover(){
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 492, height: 329)
        self.popover.behavior = .transient
        self.popover.contentViewController =
        NSHostingController(rootView:  HomeView().environmentObject(self.marketViewModel))
    }
    
    @objc private func togglePopover(){
        
        //self.marketViewModel.refreshData()
        
        if let statusItemButton = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                popover.show(relativeTo: statusItemButton.bounds, of: statusItemButton, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
