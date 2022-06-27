//
// Type.swift
// Part of Sitrep, a tool for analyzing Swift projects.
//
// Copyright (c) 2020 Hacking with Swift
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE for license information
//

import Foundation

/// One data type from our code, with a very loose definition of "type"
public class Type: Node {
    /// All the data we want to be able to write out for debugging purposes
    private enum CodingKeys: CodingKey {
        case name, type, inheritance, comments, body, strippedBody
    }

    /// The list of "types" we support
    public enum ObjectType: String {
        case `class`, `enum`, `extension`, `protocol`, `struct`
    }

    /// The name of the type, eg `ViewController`
    public let name: String

    /// The fully chained name of object
    public var resolvedName: String {
        var rname = name
        var _parent = parent
        while _parent != nil {
            if let pname = (_parent as? Type)?.name {
                rname = pname + "." + rname
            }
            _parent = _parent?.parent
        }
        return rname
    }

    /// The underlying type, e.g. class or struct
    public let type: ObjectType

    /// The inheritance clauses attached to this type, including protocol conformances
    public let inheritance: [String]

    /// An array of comments that describe this type
    public let comments: [Comment]

    /// The raw source code for this type
    public let body: String

    /// The source code for this type, minus empty lines and comments
    public let strippedBody: String

    public var canBeSubType: Bool {
        switch type {
        case .struct, .class, .enum, .protocol:
            return true
        default:
            return false
        }
    }

    /// Creates an instance of Type
    init(type: ObjectType, name: String, inheritance: [String], comments: [Comment], body: String, strippedBody: String) {
        self.type = type
        self.name = name
        self.inheritance = inheritance
        self.comments = comments
        self.body = body.trimmingCharacters(in: .whitespacesAndNewlines)
        self.strippedBody = body.removingDuplicateLineBreaks()
    }

    /// Encodes the type, so we can produce debug output
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(inheritance, forKey: .inheritance)
        try container.encode(comments, forKey: .comments)
        try container.encode(body, forKey: .body)
        try container.encode(strippedBody, forKey: .strippedBody)
    }
}
