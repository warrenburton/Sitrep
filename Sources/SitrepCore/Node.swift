//
// Node.swift
// Part of Sitrep, a tool for analyzing Swift projects.
//
// Copyright (c) 2020 Hacking with Swift
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE for license information
//

import Foundation

/// The root class for the types we can scan in code
public class Node: Encodable {
    /// The keys we need to write for debug output
    private enum CodingKeys: CodingKey {
        case cases, functions, types, variables
    }

    /// The parent of this node, so we can navigate back up the tree
    public weak var parent: Node?

    /// All the variables defined by this node
    public var variables = [Variable]()

    /// All the types defined inside this node
    public var types = [Type]()

    /// All the methods defined inside this node
    public var functions = [Function]()

    /// All the enum cases defined inside this node
    public var cases = [String]()

}
