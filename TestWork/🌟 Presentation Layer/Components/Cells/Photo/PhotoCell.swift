//
//  PhotoCell.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

//import GKViper
import GKRepresentable
import Kingfisher

class PhotoCell: TableCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var photoButton: UIButton!
    @IBOutlet private weak var photoImageView: UIImageView!
    
    override func setupView() {
        backgroundColor = .clear
        
        titleLabel.text = nil
        photoImageView?.image = nil
        photoImageView.apply(.cornerRadiusWithHalfHeightStyle())
        photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
    }
    
    override func updateViews() {
        
        guard let model = model as? PhotoCellModel else { return }
        
        titleLabel.text = model.title
        photoImageView.kf.setImage(with: URL(string: model.thumbnailImageUrl))
    }
    
    @objc
    private func photoButtonTapped() {
        guard let model = model as? PhotoCellModel else { return }
        model.action?(model.imageUrl)
    }
}
