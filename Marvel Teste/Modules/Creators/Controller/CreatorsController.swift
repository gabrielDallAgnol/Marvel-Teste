//
//  CreatorsController.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 26/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import RxSwift

class CreatorsController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    private var disposeBag = DisposeBag()
    
    var creators: [Creator] = [] {
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

extension CreatorsController: IndicatableView {
    
    func fetch(query: String = "", fetchLimit: Int, fetchOffset: Int, fetchMore: Bool) {
        self.showActivityIndicator()
        switch fetchMore {
        case true:
            if !noMoreData {
                MarvelService
                    .fetchCreators(query: query, limit: fetchLimit, offset: fetchOffset)
                    .subscribe(
                        onNext: { creators in
                            
                            if creators.count == 0 {
                                self.noMoreData = true
                            }
                            
                            self.creators += creators
                            self.hideActivityIndicator()
                    },
                        onError: { creators in
                            self.hideActivityIndicator()
                    }
                    )
                    .disposed(by: disposeBag)
            } else {
                self.hideActivityIndicator()
            }
        case false:
            MarvelService
                .fetchCreators(query: query, limit: fetchLimit, offset: fetchOffset)
                .subscribe(
                    onNext: { creators in
                        self.noMoreData = false
                        self.offset = 0
                        self.creators = creators
                        self.hideActivityIndicator()
                },
                    onError: { creators in
                        self.creators = []
                        self.hideActivityIndicator()
                }
                )
                .disposed(by: disposeBag)
        }
    }
}

extension CreatorsController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UINib(nibName: "CreatorCell", bundle: nil), forCellReuseIdentifier: "CreatorCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreatorCell", for: indexPath) as! CreatorCell
        
        let creator = creators[indexPath.row]
        cell.setup(creator: creator)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == creators.count - 2 {
            offset += limit
            fetch(query: searchBar.text ?? "", fetchLimit: limit, fetchOffset: offset, fetchMore: true)
        }
    }
}

extension CreatorsController: UISearchBarDelegate {
    
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

