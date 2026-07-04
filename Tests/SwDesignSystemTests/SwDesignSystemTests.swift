import XCTest
import SwiftUI
@testable import SwDesignSystem

final class SwDesignSystemTests: XCTestCase {

    func testUIColorHexRoundTrip() {
        // init(hex:) is internal; @testable makes it visible.
        let color = UIColor(hex: "#3366FF")
        XCTAssertNotNil(color)
        XCTAssertEqual(color?.toHexString()?.uppercased(), "#3366FF")
    }

    func testUIColorHexRejectsJunk() {
        XCTAssertNil(UIColor(hex: "not-a-color"))
    }

    func testValueFieldsInstantiate() {
        _ = DoubleTF(double: .constant(72.5), placeholder: "weight")
        _ = DoubleNegTF(double: .constant(-3), placeholder: "±")
        _ = DoubleTFv2(double: .constant(1))
        _ = IntegerTF(int: .constant(10))
        _ = CurrencyTF(value: .constant(9.99))
        _ = LengthTF(inches: .constant(60), isInches: .constant(true))
        _ = MassTF(pounds: .constant(150), isPounds: .constant(true))
        _ = HdrText(text: "Header")
    }
}
