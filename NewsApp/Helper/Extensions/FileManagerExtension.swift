//
//  FileManagerExtension.swift
//
//  Created by Pramod Kumar on 19/09/17.
//  Copyright © 2017 Pramod Kumar. All rights reserved.
//


import Foundation
import UIKit

extension FileManager{
    
    ///Prints Core Data URL
    @nonobjc class var printCoreDataURL:Void{
        printDebug(self.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    @nonobjc class var documentDirectoryUrl: URL {
        return self.default.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]
    }
    ///Clears all files of 'Document' directory
    @nonobjc class var clearDocumentDirectory:Void{
        
        do {
            let directoryContents : [URL] = try self.default.contentsOfDirectory(at: documentDirectoryUrl, includingPropertiesForKeys: nil, options: self.DirectoryEnumerationOptions())
            for videoUrl in directoryContents {
                
                if URL(fileURLWithPath:videoUrl.path).pathExtension.isAnyUrl {
                    removeFile(atPath: videoUrl.path)
                }
            }
        }
        catch {
        }
    }
    
    ///Clears all files of 'Cache' directory
    @nonobjc class var clearCacheDirectory:Void{
        
        let documentsUrl =  self.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        do {
            let directoryContents : [URL] = try self.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: self.DirectoryEnumerationOptions())
            for videoUrl in directoryContents {
                
                if URL(fileURLWithPath:videoUrl.path).pathExtension.isAnyUrl {
                    removeFile(atPath: videoUrl.path)
                }
            }
        } catch  {
        }
    }
    
    ///Clears all files of 'Temp' directory
    @nonobjc class var clearTempDirectory:Void{
        do {
            let tempDirectory = try self.default.contentsOfDirectory(atPath: NSTemporaryDirectory())
            for file in tempDirectory {
                try self.default.removeItem(atPath: "\(NSTemporaryDirectory())\(file)")
            }
        }
        catch{
        }
    }
    
    ///Removes a file at a given path
    class func removeFile(atPath filePath: String) {
        let fileManager = self.default
        if fileManager.fileExists(atPath: filePath) {
            do {
                try fileManager.removeItem(atPath: filePath)
            }
            catch{
            }
        }
    }
    
    ///Removes all files at a given directroy path
    class func removeFiles(atDirectroyPath directroyPath: String){
        do{
            let array = try self.default.contentsOfDirectory(atPath: directroyPath)
            for file in array{
                removeFile(atPath: "\(directroyPath)/\(file)")
            }
        }
        catch {
        }
    }
    
    class func removeFiles(atDirectroyPath directroyPath: String, except:[String]){
        do{
            let array = try self.default.contentsOfDirectory(atPath: directroyPath)
            for file in array{
                if !except.contains(file){
                removeFile(atPath: "\(directroyPath)/\(file)")
                }
            }
        }
        catch {
        }
    }
    class func isFileExists(_ filePath: String) -> Bool {
        let fileManager = self.default
        return fileManager.fileExists(atPath: filePath)
    }
}
