//
//  ComicController.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 26/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import RxSwift

class ComicsController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    private var disposeBag = DisposeBag()
    
    var comics: [Comic] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var noMoreData: Bool = false
    var limit: Int = 20
    var offset: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch(query: "", fetchLimit: limit, fetchOffset: offset, fetchMore: false)
        hideKeyboardWhenTappedAround()
        setupTableView()
        setupSearchBar()
    }
    
    
}

extension ComicsController: IndicatableView {
    
    func fetch(query: String = "", fetchLimit: Int, fetchOffset: Int, fetchMore: Bool) {
        self.showActivityIndicator()
        switch fetchMore {
        case true:
            if !noMoreData {
                MarvelService
                    .fetchComics(query: query, limit: fetchLimit, offset: fetchOffset)
                    .subscribe(
                        onNext: { comics in
                            
                            if comics.count == 0 {
                                self.noMoreData = true
                            }
                            
                            self.comics += comics
                            self.hideActivityIndicator()
                    },
                        onError: { comics in
                            self.hideActivityIndicator()
                    }
                    )
                    .disposed(by: disposeBag)
            } else {
                self.hideActivityIndicator()
            }
        case false:
            MarvelService
                .fetchComics(query: query, limit: fetchLimit, offset: fetchOffset)
                .subscribe(
                    onNext: { comics in
                        self.noMoreData = false
                        self.offset = 0
                        self.comics = comics
                        self.hideActivityIndicator()
                },
                    onError: { comics in
                        self.comics = []
                        self.hideActivityIndicator()
                }
                )
                .disposed(by: disposeBag)
        }
    }
}

extension ComicsController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UINib(nibName: "ComicCell", bundle: nil), forCellReuseIdentifier: "ComicCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicCell", for: indexPath) as! ComicCell
        
        let comic = comics[indexPath.row]
        cell.setup(comic: comic)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == comics.count - 2 {
            offset += limit
            fetch(query: searchBar.text ?? "", fetchLimit: limit, fetchOffset: offset, fetchMore: true)
        }
    }
}

extension ComicsController: UISearchBarDelegate {
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetch(query: "", fetchLimit: limit, fetchOffset: offset, fetchMore: false)
        self.view.endEditing(true)
        self.searchBar.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            fetch(query: "", fetchLimit: limit, fetchOffset: offset, fetchMore: false)
        } else {
            fetch(query: searchText, fetchLimit: limit, fetchOffset: offset, fetchMore: false)
        }
    }
}

