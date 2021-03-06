//
//  PhotosListViewController.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper
import GKRepresentable

protocol PhotosListViewInput: ViperViewInput {
    func updateSections(_ sections: [TableSectionModel])
}

protocol PhotosListViewOutput: ViperViewOutput {
    func saveAlbum()
}

class PhotosListViewController: ViperViewController, PhotosListViewInput {

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Props
    fileprivate var output: PhotosListViewOutput? {
        guard let output = self._output as? PhotosListViewOutput else { return nil }
        return output
    }
    
    private var sections: [TableSectionModel] = []
    
    // MARK: - Lifecycle
    override func viewWillLayoutSubviews() {
        self.applyStyles()
    }
    
    // MARK: - Setup functions
    func setupComponents() {
        navigationItem.title = AppLocalization.Navigation.photos.localized
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: AppLocalization.General.save.localized,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightBarButtonItemTapped))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
        tableView.registerCellNib(PhotoCell.self)
    }
    
    func setupActions() { }
    
    func applyStyles() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
    }
    
    // MARK: - PhotosListViewInput
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
extension PhotosListViewController {
    
    @objc
    func rightBarButtonItemTapped() {
        output?.saveAlbum()
    }
}

// MARK: - Module functions
extension PhotosListViewController { }

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PhotosListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let model = sections[indexPath.section].rows[indexPath.row] as? PhotoCellModel,
              let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier) as? PhotoCell else { return UITableViewCell() }
        
        cell.model = model
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.sections[indexPath.section].rows[indexPath.row]
        return model.cellHeight
    }
}
