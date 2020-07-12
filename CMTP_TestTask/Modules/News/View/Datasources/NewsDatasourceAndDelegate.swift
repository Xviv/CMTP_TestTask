//
//  NewsDatasourceAndDelegate.swift
//  CMTP_TestTask
//
//  Created by Dan on 12.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

//MARK: - Datasource
class NewsDatasourceAndDelegate: NSObject, UITableViewDataSource {
    
    weak var controller: NewsViewController?
    var news: [NewsResult] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableCell
        let model = news[indexPath.row]
        cell.model = model
        return cell
    }
    
    
}

//MARK: - Delegate
extension NewsDatasourceAndDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.3
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == news.count - 1 {
            controller?.presenter.getNextPage()
        }
    }
}
