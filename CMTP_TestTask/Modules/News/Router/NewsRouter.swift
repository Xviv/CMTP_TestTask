//
//  NewsRouter.swift
//  CMTP_TestTask
//
//  Created by Dan on 12.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

protocol NewsRouterProtocol: class {
    
}

class NewsRouter {
    
    weak var viewController: NewsViewController!
    
    //MARK: - Init
    init(viewController: NewsViewController) {
        self.viewController = viewController
    }
}

//MARK: - Output

extension NewsRouter: NewsRouterProtocol {
    
}
