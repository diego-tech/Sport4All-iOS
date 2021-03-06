//
//  SettingsViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 8/3/22.
//

import UIKit

struct SettingsSection {
	let title: String
	let options: [SettingsOption]
}

struct SettingsOption {
	let title: String
	let icon: UIImage?
	let tintColor: UIColor
	let optionType: SettingsOptionEnum
	let handler: ((SettingsOption) -> Void)
}

enum SettingsOptionEnum {
	case EditProfile
	case ContactUs
	case ShowTutorial
	case LogOut
}

protocol SettingsViewControllerDelegate {
	func settingsViewController(_ settingsViewController: SettingsViewController, didSelectOption option: SettingsOption)
}

class SettingsViewController: UIViewController {
	
	private let tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
		table.backgroundColor = .backgroundColor
		return table
	}()
	
	var models = [SettingsSection]()
	
	var settingsDelegate: SettingsViewControllerDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		configure()
		
		self.view.addSubview(tableView)
		
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.frame = view.bounds
		tableView.separatorColor = .hardColor
	}
	
	override func updateViewConstraints() {
		let height: CGFloat = 400
		self.view.frame.size.height = height
		self.view.frame.origin.y = UIScreen.main.bounds.height - height
		
		self.view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
		
		super.updateViewConstraints()
	}
	
	func configure() {
		models.append(SettingsSection(title: "Configuración", options: [
			SettingsOption(title: "Editar Perfil", icon: UIImage(systemName: "pencil.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), tintColor: .hardColor ?? .black, optionType: .EditProfile) { [self] option in
				settingsDelegate?.settingsViewController(self, didSelectOption: option)
				dismiss(animated: true, completion: nil)
			},
			SettingsOption(title: "Contacta con Nosotros", icon: UIImage(systemName: "person.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), tintColor: .hardColor ?? .black, optionType: .ContactUs) { [self] option in
				settingsDelegate?.settingsViewController(self, didSelectOption: option)
				dismiss(animated: true, completion: nil)
			},
			SettingsOption(title: "Ver Tutorial", icon: UIImage(systemName: "eye.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), tintColor: .hardColor ?? .black, optionType: .ShowTutorial) { [self] option in
				dismiss(animated: true) {
					self.settingsDelegate?.settingsViewController(self, didSelectOption: option)
				}
			},
			SettingsOption(title: "Cerrar Sesión", icon: UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), tintColor: .red, optionType: .LogOut) { [self] option in
				settingsDelegate?.settingsViewController(self, didSelectOption: option)
				dismiss(animated: true, completion: nil)
			}
		]))
	}
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return models.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models[section].options.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = models[indexPath.section].options[indexPath.row]
		guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
			return UITableViewCell()
		}
		
		cell.configure(with: model)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = models[indexPath.section].options[indexPath.row]
		model.handler(model)
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return models[section].title
	}
	
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		guard let header = view as? UITableViewHeaderFooterView else { return }
		header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
		header.textLabel?.textColor = .corporativeColor
		header.contentView.backgroundColor = .softBlue
		header.textLabel?.textAlignment = .left
	}
}
