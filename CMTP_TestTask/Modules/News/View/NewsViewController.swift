//
//  NewsViewController.swift
//  CMTP_TestTask
//
//  Created by Dan on 12.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

protocol NewsViewProtocol: class {
    func setupTableView(with data: [NewsResult])
    func insert(_ data: [NewsResult], at index: Int)
}

class NewsViewController: UIViewController {
    
    var presenter: NewsPresenterProtocol!
    private let assembly: NewsAssemblyProtocol = NewsAssembly()
    private var dataSourceAndDelegate = NewsDatasourceAndDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assembly.configure(with: self)
        setupProperties()
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    //MARK: - UI Components
    
    private var mainView: NewsMainView = {
        let view = NewsMainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Constraints setup
    
    private func setupConstraints() {
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - Private methods
    
    private func setupProperties() {
        view.backgroundColor = .white
        dataSourceAndDelegate.controller = self
        mainView.tableView.dataSource = dataSourceAndDelegate
        mainView.tableView.delegate = dataSourceAndDelegate
        mainView.searchBar.delegate = self
    }
    
    //MARK: - Actions
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        presenter.searchTextDidChange(text)
    }
    
}

//MARK: - Output

extension NewsViewController: NewsViewProtocol {
    func setupTableView(with data: [NewsResult]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dataSourceAndDelegate.news = data
            self.mainView.tableView.reloadData()
        }
    }
    
    func insert(_ data: [NewsResult], at index: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dataSourceAndDelegate.news.append(contentsOf: data)
            let indexPaths = data.enumerated().map({ IndexPath(row: index + $0.offset, section: 0)})
            self.mainView.tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}

//MARK: - Searchbar delegate

extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.5)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        presenter.searchButtonClicked(text)
    }
}
