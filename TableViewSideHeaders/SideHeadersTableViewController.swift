//
//  SideHeadersTableViewController.swift
//  TableViewSideHeaders
//
//  Created by Don Mag on 8/13/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

class SideHeadersTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	private let tableView = UITableView()
	
	// will hold the "side-header" views
	private let sideHeaderContainerView = UIView()
	
	// will hold the top constraints for the "side-header" views
	private var headerTops: [NSLayoutConstraint] = []
	
	// will hold the bottom constraints for the "side-header" views
	private var headerBottoms: [NSLayoutConstraint] = []
	
	// we use this to know when the table has been loaded
	//	so the side-header views appear in the correct place on load
	private var readyForUpdate: Bool = false
	
	// at Zero, these will make the table view and "section" view fill the screen
	private var tableTop: CGFloat = 0.0
	private var tableBottom: CGFloat = 0.0
	private var tableSides: CGFloat = 0.0
	
	// horizontal space between section view and table view
	private var spacing: CGFloat = 0.0
	
	// width for section view (holds the side-headers)
	private var headersWidth: CGFloat = 100.0
	
	// padding on sides of side-header views
	private var headersLeftSidePadding: CGFloat = 8.0
	private var headersRightSidePadding: CGFloat = 0.0
	
	// set this to TRUE to use colors to show the sections
	var showSectionColors: Bool = false
	
	// set this to TRUE to use insets to show the frames
	var showFrames: Bool = false
	
	// data
	var myData: [MySection] = []
	
	// MARK: View Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// MARK: section colors and frame insets
		
		if showSectionColors {
			view.backgroundColor = UIColor(red: 0.5, green: 0.33, blue: 0.0, alpha: 1.0)
			tableView.backgroundColor = UIColor(red: 1.0, green: 0.85, blue: 0.75, alpha: 1.0)
			sideHeaderContainerView.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
		}
		if showFrames {
			
			// use back colors so we can see the frames
			view.backgroundColor = UIColor(red: 0.5, green: 0.33, blue: 0.0, alpha: 1.0)
			tableView.backgroundColor = UIColor(red: 1.0, green: 0.85, blue: 0.75, alpha: 1.0)
			sideHeaderContainerView.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
			
			// at Zero, these will make the table view and "section" view fill the screen
			tableTop = 20.0
			tableBottom = 20.0
			tableSides = 20.0
			
			// horizontal space between section view and table view
			spacing = 20.0
			
			// width for section view (holds the side-headers)
			headersWidth = 100.0
			// padding on sides of side-header views
			headersLeftSidePadding = 8.0
			headersRightSidePadding = 8.0
			
		}
		
		// MARK: UI setup
		
		tableView.register(ExampleTableViewCell.self, forCellReuseIdentifier: ExampleTableViewCell.identifier)
		tableView.dataSource = self
		tableView.delegate = self
		
		sideHeaderContainerView.clipsToBounds = true
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		sideHeaderContainerView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(tableView)
		view.addSubview(sideHeaderContainerView)
		
		let g = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			
			sideHeaderContainerView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: tableSides),
			
			sideHeaderContainerView.widthAnchor.constraint(equalToConstant: headersWidth),
			
			tableView.topAnchor.constraint(equalTo: g.topAnchor, constant: tableTop),
			tableView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -tableSides),
			tableView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -tableBottom),
			
			tableView.leadingAnchor.constraint(equalTo: sideHeaderContainerView.trailingAnchor, constant: spacing),
			
			sideHeaderContainerView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 0.0),
			sideHeaderContainerView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0.0),
			
		])
		
		// MARK: create the side-header views
		for i in 0..<myData.count {
			let thisSection = myData[i]
			let hv = SideHeaderView()
			hv.label.text = thisSection.headerTitle
			if let img = UIImage(named: thisSection.headerImageName) {
				hv.imgView.image = img
			} else {
				// if we couldn't load headerImageName
				if #available(iOS 13.0, *) {
					// try to create a systemName image
					if let img = UIImage(systemName: "\(i).circle.fill") {
						hv.imgView.image = img.withTintColor(thisSection.color, renderingMode: .alwaysOriginal)
					} else {
						// no section image, and failed to create systemName image
						//	so 50x80 solid color image
						let img = UIImage(color: thisSection.color, size: CGSize(width: 50.0, height: 80.0))
						hv.imgView.image = img
					}
				} else {
					// no section image, and iOS < 13, so cannot use systemName image
					//	so 50x80 solid color image
					let img = UIImage(color: thisSection.color, size: CGSize(width: 50.0, height: 80.0))
					hv.imgView.image = img
				}
			}
			hv.translatesAutoresizingMaskIntoConstraints = false
			// add the side-header view to the container view
			sideHeaderContainerView.addSubview(hv)
		}
		
		// MARK: setup constraints for side-header views
		for i in 0..<(sideHeaderContainerView.subviews.count) {
			let v = sideHeaderContainerView.subviews[i]
			
			// constrain leading and trailing of side-header in the sideHeaderContainerView
			v.leadingAnchor.constraint(equalTo: sideHeaderContainerView.leadingAnchor, constant: headersLeftSidePadding).isActive = true
			v.trailingAnchor.constraint(equalTo: sideHeaderContainerView.trailingAnchor, constant: -headersRightSidePadding).isActive = true
			
			// create top constraint - start with all section views out-of-view
			let c = v.topAnchor.constraint(equalTo: sideHeaderContainerView.topAnchor, constant: 2000)
			c.priority = .defaultHigh
			c.isActive = true
			headerTops.append(c)
			
			// if it's not the last side-header, also needs a bottom constraint to the next side-header
			if v != sideHeaderContainerView.subviews.last {
				let vNext = sideHeaderContainerView.subviews[i+1]
				let c = v.bottomAnchor.constraint(lessThanOrEqualTo: vNext.topAnchor)
				c.priority = .defaultLow
				c.isActive = true
				headerBottoms.append(c)
			}
			
			// set them all hidden to start
			v.isHidden = true
		}

	}
	
	// MARK: scroll delegate
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		updateSideHeaders(scrollView)
	}
	
	// MARK: load helper
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		// this let's us know when the table view has initially been loaded
		//	so we can place the side-headers properly
		if !readyForUpdate {
			if let lastPath = tableView.indexPathsForVisibleRows?.last {
				if indexPath == lastPath {
					readyForUpdate = true
					updateSideHeaders(tableView)
				}
			}
		}
	}
	
	// MARK: TableView funcs
	func numberOfSections(in tableView: UITableView) -> Int {
		return myData.count
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myData[section].myItems.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let c = tableView.dequeueReusableCell(withIdentifier: ExampleTableViewCell.identifier, for: indexPath) as! ExampleTableViewCell
		
		let thisSectionData = myData[indexPath.section]
		let thisRowData = thisSectionData.myItems[indexPath.row]
		
		c.topLabel.text = thisRowData.topValue
		c.centerLabel.text = thisRowData.centerValue
		c.bottomLabel.text = thisRowData.bottomValue
		
		if showSectionColors {
			// set background colors so we can see the frames easily
			c.contentView.backgroundColor = thisSectionData.color
			c.topLabel.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
			c.centerLabel.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
			c.bottomLabel.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
		}
		
		return c
	}
	
	// MARK: side-header views updating
	func updateSideHeaders(_ scrollView: UIScrollView) -> Void {
		
		// get array of IndexPath for visible cells
		guard let iPaths = tableView.indexPathsForVisibleRows else { return }
		
		// array of visible "row 0" cells
		let zeroRows = iPaths.filter { $0.row == 0 }
		
		// a section's row 0 may be scrolled up and not visible
		// so get an array of visible sections (Int values)
		let visibleSections = iPaths
			.compactMap { $0.section }
			.distinct()
		
		// show or hide "side-header" based on section visibility
		for i in 0..<sideHeaderContainerView.subviews.count {
			sideHeaderContainerView.subviews[i].isHidden = !visibleSections.contains(i)
		}
		
		// for each visible "row 0"
		zeroRows.forEach { pth in
			// get the rect for the row
			let r = tableView.rectForRow(at: pth)
			// set side-header view's top constant
			headerTops[pth.section].constant = max(0.0, r.origin.y - tableView.contentOffset.y)
		}
		
		for i in 0..<visibleSections.count {
			let sec = visibleSections[i]
			// if it's not the last section
			if sec < (sideHeaderContainerView.subviews.count - 1) {
				// get references to side-header and the one below
				let v1 = sideHeaderContainerView.subviews[sec]
				let v2 = sideHeaderContainerView.subviews[sec+1]
				// if the frames overlap
				if v1.frame.maxY >= v2.frame.minY {
					// give bottom constraint higher priority
					headerTops[sec].priority = .defaultLow
					headerBottoms[sec].priority = .defaultHigh
				} else {
					// give top constraint higher priority
					headerBottoms[sec].priority = .defaultLow
					headerTops[sec].priority = .defaultHigh
				}
				
				// if side-header top is > 0,
				//	give top constraint higher priority
				if v1.frame.minY > 0.0 {
					headerBottoms[sec].priority = .defaultLow
					headerTops[sec].priority = .defaultHigh
				}
			}
		}
		
	}
	
}

