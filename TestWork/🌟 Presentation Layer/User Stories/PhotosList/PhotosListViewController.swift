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
    func didSelect()
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
        self.navigationItem.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        tableView.registerCellNib(PhotoCell.self)
    }
    
    func setupActions() { }
    
    func applyStyles() { }
    
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
extension PhotosListViewController { }

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

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = sections[indexPath.section].rows[indexPath.row]
//
//        if let model = model as? AlbumCellModel {
//            output?.didSelect(album: model.album)
//        }
//    }
}
