# SwDesignSystem

Shared SwiftUI design system: theming, buttons, rows, charts, image editing, date
pickers, popups/toasts, and misc view modifiers used across apps.

## Requirements

- iOS 17+
- Swift 5.9+

## Installation

```swift
.package(url: "https://github.com/sphericalwave/SwDesignSystem.git", branch: "main")
```

## Overview

- `SwTheme` — shared color/style theme
- `SwGradient`, `HdrText`, `SplashScreen`, `CircularProgressView`, `ZeroPointSpin` — themed display components
- `Buttons/` — button library (`SuperBtn`, `LrgBtn`, `NavBtn`, `EditBtn`, `DeleteBtn`, `CheckBtn`, `BodyBtn`, `ImgTxtBtn`, `PulseBtn`, and more in `SwButtons.swift`)
- `Rows/` / `Rows 2/` — list row components (value rows, date/mass/length rows, validating text input rows)
- `Charts/` — `BarChartView`, `TempChart`, chart data types and modifiers
- `Images/` — image cropping, camera capture, and profile-image editing (`EditImageView`, `CropView`, `CameraView`)
- `Date/` — `SwDatePicker` and date formatting/readability helpers
- `Notifications/` — local notification scheduling and in-app notification UI
- `Popup/` — `Popup`, `Loader`, toast modifier
- `Fields/` — value entry fields
- `Modifiers/` — `NumbersOnlyViewModifier`, `BoundedRangeViewModifier`
- `InfinitePageView/` — infinite horizontal paging, including a date-based variant
- Misc extensions: `Color+`, `UIColor+`, `Image+`, `UIScreen+`, `Date+`, `Sequence+`, `Double+`

## Dependencies

None.
