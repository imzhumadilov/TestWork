//
//  StyleWrapper.swift
//  Arcana
//
//  Created by  Кирилл on 10/26/19.
//  Copyright © 2019 AppCraft. All rights reserved.
//

import UIKit

typealias Style<Element> = (Element) -> Void

enum StyleWrapper<Element> {
    case wrap(style: Style<Element>)
}

extension StyleWrapper where Element: UIView {
    
    static func backgroundViewStyle() -> StyleWrapper {
        return .wrap { view in
            view.backgroundColor = .lightGray
        }
    }
    
    static func backgroundClearStyle() -> StyleWrapper {
        return .wrap { view in
            view.backgroundColor = .clear
        }
    }
    
    static func cornerRadiusWithHalfHeightStyle() -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = view.bounds.height / 2
            view.layer.masksToBounds = true
        }
    }
}

extension StyleWrapper where Element: UIImageView {
    
    static func generalFitStyle() -> StyleWrapper {
        return .wrap { imageView in
            imageView.contentMode = .scaleAspectFit
            imageView.layer.masksToBounds = true
        }
    }
    
    static func generalFillStyle() -> StyleWrapper {
        return .wrap { imageView in
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
        }
    }
    
    static func cornerRadiusWithHalfHeightStyle() -> StyleWrapper {
        return .wrap { imageView in
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = imageView.bounds.height / 2
        }
    }
}

extension StyleWrapper where Element: UITableView {
    
    static func backgroundClearStyle() -> StyleWrapper {
        return .wrap { tableView in
            tableView.backgroundColor = .clear
        }
    }
}
