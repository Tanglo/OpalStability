//
//  LDWOpalDocument.swift
//  OpalStability
//
//  Created by Lee Walsh on 30/11/2015.
//  Copyright © 2015 Lee David Walsh. All rights reserved.
//

import Cocoa
import LabBot

class LDWOpalDocument: NSDocument {
    
    var opalData = LBDataMatrix()

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        return "LDWOpalDocument"
    }

    override func dataOfType(typeName: String) throws -> NSData {
        return NSKeyedArchiver.archivedDataWithRootObject(opalData)
        
        //There should be no error.  Data should always be archivable.
        //throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func readFromData(data: NSData, ofType typeName: String) throws {
        let newData = NSKeyedUnarchiver.unarchiveObjectWithData(data)
        if newData != nil {
            opalData = newData as! LBDataMatrix
        } else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
    }


}

