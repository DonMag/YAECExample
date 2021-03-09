//
//  Example1TableViewController.swift
//  YAECExample
//
//  Created by Don Mag on 3/9/21.
//

import UIKit

class Example1TableViewController: UITableViewController {

	var theData: [MyStruct] = []
	
	// so we can toggle the cell labels background colors
	//	for demonstration
	var showColors: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// get some sample data
		theData = SampleData().getSampleData()
		
		// register the cell
		tableView.register(Example1TableViewCell.self, forCellReuseIdentifier: Example1TableViewCell.reuseID)
		
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Example1TableViewCell.reuseID, for: indexPath) as! Example1TableViewCell

		let s = theData[indexPath.row]
		cell.setTheData(s, showColors: showColors)
		//cell.setData(s.title, strDesc: s.desc, isExpanded: s.isExpanded)

		cell.didChangeHeight = { [weak self] isCollapsed in
			guard let self = self else { return }
			// update our data source
			self.theData[indexPath.row].isExpanded = !isCollapsed
			// tell the tableView to re-run its layout
			self.tableView.performBatchUpdates(nil, completion: nil)
		}

        return cell
    }

}
