//
//  ViewController.swift
//  YAECExample
//
//  Created by Don Mag on 3/9/21.
//

import UIKit

class ViewController: UIViewController {

	var firstView: Bool = true
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if firstView {
			firstView = false
			let vc = UIAlertController(title: "Please Note", message: "This is Example Code only. It should not be considered \"Production Ready\"!", preferredStyle: .alert)
			vc.addAction(UIAlertAction(title: "OK", style: .default))
			present(vc, animated: true, completion: nil)
		}
	}
	
	@IBAction func ex1Tapped(_ sender: Any) {
		let vc = Example1TableViewController()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
}

