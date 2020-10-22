//
//  InitialViewController.swift
//  Arcana
//
//  Created by  Кирилл on 10/26/19.
//  Copyright © 2019 AppCraft. All rights reserved.
//

import GKViper
import GKRepresentable

protocol InitialViewInput: ViperViewInput {
    func updateSections(_ sections: [TableSectionModel])
}

protocol InitialViewOutput: ViperViewOutput { }

class InitialViewController: ViperViewController, InitialViewInput {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Props
    fileprivate var output: InitialViewOutput? {
        guard let output = _output as? InitialViewOutput else { return nil }
        return output
    }
    
    private var sections: [TableSectionModel] = []
    
    // MARK: - Lifecycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        self.applyStyles()
    }
    
    // MARK: - Setup functions
    func setupComponents() {
        navigationItem.title = "".loc
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        tableView.registerCellNib(AlbumCell.self)
    }
    
    func setupActions() { }
    
    func applyStyles() {
        view.apply(.backgroundViewStyle())
    }

    override func setupInitialState(with viewModel: ViperViewModel) {
        super.setupInitialState(with: viewModel)
        
        setupComponents()
        setupActions()
    }

    // MARK: - InitialViewInput
    func updateSections(_ sections: [TableSectionModel]) {
        self.sections = sections
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Actions
extension InitialViewController { }

// MARK: - Animations
extension InitialViewController { }

// MARK: - Module functions
extension InitialViewController { }

// MARK: - UITableViewDelegate, UITableViewDataSource
extension InitialViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let model = sections[indexPath.section].rows[indexPath.row] as? AlbumCellModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier) as? AlbumCell else { return UITableViewCell() }
        
        cell.model = model
        return cell
        
    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let model = self.sections[indexPath.section].rows[indexPath.row]
//
//        if model is SearchElementCellModel {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier) as? SearchElementCell else { return UITableViewCell() }
//            cell.model = model
//            return cell
//        }
//
//        return UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let model = self.sections[indexPath.section].rows[indexPath.row]
//        return model.cellHeight
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = self.sections[indexPath.section].rows[indexPath.row]
//
//        if let model = model as? SearchElementCellModel {
//            self.output?.didSelect(element: model.element)
//        }
//    }
}
