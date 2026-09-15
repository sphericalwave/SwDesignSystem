//
//  Platform.swift
//  SwDesignSystem
//
//  Cross-platform shims so shared views stay free of `#if os(...)`.
//  iOS behavior is unchanged; macOS gets the nearest native equivalent.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
public typealias PlatformColor = UIColor
public typealias PlatformImage = UIImage
public typealias PlatformTextContentType = UITextContentType
#elseif canImport(AppKit)
import AppKit
public typealias PlatformColor = NSColor
public typealias PlatformImage = NSImage
public typealias PlatformTextContentType = NSTextContentType
#endif

// MARK: - Screen

/// Main screen size. On macOS, the main display's visible frame.
public enum SwScreen {
    #if canImport(UIKit)
    public static let size = UIScreen.main.bounds.size
    #elseif canImport(AppKit)
    public static let size = NSScreen.main?.visibleFrame.size ?? CGSize(width: 1440, height: 900)
    #endif

    public static var width: CGFloat { size.width }
    public static var height: CGFloat { size.height }
}

// MARK: - Image & Color

public extension Image {
    init(platformImage: PlatformImage) {
        #if canImport(UIKit)
        self.init(uiImage: platformImage)
        #elseif canImport(AppKit)
        self.init(nsImage: platformImage)
        #endif
    }
}

public extension Color {
    init(platformColor: PlatformColor) {
        #if canImport(UIKit)
        self.init(uiColor: platformColor)
        #elseif canImport(AppKit)
        self.init(nsColor: platformColor)
        #endif
    }
}

// MARK: - Keyboard

/// Software keyboard hint. Applied on iOS; macOS has a hardware keyboard, so it's ignored there.
public enum SwKeyboardType {
    case `default`
    case decimalPad
    case numberPad
    case numbersAndPunctuation
    case alphabet
}

#if os(iOS)
private extension SwKeyboardType {
    var uiKeyboardType: UIKeyboardType {
        switch self {
        case .default: .default
        case .decimalPad: .decimalPad
        case .numberPad: .numberPad
        case .numbersAndPunctuation: .numbersAndPunctuation
        case .alphabet: .alphabet
        }
    }
}
#endif

// MARK: - View modifiers

public extension View {
    /// `.keyboardType(_:)` on iOS; a no-op on macOS.
    @ViewBuilder
    func swKeyboardType(_ type: SwKeyboardType) -> some View {
        #if os(iOS)
        self.keyboardType(type.uiKeyboardType)
        #else
        self
        #endif
    }

    /// `.listStyle(.grouped)` on iOS; the platform default on macOS, where `.grouped` is unavailable.
    @ViewBuilder
    func swGroupedList() -> some View {
        #if os(iOS)
        self.listStyle(.grouped)
        #else
        self
        #endif
    }

    /// Swipeable paging `TabView` on iOS; the platform default on macOS, where `.page` is unavailable.
    @ViewBuilder
    func swPageTabStyle() -> some View {
        #if os(iOS)
        self.tabViewStyle(.page(indexDisplayMode: .never))
        #else
        self
        #endif
    }
}

// MARK: - Toolbar placements

public extension ToolbarItemPlacement {
    /// `.navigationBarLeading` on iOS; `.cancellationAction` on macOS.
    static var swLeading: ToolbarItemPlacement {
        #if os(iOS)
        .navigationBarLeading
        #else
        .cancellationAction
        #endif
    }

    /// `.navigationBarTrailing` on iOS; `.primaryAction` on macOS.
    static var swTrailing: ToolbarItemPlacement {
        #if os(iOS)
        .navigationBarTrailing
        #else
        .primaryAction
        #endif
    }

    /// `.bottomBar` on iOS; `.automatic` on macOS, which has no bottom bar.
    static var swBottomBar: ToolbarItemPlacement {
        #if os(iOS)
        .bottomBar
        #else
        .automatic
        #endif
    }
}
