//
//  SideHeaderView.swift
//  TableViewSideHeaders
//
//  Created by Don Mag on 8/13/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

class SideHeaderView: UIView {
	
	let imgView: UIImageView = {
		let v = UIImageView()
		v.contentMode = .scaleAspectFit
		return v
	}()
	
	let label: UILabel = {
		let v = UILabel()
		v.textAlignment = .center
		return v
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	func commonInit() -> Void {
		backgroundColor = .white
		
		imgView.translatesAutoresizingMaskIntoConstraints = false
		label.translatesAutoresizingMaskIntoConstraints = false
		addSubview(imgView)
		addSubview(label)
		
		// padding is sides, top and bottom
		let topPadding: CGFloat = 0.0
		let sidePadding: CGFloat = 0.0
		let bottomPadding: CGFloat = 4.0
		
		// spacing is vertical space between image view and label
		let spacing: CGFloat = 4.0
		
		NSLayoutConstraint.activate([
			imgView.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
			imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sidePadding),
			imgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sidePadding),
			
			label.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: spacing),
			
			label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sidePadding),
			label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sidePadding),
			
			label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomPadding),
			
			// use 2.75:4 aspect ratio for image view (e.g. 275x400)
			imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor, multiplier: 4.0 / 2.75),
		])
		// add a border
		layer.borderColor = UIColor.lightGray.cgColor
		layer.borderWidth = 1
	}
	
}
