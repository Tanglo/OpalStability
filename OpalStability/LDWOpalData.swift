//
//  LDWOpalData.swift
//  OpalStability
//
//  Created by Lee Walsh on 3/12/2015.
//  Copyright © 2015 Lee David Walsh. All rights reserved.
//

import Cocoa
import LabBot

class LDWOpalData: NSObject, NSCoding {
    var data = LBDataMatrix()
    let fileFormatVersion: Double
    let monitorIDs: [String]
    let monitorLabels: [String]
    let calibrationVersion: Double
    let sampleRate: Int
    let decimationFactor: Int
    let timeGood: Int
    let decimationBypass: Int
    let gravity: Double
    let magneticFieldMagnitude: Double
    
    var monitorIDString: String {
        var newMonitorIDString = ""
        for ID in monitorIDs{
            newMonitorIDString += ID + " "
        }
        return newMonitorIDString
    }
    var monitorLabelString: String {
        var newMonitorLabelString = ""
        for ID in monitorLabels{
            newMonitorLabelString += ID + " "
        }
        return newMonitorLabelString
    }
    var showRawData = false
    
    // MARK: Initialisation
    override init(){
        fileFormatVersion = 5.0
        monitorIDs = [String]()
        monitorLabels = [String]()
        calibrationVersion = 4.0
        sampleRate = 0
        decimationFactor = 1
        timeGood = 0
        decimationBypass = 0
        gravity = 9.806000
        magneticFieldMagnitude = 53.200000
        super.init()
    }
    
    init(data: LBDataMatrix, metadataArray: [String]){
        self.data = data
        
        var tempDouble = Double(metadataArray[0].componentsSeparatedByString("=")[1])
        if tempDouble != nil{
            fileFormatVersion = tempDouble!
        } else {
            fileFormatVersion = 5.0
        }
        
        var tempStringArray = metadataArray[1].componentsSeparatedByString("=")[1].componentsSeparatedByString(":")
        tempStringArray.removeFirst()
        monitorIDs = tempStringArray
        
        tempStringArray = metadataArray[2].componentsSeparatedByString("=")[1].componentsSeparatedByString(":")
        tempStringArray.removeFirst()
        monitorLabels = tempStringArray
        
        tempDouble = Double(metadataArray[6].componentsSeparatedByString("=")[1])
        if tempDouble != nil{
            calibrationVersion = tempDouble!
        } else {
            calibrationVersion = 5.0
        }
        
        var tempInt = Int(metadataArray[7].componentsSeparatedByString("=")[1])
        if tempInt != nil{
            sampleRate = tempInt!
        } else {
            sampleRate = 0
        }
        
        tempInt = Int(metadataArray[8].componentsSeparatedByString("=")[1])
        if tempInt != nil{
            decimationFactor = tempInt!
        } else {
            decimationFactor = 1
        }
        
        tempInt = Int(metadataArray[9].componentsSeparatedByString("=")[1])
        if tempInt != nil{
            timeGood = tempInt!
        } else {
            timeGood = 0
        }
        
        tempInt = Int(metadataArray[10].componentsSeparatedByString("=")[1])
        if tempInt != nil{
            decimationBypass = tempInt!
        } else {
            decimationBypass = 0
        }
        
        tempDouble = Double(metadataArray[11].componentsSeparatedByString("=")[1])
        if tempDouble != nil{
            gravity = tempDouble!
        } else {
            gravity = 9.806000
        }
        
        tempDouble = Double(metadataArray[12].componentsSeparatedByString("=")[1])
        if tempDouble != nil{
            magneticFieldMagnitude = tempDouble!
        } else {
            magneticFieldMagnitude = 53.200000
        }
        
        super.init()
    }
    
    // MARK: NSCoding
    required init(coder aDecoder: NSCoder) {
        data = aDecoder.decodeObjectForKey("data") as! LBDataMatrix
        fileFormatVersion = aDecoder.decodeDoubleForKey("fileFormatVersion")
        monitorIDs = aDecoder.decodeObjectForKey("monitorIDs") as! [String]
        monitorLabels = aDecoder.decodeObjectForKey("monitorLabels") as! [String]
        calibrationVersion = aDecoder.decodeDoubleForKey("calibrationVersion")
        sampleRate = aDecoder.decodeIntegerForKey("sampleRate")
        decimationFactor = aDecoder.decodeIntegerForKey("decimationFactor")
        timeGood = aDecoder.decodeIntegerForKey("timeGood")
        decimationBypass = aDecoder.decodeIntegerForKey("decimationBypass")
        gravity = aDecoder.decodeDoubleForKey("gravity")
        magneticFieldMagnitude = aDecoder.decodeDoubleForKey("magneticFieldMagnitude")
        showRawData = aDecoder.decodeBoolForKey("showRawData")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(data, forKey: "data")
        aCoder.encodeDouble(fileFormatVersion, forKey: "fileFormatVersion")
        aCoder.encodeObject(monitorIDs, forKey: "monitorIDs")
        aCoder.encodeObject(monitorLabels, forKey: "monitorLabels")
        aCoder.encodeDouble(calibrationVersion, forKey: "calibrationVersion")
        aCoder.encodeInteger(sampleRate, forKey: "sampleRate")
        aCoder.encodeInteger(decimationFactor, forKey: "decimationFactor")
        aCoder.encodeInteger(timeGood, forKey: "timeGood")
        aCoder.encodeInteger(decimationBypass, forKey: "decimationBypass")
        aCoder.encodeDouble(gravity, forKey: "gravity")
        aCoder.encodeDouble(magneticFieldMagnitude, forKey: "magneticFieldMagnitude")
        aCoder.encodeBool(showRawData, forKey: "showRawData")
    }
}
