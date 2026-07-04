import SwiftUI

public extension Image {
    func rowIcon() -> some View {
        resizable()
            .foregroundStyle(.secondary)
            .scaledToFit()
            .frame(width: UIScreen.width / 11, height: UIScreen.width / 11)
            .cornerRadius(SwTheme.cornerRadius)
    }
}

public struct SelectButton: View {
    public enum IconStyle {
        case rowIcon
        case thumbnail
        case font(Font)
    }

    let isSelected: Bool
    let imageName: String
    var selectedColor: Color = .blue1
    var unselectedColor: Color = .secondary
    var iconStyle: IconStyle = .rowIcon
    let action: () -> Void

    public init(isSelected: Bool, imageName: String, selectedColor: Color = .blue1, unselectedColor: Color = .secondary, iconStyle: IconStyle = .rowIcon, action: @escaping () -> Void) {
        self.isSelected = isSelected
        self.imageName = imageName
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        self.iconStyle = iconStyle
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            iconView
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private var iconView: some View {
        switch iconStyle {
        case .rowIcon:
            Image(systemName: imageNameToShow)
                .rowIcon()
                .foregroundColor(isSelected ? selectedColor : unselectedColor)
        case .thumbnail:
            Image(systemName: imageNameToShow)
                .thumbnailImg(color: isSelected ? selectedColor : unselectedColor)
        case .font(let font):
            Image(systemName: imageNameToShow)
                .font(font)
                .foregroundStyle(isSelected ? selectedColor : unselectedColor)
        }
    }

    private var selectedImageName: String {
        if imageName.contains(".circle") {
            return imageName
        }
        return "\(imageName).circle"
    }

    private var imageNameToShow: String {
        isSelected ? selectedImageName : "circle"
    }
}

