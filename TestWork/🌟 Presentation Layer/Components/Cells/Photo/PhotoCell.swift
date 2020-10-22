//
//  PhotoCell.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

//import GKViper
import GKRepresentable

class PhotoCell: TableCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var photoImageView: UIImageView!
    
    override func setupView() {
        backgroundColor = .clear
        
        titleLabel.text = nil
    }
    
    override func updateViews() {
        guard let model = model as? PhotoCellModel else { return }
        titleLabel.text = model.photo.title
    }
}
