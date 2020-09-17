import XCTest
@testable import ProductHunt

#if canImport(UIKit)
final class ProductHuntTests: XCTestCase {
    private let fileManager: FileManager = .default
    
    func testSnapshotButton() {
        guard let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            XCTFail()
            return
        }
        
        var isDirectory: ObjCBool = false
        if !fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory) || !isDirectory.boolValue {
            XCTAssertNoThrow(try fileManager.createDirectory(at: url, withIntermediateDirectories: false))
        }
        
        let button = PHButton(frame: .init(x: 0, y: 0, width: 260, height: 60))
        button.setVotesCount(872)
        button.layoutIfNeeded()

        if let data = button.snapshot().pngData() {
            let url = url.appendingPathComponent("snapshot-product-hunt-button").appendingPathExtension("png")
            print(url.path)
            XCTAssertNoThrow(try data.write(to: url))
        } else {
            XCTFail()
        }
    }

    static var allTests = [
        ("snapshot button", testSnapshotButton),
    ]
}

fileprivate extension PHButton {
    func snapshot() -> UIImage {
        UIGraphicsImageRenderer(size: bounds.size).image { context in
            layer.render(in: context.cgContext)
        }
    }
}
#endif
