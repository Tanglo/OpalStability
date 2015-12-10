//
//  AppDelegate.swift
//  OpalStability
//
//  Created by Lee Walsh on 30/11/2015.
//  Copyright © 2015 Lee David Walsh. All rights reserved.
//

import Cocoa
import LabBot

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
            do{
                let newOpalData = try LBDataMatrix(csvURL: openPanel.URL!, titles: true)
                do{
                    let newDoc = try  NSDocumentController.sharedDocumentController().openUntitledDocumentAndDisplay(false) as! LDWOpalDocument
                    newDoc.opalData = newOpalData
                    newDoc.makeWindowControllers()
                    newDoc.showWindows()
                } catch {
                    NSDocumentController.sharedDocumentController().presentError((error as NSError))
                }
            } catch {
                let errorAlert = NSAlert(error: error as NSError)
                errorAlert.runModal()
            }
        }
    }
}

