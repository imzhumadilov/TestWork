//
//  AlbumListViewController.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper
import GKRepresentable

protocol AlbumListViewInput: ViperViewInput {
    func updateSections(_ sections: [TableSectionModel])
}

protocol AlbumListViewOutput: ViperViewOutput { }

class AlbumListViewController: ViperViewController, AlbumListViewInput {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Props
    fileprivate var output: AlbumListViewOutput? {
        guard let output = self._output as? AlbumListViewOutput else { return nil }
        return output
    }
    
    private var sections: [TableSectionModel] = []
    
    // MARK: - Lifecycle
    override func viewWillLayoutSubviews() {
        self.applyStyles()
    }
    
    // MARK: - Setup functions
    func setupComponents() {
        navigationItem.title = "Albums"
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
    
    func applyStyles() { }
    
    // MARK: - AlbumListViewInput
    override func setupInitialState(with viewModel: ViperViewModel) {
        super.setupInitialState(with: viewModel)
        
        self.setupComponents()
        self.setupActions()
    }
    
    func updateSections(_ sections: [TableSectionModel]) {
        self.sections = sections
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Actions
extension AlbumListViewController { }

// MARK: - Module functions
extension AlbumListViewController { }

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AlbumListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.sections[indexPath.section].rows[indexPath.row]
        return model.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = sections[indexPath.section].rows[indexPath.row]

        if let model = model as? AlbumCellModel {
            model.action?()
        }
    }
}
