//
//  AlbumCell.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 21.10.2020.
//

//import GKViper
import GKRepresentable

class AlbumCell: TableCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func setupView() {
        backgroundColor = .clear
        
        titleLabel.text = nil
        titleView.apply(.cornerRadiusWithHalfHeightStyle())
    }
    
    override func updateViews() {
        guard let model = model as? AlbumCellModel else { return }
        titleLabel.text = model.title
    }
}
