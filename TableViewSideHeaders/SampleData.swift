//
//  SampleData.swift
//  SideHeaderss
//
//  Created by Don Mag on 8/13/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

class SampleData: NSObject {

	// just some sample data
	// 9 sections, each with 3 to 6 items
	func generateData() -> [MySection] {
		
		let colors: [UIColor] = [
			.red, .green, .blue,
			.orange, .purple, .magenta,
			.init(red: 0.75, green: 0.00, blue: 0.00, alpha: 1.0),
			.init(red: 0.00, green: 0.75, blue: 0.00, alpha: 1.0),
			.init(red: 0.00, green: 0.00, blue: 0.75, alpha: 1.0),
		]
		
		var sections: [MySection] = []
		
		for i in 0..<colors.count {
			
			let numItems = Int.random(in: 3...6)
			
			var items: [MyItem] = []
			
			for j in 0..<numItems {
				let item = MyItem(topValue: "Section \(i)", centerValue: "Row \(j)", bottomValue: "Bottom Label")
				items.append(item)
			}

			let section = MySection(headerImageName: "sec\(i)", headerTitle: "Sec: \(i)", color: colors[i], myItems: items)
			
			sections.append(section)
		
		}
		//sections = []
		return sections
		
	}
	
}
