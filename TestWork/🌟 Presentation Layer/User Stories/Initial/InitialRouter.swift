//
//  InitialRouter.swift
//  Arcana
//
//  Created by  Кирилл on 10/26/19.
//  Copyright © 2019 AppCraft. All rights reserved.
//

import GKViper

protocol InitialRouterInput: ViperRouterInput {
    func presentMainTabBar()
}

class InitialRouter: ViperRouter, InitialRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: InitialViewController? {
        guard let mainController = self._mainController as? InitialViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - InitialRouterInput
    func presentMainTabBar() {
        DispatchQueue.main.async {
            let albumsVC = AlbumListAssembly.create()
            AlbumListAssembly.configure(with: albumsVC)
            let albumsNC = BasicNavigationController(rootViewController: albumsVC)
            
            let savedAlbumsVC = SavedAlbumsAssembly.create()
            SavedAlbumsAssembly.configure(with: savedAlbumsVC)
            let savedAlbumsNC = BasicNavigationController(rootViewController: savedAlbumsVC)
            
            let viewModel: [BasicTabBarViewModel] = [BasicTabBarViewModel(title: AppLocalization.TabBar.network.localized,
                                                                          controller: albumsNC),
                                                     BasicTabBarViewModel(title: AppLocalization.TabBar.database.localized,
                                                                          controller: savedAlbumsNC)]
            
            let tabVC = AZTabBarController(withTabIcons: viewModel.map({ $0.image ?? UIImage() }))
            
            for index in 0..<viewModel.count {
                tabVC.setTitle(viewModel[index].title, atIndex: index)
                tabVC.setViewController(viewModel[index].controller, atIndex: index)
            }
            
            tabVC.selectedColor = AppTheme.textMain
            tabVC.highlightColor = AppTheme.textMain
//            tabVC.defaultColor = AppTheme.subControls
            tabVC.buttonsBackgroundColor = .white
            tabVC.selectionIndicatorHeight = 0
            tabVC.selectionIndicatorColor = .clear
            tabVC.separatorLineColor = .clear
            tabVC.tabBarHeight = 59.0
            tabVC.statusBarStyle = .default
            tabVC.setIndex(1)
            
            tabVC.modalPresentationStyle = .fullScreen
            
            self.present(tabVC, animated: true)
        }
    }
    
    // MARK: - Module functions
}
