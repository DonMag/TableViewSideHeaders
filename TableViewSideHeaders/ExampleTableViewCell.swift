//
//  ExampleTableViewCell.swift
//  TableViewSideHeaders
//
//  Created by Don Mag on 8/13/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

class ExampleTableViewCell: UITableViewCell {

	static let identifier: String = "ExampleTableViewCell"
	
	let topLabel: UILabel = {
		let v = UILabel()
		v.textColor = .lightGray
		return v
	}()
	let centerLabel: UILabel = {
		let v = UILabel()
		v.textColor = .gray
		return v
	}()
	let bottomLabel: UILabel = {
		let v = UILabel()
		v.textColor = .lightGray
		return v
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	func commonInit() -> Void {
		let sv = UIStackView()
		sv.axis = .vertical
		sv.spacing = 4
		sv.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(sv)
		[topLabel, centerLabel, bottomLabel].forEach {
			sv.addArrangedSubview($0)
		}
		let g = contentView.layoutMarginsGuide
		NSLayoutConstraint.activate([
			sv.topAnchor.constraint(equalTo: g.topAnchor),
			sv.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			sv.trailingAnchor.constraint(equalTo: g.trailingAnchor),
			sv.bottomAnchor.constraint(equalTo: g.bottomAnchor),
		])
	}

}
