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
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = ["csv","CSV"]
        let result = openPanel.runModal()
        if result == NSModalResponseOK {
            do{
                var newOpalData = try LBDataMatrix(csvURL: openPanel.URL!, titles: true)
                var metadata: [String]
                (metadata, newOpalData) = self.importDataMatrix(newOpalData)
                do{
                    let newDoc = try  NSDocumentController.sharedDocumentController().openUntitledDocumentAndDisplay(false) as! LDWOpalDocument
                    newDoc.opalData = LDWOpalData(data: newOpalData, metadataArray: metadata)
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
    
    func importDataMatrix(dataMatrix: LBDataMatrix) -> ([String], LBDataMatrix){
        let numVariables = dataMatrix.numberOfVariables()
        let numObservations = dataMatrix.numberOfObservations() - 1  //the last row of the .csv data from the opal file is blank
        let metadataIndex = dataMatrix.indexOfVariable("Metadata")
        var metadata = [String]()
        let importedDataMatrix = LBDataMatrix(numberOfObservations: numObservations)
        if metadataIndex != nil{
            metadata = dataMatrix.variableAtIndex(metadataIndex!) as! [String]
        }
        for i in 0..<numVariables{
            if dataMatrix.nameOfVariableAtIndex(i) != "Metadata"{
                let variableName = dataMatrix.nameOfVariableAtIndex(i)!
                importedDataMatrix.appendVariable(variableName, values: dataMatrix.variableAtIndex(i)!)
                if (importedDataMatrix.variableWithName(variableName)![0] as! String).containsString("."){
                    importedDataMatrix.changeStringVariableToDouble(variableName)
                } else {
                    importedDataMatrix.changeStringVariableToInt(variableName)
                }
            }
        }
        return (metadata, importedDataMatrix)
    }
}

