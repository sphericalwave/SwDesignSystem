//
//  Image+.swift
//  fu3l
//
//  Created by Aaron Anthony on 2022-07-06.
//  Copyright © 2022 SphericalWaveSoftware. All rights reserved.
//

import UIKit

public extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let resizedImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return resizedImage
    }
}
