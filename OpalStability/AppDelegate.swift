//
//  AppDelegate.swift
//  OpalStability
//
//  Created by Lee Walsh on 30/11/2015.
//  Copyright © 2015 Lee David Walsh. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldOpenUntitledFile(sender: NSApplication) -> Bool {
        return false
    }

    @IBAction func importData(sender: AnyObject){
        print("Importing")
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = ["csv","CSV"]
        let result = openPanel.runModal()
        if result == NSModalResponseOK {
//            let newHdf5Dataset = LDWHDF5Dataset(fileURL: openPanel.URL!)
            let newOpalData = LDWOpalData(csvFile: openPanel.URL!)
            do{
                let newDoc = try  NSDocumentController.sharedDocumentController().openUntitledDocumentAndDisplay(false) as! LDWOpalDocument
//                newDoc.data = LDWOpalData(hdf5Dataset: newHdf5Dataset)
                newDoc.data = newOpalData
                newDoc.makeWindowControllers()
                newDoc.showWindows()
            } catch {
                NSDocumentController.sharedDocumentController().presentError((error as NSError))
            }
        }
    }
}

