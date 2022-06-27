//
// Results.swift
// Part of Sitrep, a tool for analyzing Swift projects.
//
// Copyright (c) 2020 Hacking with Swift
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE for license information
//

import Foundation

public struct Results {
    /// All the files detected by this scan
    var files: [SourceFile]

    /// All the classes detected across all files
    public var classes = [Type]()

    /// All the structs detected across all files
    public var structs = [Type]()

    /// All the enums detected across all files
    public var enums = [Type]()

    /// All the protocols detected across all files
    public var protocols = [Type]()

    /// All the extensions detected across all files
    public var extensions = [Type]()

    /// All the imports detected across all files, stored with frequency
    public var imports = NSCountedSet()

    /// A string containing all code in all files
    public var totalCode = ""

    /// A string containing all stripped code in all files
    public var totalStrippedCode = ""

    /// The number of lines in the longest file
    public var longestFileLength = 0

    /// The File object storing the longest file that was scanned
    public var longestFile: SourceFile?

    /// The nmber of lines in the longest type
    public var longestTypeLength = 0

    /// The Type object storing the longest file that was scanned
    public var longestType: Type?

    /// A count of how many functions were detected
    public var functionCount = 0

    /// A count of how many functions were preceded by documentation comments
    public var documentedFunctionCount = 0

    /// The total number of lines of code scanned across all files
    public var totalLinesOfCode: Int {
        totalCode.lines.count
    }

    /// The total number of stripped lines of code scanned across all files
    public var totalStrippedLinesOfCode: Int {
        totalStrippedCode.lines.count
    }

    /// How many classes inherit from UIView
    public var uiKitViewCount: Int {
        classes.sum { $0.inheritance.first == "UIView" }
    }

    /// How many classes inherit from UIViewController
    public var uiKitViewControllerCount: Int {
        classes.sum { $0.inheritance.first == "UIViewController" }
    }

    /// How many structs conform to View
    public var swiftUIViewCount: Int {
        structs.sum { $0.inheritance.contains("View") }
    }
}
