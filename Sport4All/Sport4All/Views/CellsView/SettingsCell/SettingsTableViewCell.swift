//
//  SettingsTableViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 8/3/22.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

	static let identifier = "SettingsTableViewCell"
	
	private let iconContainer: UIView = {
		let view = UIView()
		view.clipsToBounds = true
		view.layer.cornerRadius = 8
		view.layer.masksToBounds = true
		view.backgroundColor = .backgroundColor
		return view
	}()
	
	private let iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.tintColor = .white
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let label: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(label)
		contentView.addSubview(iconContainer)
		iconContainer.addSubview(iconImageView)
		
		contentView.clipsToBounds = true
		self.backgroundColor = .backgroundColor
		self.selectionStyle = .none
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		let size: CGFloat = contentView.frame.size.height - 12
		iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
		
		let imageSize = size/1.5
		iconImageView.frame = CGRect(x: (size - imageSize) / 2, y: (size - imageSize) / 2, width: imageSize, height: imageSize)
		
		label.frame = CGRect(x: 25 + iconContainer.frame.size.width,
							 y: 0,
							 width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
							 height: contentView.frame.size.height)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		iconImageView.image = nil
		label.text = nil
		iconContainer.backgroundColor = nil
	}
	
	public func configure(with model: SettingsOption) {
		label.text = model.title
		label.textColor = model.tintColor
		iconImageView.image = model.icon
		iconImageView.tintColor = model.tintColor
	}
}
