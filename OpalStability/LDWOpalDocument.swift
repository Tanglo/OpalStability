//
//  LDWOpalDocument.swift
//  OpalStability
//
//  Created by Lee Walsh on 30/11/2015.
//  Copyright © 2015 Lee David Walsh. All rights reserved.
//

import Cocoa
import LabBot

class LDWOpalDocument: NSDocument, NSTableViewDataSource {
    
    var opalData = LDWOpalData()
    @IBOutlet var opalDataTableView: NSTableView?
    @IBOutlet var showRawDataCheckBox: NSButton?

    // MARK: Initialisation
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }
    
    // MARK: NSDocument overrides
    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
        self.setupOpalDataTableView()
        if opalData.showRawData == true{
            showRawDataCheckBox!.state = NSOnState
        } else {
            showRawDataCheckBox!.state = NSOffState
        }
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        return "LDWOpalDocument"
    }

    override func dataOfType(typeName: String) throws -> NSData {
        return NSKeyedArchiver.archivedDataWithRootObject(opalData)
        
        //Data should always be archivable.
        //throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func readFromData(data: NSData, ofType typeName: String) throws {
        let newData = NSKeyedUnarchiver.unarchiveObjectWithData(data)
        if newData != nil {
            opalData = newData as! LDWOpalData
        } else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
    }
    
    
    // MARK: NSTableViewDatasource
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        if tableColumn != nil {
            let variableName = tableColumn!.headerCell.stringValue
            let variable = opalData.data.variableWithName(variableName)
            if variable != nil {
                return variable![row]
            }
        }
        return "-"
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return opalData.data.numberOfObservations()
    }
    
    // MARK: Setup
    func setupOpalDataTableView(){
        while opalDataTableView!.tableColumns.count > 0{
            opalDataTableView!.removeTableColumn(opalDataTableView!.tableColumns[0])
        }
        for i in 0..<opalData.data.numberOfVariables(){
            let variableName = opalData.data.nameOfVariableAtIndex(i)!
            if !variableName.containsString("Raw") || opalData.showRawData{
                let newTableColumn = NSTableColumn(identifier: variableName)
                newTableColumn.headerCell.stringValue = variableName
                opalDataTableView!.addTableColumn(newTableColumn)
            }
        }
    }
    
    // MARK: Interface
    @IBAction func showRawData(sender: AnyObject){
        if (sender as! NSButton).state == NSOnState{
            opalData.showRawData = true
        } else {
            opalData.showRawData = false
        }
        self.setupOpalDataTableView()
    }

}

