//
//  Example3TableViewController.swift
//  YAECExample
//
//  Created by Don Mag on 3/18/22.
//

import UIKit

class Example3TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	var tableView = UITableView()
	var bConst: NSLayoutConstraint!
	
	var theData: [MyStruct] = []
	
	// so we can toggle the cell labels background colors
	//	for demonstration
	var showColors: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		let g = view.safeAreaLayoutGuide
		bConst = tableView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 2000)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: g.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
			bConst,
		])
		
		// get some sample data
		theData = SampleData().getSampleData()
		
		// register the cell
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
		
		cell.didChangeHeight = { [weak self] c, isCollapsed in
			guard let self = self,
				  let pth = self.tableView.indexPath(for: c)
			else { return }
			// update our data source
			self.theData[pth.row].isExpanded = !isCollapsed

			// tell the tableView to re-run its layout

			UIView.animate(withDuration: 2.0, animations: {
				self.tableView.performBatchUpdates(nil, completion: nil)
			})
			return()
			
			//self.bConst.constant = self.tableView.frame.height
			
			UIView.animate(
				withDuration: 0.3,
				delay: 0.05,
				options: .curveEaseOut,
				animations: { [weak self] in
					guard let self = self else { return }
					self.tableView.performBatchUpdates(nil, completion: nil)
					//self.tableView.reloadRows(at: [pth], with: .none)
				},
				completion: { [weak self] (_: Bool) in
					guard let self = self else { return }
					// reset collection view height
					//self.bConst.constant = 0
				}
			)

//			DispatchQueue.main.async {
//				self.tableView.performBatchUpdates(nil, completion: nil)
//				//self.tableView.reloadRows(at: [pth], with: .automatic)
//				DispatchQueue.main.async {
//					self.bConst.constant = 0
//				}
//			}
//			UIView.animate(withDuration: 0.93, animations: {
				//self.tableView.reloadRows(at: [pth], with: .automatic)
//			})
//			self.tableView.reloadData()
			//self.tableView.reloadRows(at: [pth], with: .automatic)
			//self.tableView.performBatchUpdates(nil, completion: nil)
		}
		
		return cell
	}
	
}
