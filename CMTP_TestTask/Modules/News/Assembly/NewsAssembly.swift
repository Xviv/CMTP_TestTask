//
//  NewsAssembly.swift
//  CMTP_TestTask
//
//  Created by Dan on 12.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

protocol NewsAssemblyProtocol: class {
    func configure(with viewController: NewsViewController)
}

class NewsAssembly: NewsAssemblyProtocol {
    func configure(with viewController: NewsViewController) {
        let presenter = NewsPresenter(view: viewController)
        let router = NewsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.router = router
    }
}
