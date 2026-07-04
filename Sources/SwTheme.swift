//
//  Styles.swift
//  FitWrenchData
//
//  Created by Aaron Anthony on 2020-08-10.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import UIKit
import SwiftUI

@available(iOS 14.0, *)
public final class SwTheme {

    // MARK: - Constants
    public static let cornerRadius: CGFloat = 9
    public static let bottomPadding: CGFloat = 9
    public static let shadowRadius: CGFloat = 1

    // MARK: - Configure

    /// The primary brand color as a SwiftUI Color. Apply via `.tint(SwTheme.primaryColor)` on your `WindowGroup`.
    public private(set) static var primaryColor: Color = Color(uiColor: .blue1)
    public private(set) static var onboardingBackground: UIColor = UIColor(red: 0.06, green: 0.07, blue: 0.09, alpha: 1)

    /// Call once at app launch, e.g. in `App.init()`.
    public static func configure(
        primaryColor: UIColor = .blue1,
        tintColor: UIColor = .white,
        titleColor: UIColor = .white
    ) {
        SwTheme.primaryColor = Color(uiColor: primaryColor)
        setupNavigationBar(background: primaryColor, title: titleColor, tint: tintColor)
        setupSegmentedControl(primaryColor: primaryColor)
        setupTextFields(primaryColor: primaryColor)
        setupSearchBar(primaryColor: primaryColor)
        UISwitch.appearance().onTintColor = primaryColor
    }

    // MARK: - Setup Methods

    private static func setupTextFields(primaryColor: UIColor) {
        UITextView.appearance().tintColor = primaryColor
        UITextField.appearance().tintColor = primaryColor
    }

    private static func setupNavigationBar(background: UIColor, title: UIColor, tint: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        let onboardingBackground = UIColor(red: 0.06, green: 0.07, blue: 0.09, alpha: 1)
        
        let gradientImage = createGradientImage(from: background, to: onboardingBackground, size: CGSize(width: 1, height: 44))
        appearance.backgroundImage = gradientImage

        let font = UIFont(name: "AvenirNext-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
        appearance.titleTextAttributes = [.foregroundColor: title, .font: font]
        appearance.largeTitleTextAttributes = [.foregroundColor: title, .font: font]
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: title, .font: font]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = tint

        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
    }

    private static func createGradientImage(from startColor: UIColor, to endColor: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }

        let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: [startColor.cgColor, endColor.cgColor] as CFArray,
            locations: [0, 1]
        )

        if let gradient = gradient {
            context.drawLinearGradient(
                gradient,
                start: CGPoint(x: 0, y: 0),
                end: CGPoint(x: 0, y: size.height),
                options: .drawsBeforeStartLocation
            )
        }

        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }

    private static func setupSegmentedControl(primaryColor: UIColor) {
        UISegmentedControl.appearance().selectedSegmentTintColor = primaryColor
        UISegmentedControl.appearance().backgroundColor = .white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: primaryColor], for: .normal)
    }

    private static func setupSearchBar(primaryColor: UIColor) {
        let searchBarBackground = UIColor(red: 0.06, green: 0.07, blue: 0.09, alpha: 1)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .clear //searchBarBackground
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = primaryColor
    }

    // MARK: - Utility

    public static func printAvailableFonts() {
        for family in UIFont.familyNames {
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
        }
    }
}
