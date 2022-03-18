//
//  Example3TableViewCell.swift
//  YAECExample
//
//  Created by Don Mag on 3/18/22.
//

import UIKit

class Example3TableViewCell: UITableViewCell {

	static var reuseID: String = "ex3cell"
	
	public var didChangeHeight: ((UITableViewCell, Bool) -> ())?
	
	private let vStack = UIStackView()
	private let titleLabel = UILabel()
	private let descLabel = UILabel()
	private let toggleButton = UIButton()
	
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
		
		// vertical stack view properties
		vStack.translatesAutoresizingMaskIntoConstraints = false
		vStack.axis = .vertical
		vStack.spacing = 8
		
		// horizontal stack view for title label and button
		let hStack = UIStackView()
		hStack.spacing = 8
		
		// add titleLabel and button to hStack
		hStack.addArrangedSubview(titleLabel)
		hStack.addArrangedSubview(toggleButton)
		
		// fill
		vStack.addArrangedSubview(hStack)
		vStack.addArrangedSubview(descLabel)
		
		// add stack view and button to contentView
		contentView.addSubview(vStack)
		
		// we'll use the margin guide
		let g = contentView.layoutMarginsGuide
		
		NSLayoutConstraint.activate([
			
			vStack.topAnchor.constraint(equalTo: g.topAnchor),
			vStack.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			vStack.trailingAnchor.constraint(equalTo: g.trailingAnchor),
			
			toggleButton.widthAnchor.constraint(equalToConstant: 72.0),
			
		])
		
		// we set the bottomAnchor constraint like this to avoid intermediary auto-layout warnings
		let c = vStack.bottomAnchor.constraint(equalTo: g.bottomAnchor)
		c.priority = UILayoutPriority(rawValue: 999)
		c.isActive = true
		
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
		descLabel.isHidden = !s.isExpanded
		
		// label background colors if desired
		titleLabel.backgroundColor = showColors ? .green : .clear
		descLabel.backgroundColor = showColors ? .yellow : .clear
		
		updateButtonTitle()
	}
	
	func updateButtonTitle() -> Void {
		let t = descLabel.isHidden ? "Expand" : "Collapse"
		toggleButton.setTitle(t, for: [])
	}
	
	@objc func toggleButtonTapped() -> Void {
//		descLabel.isHidden.toggle()
//		updateButtonTitle()
		
		// use closure to tell the controller the cell content (height) changed
		// comment / un-comment this line to see the difference
		didChangeHeight?(self, !descLabel.isHidden)
	}
	
}
