//
//  AppDelegate.swift
//  Linker
//
//  Created by Daniel Stagnaro on 12/31/16.
//  Copyright © 2016 Daniel Stagnaro. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var item : NSStatusItem? = nil
    var plainText: String = "public.utf8-plain-text"
    var plainHtml: String = "public.html"
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        item = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        item?.image = NSImage(named: "link")
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Make Link", action: #selector(AppDelegate.linker), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit), keyEquivalent: ""))
        
        item?.menu = menu
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func linker() {
        
        // public.utf8-plain-text
        
        printPasteboard()
    }
    
    func quit() {
        NSApplication.shared().terminate(self)
    }
    
    func printPasteboard() {
        if let items = NSPasteboard.general().pasteboardItems {
            for item in items {
                for type in item.types {
                    if type == plainText {
                        if let url = item.string(forType: type) {
                            NSPasteboard.general().clearContents()
                            
                            var actualURL = ""
                            
                            if url.hasPrefix("http://") || url.hasPrefix("https://") {
                                actualURL = url
                            } else {
                                actualURL = "http://\(url)"
                            }
                            
                            NSPasteboard.general().setString("<a href=\"\(actualURL)\">\(url)</a>", forType: plainHtml)
                            NSPasteboard.general().setString(url, forType: plainText)
                        }
                    }
                }
            }
        }
    }
}
