#!/usr/bin/swift
/*
swift as script language guide: https://krakendev.io/blog/scripting-in-swift
set lockscreen background image not equal as wallpaper: https://www.businessinsider.com/how-to-change-lock-screen-on-mac
*/

import Foundation

extension Array {
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else { return defaultValue() }
        return self[index]
    }
}

extension FileManager {
    open func secureCopyItem(at srcURL: URL, to dstURL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: dstURL.path) { try FileManager.default.removeItem(at: dstURL) }
            try FileManager.default.copyItem(at: srcURL, to: dstURL)
        } catch (let error) {
            print("cannot copy item at \(srcURL) to \(dstURL) because: \(error)")
            return false
        }
        return true
    }
}

extension URL {
    func subDirectories() throws -> [URL] {
        guard hasDirectoryPath else { return [] }
        return try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]).filter(\.hasDirectoryPath)
    }
}

let imgPath = CommandLine.arguments[1, default: ""]
if imgPath != "" {
    let absImgPath = URL(fileURLWithPath: imgPath, relativeTo: URL(fileURLWithPath: FileManager.default.currentDirectoryPath))
    print(FileManager.default.secureCopyItem(at: absImgPath, to: URL(fileURLWithPath: "/Library/Caches/29F2A2A1-E56F-47E5-97EE-40DCDA1D3AD1/lockscreen.png")) ?
        "done!" :
        "something goes wrong"
    )
} else {
    print("you should set image path as argument")
}