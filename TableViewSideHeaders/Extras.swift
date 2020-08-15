//
//  Extras.swift
//  TableViewSideHeaders
//
//  Created by Don Mag on 8/13/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

// MARK: Sample Data Structs
struct MyItem {
	var topValue: String = ""
	var centerValue: String = ""
	var bottomValue: String = ""
}

struct MySection {
	var headerImageName: String = ""
	var headerTitle: String = ""
	var color: UIColor = .white
	var myItems: [MyItem] = []
}

// Array extension to get distinct elements
extension Array where Element: Hashable {
	func distinct() -> Array<Element> {
		var set = Set<Element>()
		return filter { set.insert($0).inserted }
	}
}

// UIImage extension to create solid-color UIImage
extension UIImage {
	convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
		let rect = CGRect(origin: .zero, size: size)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
		color.setFill()
		UIRectFill(rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		guard let cgImage = image?.cgImage else { return nil }
		self.init(cgImage: cgImage)
	}
}

