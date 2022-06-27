//
//  File 2.swift
//  
//
//  Created by Warren Burton on 19/06/2022.
//

import Foundation
import SwiftSyntax

protocol VisitorProtocol {
    var rootNode: Node { get }
    var strippedBody: String { get }
    var body: String { get }
    var imports: [String] { get }
}
