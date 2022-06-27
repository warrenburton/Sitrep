@testable import Sitrep
import XCTest
import class Foundation.Bundle

final class SitrepTests: XCTestCase {

    /// Returns path to the built products directory.
    var productsDirectory: URL {
        #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }

        fatalError("couldn't find the products directory")
        #else
        Bundle.main.bundleURL
        #endif
    }

    static var allTests = [

    ]
}
