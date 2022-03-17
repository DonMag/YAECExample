//
//  Example2TableViewController.swift
//  YAECExample
//
//  Created by Don Mag on 3/17/22.
//

import UIKit

class Example2TableViewController: UITableViewController {


	var theData: [MyStruct] = []
	
	// so we can toggle the cell labels background colors
	//	for demonstration
	var showColors: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// get some sample data
		theData = SampleData().getSampleData()
		
		// register the cell
		tableView.register(Example2TableViewCell.self, forCellReuseIdentifier: Example2TableViewCell.reuseID)
		
		let b: UIBarButtonItem = UIBarButtonItem(title: "Toggle Colors", style: .done, target: self, action: #selector(self.toggleColors))
		navigationItem.rightBarButtonItem = b
		
	}
	
	@objc func toggleColors() -> Void {
		showColors.toggle()
		tableView.reloadData()
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return theData.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Example2TableViewCell.reuseID, for: indexPath) as! Example2TableViewCell
		
		let s = theData[indexPath.row]
		cell.setTheData(s, showColors: showColors)
		
		cell.didChangeHeight = { [weak self] c, isCollapsed in
			guard let self = self,
				  let pth = self.tableView.indexPath(for: c)
			else { return }
			// update our data source
			self.theData[pth.row].isExpanded = !isCollapsed
			// tell the tableView to re-run its layout
			self.tableView.performBatchUpdates(nil, completion: nil)
		}
		
		return cell
	}
	
}
