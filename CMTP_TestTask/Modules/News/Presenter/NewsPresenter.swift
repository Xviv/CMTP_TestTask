//
//  NewsPresenter.swift
//  CMTP_TestTask
//
//  Created by Dan on 12.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation

protocol NewsPresenterProtocol: class {
    init(view: NewsViewProtocol)
    
    func viewDidLoad()
    func searchTextDidChange(_ text: String)
    func searchButtonClicked(_ text: String)
    func getNextPage()
}

class NewsPresenter {
    
    private weak var view: NewsViewProtocol!
    var router: NewsRouterProtocol!
    
    private var isLoading: Bool = false
    private var results: [NewsResult] = []
    private var currentPage: Int = 1
    private var query: String?
    
    //MARK: - Init
    required init(view: NewsViewProtocol) {
        self.view = view
    }
    
    //MARK: - Private methods
    func getNews(at page: Int, for query: String?) {
        self.query = query
        guard !isLoading else { return }
        isLoading = true
        
        APIService.shared.getNews(at: page, for: query) { (result) in
            switch result {
            case .success(let news):
                if page == 1 {
                    self.results = news.response.results
                    self.view.setupTableView(with: self.results)
                } else {
                    let index = self.results.count
                    self.results.append(contentsOf: news.response.results)
                    self.view.insert(news.response.results, at: index)
                }
                self.currentPage += 1
            case .failure(let error):
                print(error)
                self.view.setupTableView(with: [])
            }
            
            self.isLoading = false
        }
    }
}

//MARK: - Output

extension NewsPresenter: NewsPresenterProtocol {
    
    func getNextPage() {
        getNews(at: currentPage, for: query)
    }
    
    func viewDidLoad() {
        getNews(at: currentPage, for: nil)
    }
    
    func searchTextDidChange(_ text: String) {
        currentPage = 1
        getNews(at: currentPage, for: text)
    }
    
    func searchButtonClicked(_ text: String) {
        currentPage = 1
        getNews(at: currentPage, for: text)
    }
}
