//
//  Example3ViewController.swift
//  YAECExample
//
//  Created by Don Mag on 3/18/22.
//

import UIKit

class Example3ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	var tableView = UITableView()
	
	var theData: [MyStruct] = []
	
	// set this to a larger value - such as 2.0
	//	to see a slower version of the animation effect
	var animDuration: Double = 0.3
	
	// so we can toggle the cell labels background colors
	//	for demonstration
	var showColors: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: g.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
			
			// extend the table view well below the bottom of the view
			//	so we can avoid "quirky" cell rendering
			tableView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 2000),
		])
		
		// get some sample data
		theData = SampleData().getSampleData()
		
		// let's make the second row (Button) a much longer string
		//	to exaggerate the effect
		theData[1].desc += "\n\n" + (1...10) .map { "Line \($0)" } .joined(separator: "\n\n")
		
		// register the cell
		//	using Example 2 cell
		tableView.register(Example2TableViewCell.self, forCellReuseIdentifier: Example2TableViewCell.reuseID)
		
		let b: UIBarButtonItem = UIBarButtonItem(title: "Toggle Colors", style: .done, target: self, action: #selector(self.toggleColors))
		navigationItem.rightBarButtonItem = b
		
		tableView.dataSource = self
		tableView.delegate = self
		
	}
	
	var tbh: CGFloat = 0
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if tbh != tableView.frame.height {
			tbh = tableView.frame.height
			tableView.contentInset.bottom = tbh + view.safeAreaInsets.top + view.safeAreaInsets.bottom - view.frame.height
		}
	}
	
	@objc func toggleColors() -> Void {
		showColors.toggle()
		tableView.reloadData()
	}
	
	// MARK: - Table view data source
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return theData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Example2TableViewCell.reuseID, for: indexPath) as! Example2TableViewCell
		
		let s = theData[indexPath.row]
		cell.setTheData(s, showColors: showColors)
		cell.fadeDuration = animDuration
		
		cell.didChangeHeight = { [weak self] c, isCollapsed in
			guard let self = self,
				  let pth = self.tableView.indexPath(for: c)
			else { return }
			
			// update our data source
			self.theData[pth.row].isExpanded = !isCollapsed
			
			// tell the tableView to re-run its layout
			UIView.animate(withDuration: self.animDuration, animations: {
				self.tableView.performBatchUpdates(nil, completion: nil)
			})
			
		}
		
		return cell
	}
	
}
