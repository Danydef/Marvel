//
//  String+extension.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

extension String {
        
    public var containsWhitespace: Bool {
        rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }
    
    public var isBlank: Bool {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    static func localizeWithParams(string: String, stringsToReplace: [String]) -> String {
        var string = string
        let pattern = "%@"
        let arrayOcurrencies = string.components(separatedBy: pattern)
        for index in 0..<arrayOcurrencies.count {
            if !stringsToReplace.indices.contains(index) { break }
            let range = string.range(of: pattern)
            string = string.replacingOccurrences(of: pattern, with: stringsToReplace[index], options: .literal, range: range)
        }
        
        return string
    }
    
    // Log functions
    public func infoLog(functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        var className = (fileName as NSString).lastPathComponent
        className = (className.replacingOccurrences(of: ".swift", with: ""))
        
        print("ℹ️ [\(className).\(functionName)] : \(self)")
    }
    public func sucessLog(functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        var className = (fileName as NSString).lastPathComponent
        className = (className.replacingOccurrences(of: ".swift", with: ""))
        
        print("✅ [\(className).\(functionName)] : \(self)")
    }
    public func errorLog(functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        var className = (fileName as NSString).lastPathComponent
        className = (className.replacingOccurrences(of: ".swift", with: ""))
        
        print("🆘 [\(className).\(functionName) ErrorLine:\(lineNumber)] : \(self)")
    }
    
    func createDate(format: String = Constants.dateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.date(from: self)
        
        return dateString
    }
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        
        return nil
    }
    
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    
    subscript (index: Int) -> String {
        self[index ..< index + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        self[min(fromIndex, count) ..< count]
    }
    
    func substring(toIndex: Int) -> String {
        self[0 ..< max(0, toIndex)]
    }
    
    subscript (range: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, range.lowerBound)),
                                            upper: min(count, max(0, range.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        
        return String(self[start ..< end])
    }
    
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(data: data,
                                                        options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                                        documentAttributes: nil) else { return nil }
        
        return html
    }
    
    func securePath() -> String {
        if self.hasPrefix("http://"), let range = self.range(of: "http://") {
            var newPath = self
            newPath.removeSubrange(range)
            return "https://" + newPath
        } else {
            return self
        }
    }
}
