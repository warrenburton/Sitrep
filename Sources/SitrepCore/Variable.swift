//
//  File 2.swift
//  
//
//  Created by Warren Burton on 20/06/2022.
//

import Foundation

/// Represents one variable in our parsed code.
public class Variable: Node, CustomStringConvertible {

    public var description: String {
        "\(isStatic ? "static ":"")\(letOrVar.rawValue) \(pattern)\(resolvedType.isEmpty  ? "":": \(resolvedType)")"
    }

    var resolvedType: String {
        return (identifierExpression ?? typeAnnotation ?? "").trimmingCharacters(in: .whitespaces)
    }

    public enum LetOrVar: String, Codable {
        case `let`
        case `var`
    }

    /// Whether the function is static or not
    public let isStatic: Bool

    public let letOrVar: LetOrVar

    /// The name of the varibale
    public let pattern: String

    /// The type of the variable
    public let typeAnnotation: String?

    /// The identifier from the init if available
    public var identifierExpression: String?

    /// The syntax that initializes the var
    public let initializer: String?


    enum CodingKeys:String, CodingKey {
        case isStatic
        case letOrVar
        case pattern
        case typeAnnotation
        case identifierExpression
        case initializer
    }

    init(isStatic: Bool, letOrVar: LetOrVar, pattern: String, typeAnnotation: String?, identifierExpression: String?, initializer: String?) {
        self.isStatic = isStatic
        self.letOrVar = letOrVar
        self.pattern = pattern
        self.typeAnnotation = typeAnnotation
        self.identifierExpression = identifierExpression
        self.initializer = initializer
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isStatic, forKey: .isStatic)
        try container.encode(letOrVar, forKey: .letOrVar)
        try container.encode(pattern, forKey: .pattern)
        try container.encodeIfPresent(typeAnnotation, forKey: .typeAnnotation)
        try container.encodeIfPresent(identifierExpression, forKey: .identifierExpression)
        try container.encodeIfPresent(initializer, forKey: .initializer)
    }



}
