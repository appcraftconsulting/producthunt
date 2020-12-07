import XCTest
@testable import ProductHunt

#if canImport(UIKit)
final class ProductHuntTests: XCTestCase {
    private let fileManager: FileManager = .default
    
    func testSnapshotFeaturedButton() {
        let frame = CGRect(x: 0, y: 0, width: 260, height: 60)
        let button = PHFeaturedButton(frame: frame)
        button.setVotesCount(872)
        button.layoutIfNeeded()

        if let data = button.snapshot().pngData(), let url = getCacheUrl() {
            let url = url
                .appendingPathComponent("snapshot-featured-button")
                .appendingPathExtension("png")

            XCTAssertNoThrow(try data.write(to: url))
        } else {
            XCTFail()
        }
    }
    
    func testSnapshotTopPostDailyButton() {
        let frame = CGRect(x: 0, y: 0, width: 260, height: 60)
        let button = PHTopPostDailyButton(frame: frame, position: .second)
        button.layoutIfNeeded()

        if let data = button.snapshot().pngData(), let url = getCacheUrl() {
            let url = url
                .appendingPathComponent("snapshot-top-post-daily-button")
                .appendingPathExtension("png")

            XCTAssertNoThrow(try data.write(to: url))
        } else {
            XCTFail()
        }
    }
    
    // MARK: - Static functions

    static var allTests = [
        ("Featured Button", testSnapshotFeaturedButton),
        ("Top Post Daily Button", testSnapshotTopPostDailyButton)
    ]
    
    // MARK: - Private functions

    private func getCacheUrl() -> URL? {
        guard let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        var isDirectory: ObjCBool = false
        if !fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory) || !isDirectory.boolValue {
            try? fileManager.createDirectory(at: url, withIntermediateDirectories: false)
        }
        
        return url
    }
}

fileprivate extension UIButton {
    func snapshot() -> UIImage {
        UIGraphicsImageRenderer(size: bounds.size).image { context in
            layer.render(in: context.cgContext)
        }
    }
}
#endif
