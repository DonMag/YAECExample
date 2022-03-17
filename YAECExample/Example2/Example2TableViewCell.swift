//
//  Example2TableViewCell.swift
//  YAECExample
//
//  Created by Don Mag on 3/17/22.
//

import UIKit

// content of cell is:
//	"top stack row" is a horizontal stack view
//		with "Title" label and button
//	multi-line label

class Example2TableViewCell: UITableViewCell {

	static var reuseID: String = "ex2cell"
	
	public var didChangeHeight: ((UITableViewCell, Bool) -> ())?
	
	private let titleLabel = UILabel()
	private let descLabel = UILabel()
	private let toggleButton = UIButton()
	
	// these will be used to expand/collapse the cell
	private var expandedConstraint: NSLayoutConstraint!
	private var collapsedConstraint: NSLayoutConstraint!

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	func commonInit() -> Void {
		// button properties
		toggleButton.backgroundColor = .systemBlue
		toggleButton.setTitleColor(.white, for: .normal)
		toggleButton.setTitleColor(.gray, for: .highlighted)
		toggleButton.titleLabel?.font = .systemFont(ofSize: 14.0)
		toggleButton.setTitle("Expand", for: [])
		
		// label properties
		titleLabel.text = "Top Label"
		descLabel.text = "Bottom Label"
		titleLabel.font = .systemFont(ofSize: 18.0)
		descLabel.font = .italicSystemFont(ofSize: 15.0)
		
		descLabel.numberOfLines = 0
		
		// horizontal stack view for title label and button
		let hStack = UIStackView()
		hStack.spacing = 8
		
		// add titleLabel and button to hStack
		hStack.addArrangedSubview(titleLabel)
		hStack.addArrangedSubview(toggleButton)
		
		// add stack view and button to contentView
		contentView.addSubview(hStack)
		contentView.addSubview(descLabel)

		hStack.translatesAutoresizingMaskIntoConstraints = false
		descLabel.translatesAutoresizingMaskIntoConstraints = false

		// we'll use the margin guide
		let g = contentView.layoutMarginsGuide

		expandedConstraint = descLabel.bottomAnchor.constraint(equalTo: g.bottomAnchor)
		collapsedConstraint = hStack.bottomAnchor.constraint(equalTo: g.bottomAnchor)

		// use less-than-required priority to prevent
		//	subview "stretching" during animation
		expandedConstraint.priority = .required - 1
		collapsedConstraint.priority = .required - 1
		
		NSLayoutConstraint.activate([
			
			hStack.topAnchor.constraint(equalTo: g.topAnchor),
			hStack.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			hStack.trailingAnchor.constraint(equalTo: g.trailingAnchor),
			
			toggleButton.widthAnchor.constraint(equalToConstant: 72.0),
			
			descLabel.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 8.0),
			descLabel.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			descLabel.trailingAnchor.constraint(equalTo: g.trailingAnchor),
			
			// we start collapsed
			collapsedConstraint,

		])
		
		// set label Hugging and Compression to prevent them from squeezing/stretching
		titleLabel.setContentHuggingPriority(.required, for: .vertical)
		titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
		descLabel.setContentHuggingPriority(.required, for: .vertical)
		descLabel.setContentCompressionResistancePriority(.required, for: .vertical)
		
		contentView.clipsToBounds = true
		
		toggleButton.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
		
	}
	
	func setTheData(_ s: MyStruct, showColors: Bool = false) -> Void {
		titleLabel.text = s.title
		descLabel.text = s.desc
		
		collapsedConstraint.isActive = !s.isExpanded
		expandedConstraint.isActive = !collapsedConstraint.isActive

		descLabel.alpha = collapsedConstraint.isActive ? 0.0 : 1.0
		
		// label background colors if desired
		titleLabel.backgroundColor = showColors ? .green : .clear
		descLabel.backgroundColor = showColors ? .yellow : .clear
		
		updateButtonTitle()
	}
	
	func updateButtonTitle() -> Void {
		let t = collapsedConstraint.isActive ? "Expand" : "Collapse"
		toggleButton.setTitle(t, for: [])
	}
	
	@objc func toggleButtonTapped() -> Void {

		if collapsedConstraint.isActive {
			collapsedConstraint.isActive = false
			expandedConstraint.isActive = true
		} else {
			expandedConstraint.isActive = false
			collapsedConstraint.isActive = true
		}

		updateButtonTitle()

		// fade descLabel in/out
		UIView.animate(withDuration: 0.3, animations: {
			self.descLabel.alpha = self.collapsedConstraint.isActive ? 0.0 : 1.0
		})
		
		// use closure to tell the controller the cell content (height) changed
		// comment / un-comment this line to see the difference
		didChangeHeight?(self, collapsedConstraint.isActive)
	}
	
}
