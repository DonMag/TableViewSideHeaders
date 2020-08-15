//
//  ViewController.swift
//  TableViewSideHeaders
//
//  Created by Don Mag on 8/13/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var frameSwitch: UISwitch!
	@IBOutlet var colorSwitch: UISwitch!

	private var showAlert: Bool = true
	
	private var sampleData: [MySection] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// get the data
		sampleData = SampleData().generateData()
		
		frameSwitch.isOn = false
		colorSwitch.isOn = false
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? SideHeadersTableViewController {
			vc.showFrames = frameSwitch.isOn
			vc.showSectionColors = colorSwitch.isOn
			vc.myData = sampleData
		}
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if showAlert {
			showAlert = false
			let vc = UIAlertController(title: "Please Note", message: "This is Example Code only.\n\nIt should not be considered \"Production Ready\"!", preferredStyle: .alert)
			vc.addAction(UIAlertAction(title: "OK", style: .default))
			present(vc, animated: true, completion: nil)
		}
	}
	
}

