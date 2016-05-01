//
//  HTTPResponseParser.swift
//  CachedApi
//
//  Created by wegie on 2016/05/01.
//  Copyright © 2016年 wegie. All rights reserved.
//

import Foundation

public protocol HTTPResponseParser {
    associatedtype T
    var parse: NSData -> T { get }
}

public struct HTTPResponseParserOptions : OptionSetType {

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let FirstLineDrop: HTTPResponseParserOptions = HTTPResponseParserOptions(rawValue: 0)
    public static let EmptyLineDrop: HTTPResponseParserOptions = HTTPResponseParserOptions(rawValue: 1)

}

extension HTTPResponseParser {

    public func parseCSV(data: NSData, encoding: NSStringEncoding = NSUTF8StringEncoding,
                         separator: String = ",",
                         options: HTTPResponseParserOptions = .EmptyLineDrop) -> [[String]] {
        if let string = String(data: data, encoding: encoding) {
            var lines = string.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
            if options.contains(.FirstLineDrop) {
                lines = Array(lines.dropFirst())
            }
            return lines.reduce([]) { a, line in
                if options.contains(.EmptyLineDrop) && isEmptyLine(line, separator: separator) {
                    return a
                }
                var accum = a
                accum.append(line.componentsSeparatedByString(separator))
                return accum
            }
        }
        return []
    }

    private func isEmptyLine(line: String, separator: String) -> Bool {
        return line.isEmpty || line.stringByReplacingOccurrencesOfString(separator, withString: "").isEmpty
    }

}
