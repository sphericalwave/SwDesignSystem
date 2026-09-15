//
// Created for MyBooks
// by  Stewart Lynch on 2023-10-15
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import SwiftUI

@available(iOS 15.0, *)
extension Color {

    public init?(hex: String) {
        guard let platformColor = PlatformColor(hex: hex) else { return nil }
        self.init(platformColor: platformColor)
    }

    public func toHexString(includeAlpha: Bool = false) -> String? {
        return PlatformColor(self).toHexString(includeAlpha: includeAlpha)
    }

}
