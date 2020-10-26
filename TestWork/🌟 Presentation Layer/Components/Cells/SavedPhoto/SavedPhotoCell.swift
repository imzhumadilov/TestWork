//
//  SavedPhotoCell.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//

import GKRepresentable
import Kingfisher

class SavedPhotoCell: TableCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var photoButton: UIButton!
    @IBOutlet private weak var photoImageView: UIImageView!
    
    override func setupView() {
        backgroundColor = .clear
        
        titleLabel.text = nil
        photoImageView?.image = nil
        photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
    }
    
    override func updateViews() {
        
        guard let model = model as? SavedPhotoCellModel else { return }
        
        titleLabel.text = model.title
        photoImageView.image = UIImage(data: model.imageData)
    }
    
    @objc
    private func photoButtonTapped() {
        guard let model = model as? SavedPhotoCellModel else { return }
        model.action?(model.imageData)
    }
}
