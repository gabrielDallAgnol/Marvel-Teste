//
//  CharactersController.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 22/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import RxSwift

class CharactersController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var noContentView: UIView!
    @IBOutlet var errorLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    var chars: [Character] = [] {
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
        setupTableView()
        setupSearchBar()
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        fetch(query: "", fetchLimit: limit, fetchOffset: offset, fetchMore: false)
    }
}

extension CharactersController: IndicatableView {
    
    func fetch(query: String = "", fetchLimit: Int, fetchOffset: Int, fetchMore: Bool) {
        self.noContentView.isHidden = true
        self.showActivityIndicator()
        switch fetchMore {
        case true:
            if !noMoreData {
            MarvelService
                .fetchCharacters(query: query, limit: fetchLimit, offset: fetchOffset)
                .subscribe(
                    onNext: { characters in
                        if characters.count == 0 {
                            self.noMoreData = true
                        }
                        self.chars += characters
                        self.hideActivityIndicator()
                },
                    onError: { characters in
                        self.noContentView.isHidden = false
                        self.hideActivityIndicator()
                }
                )
                .disposed(by: disposeBag)
            } else {
                self.hideActivityIndicator()
            }
        case false:
            MarvelService
                .fetchCharacters(query: query, limit: fetchLimit, offset: fetchOffset)
                .subscribe(
                    onNext: { characters in
                        self.noMoreData = false
                        self.offset = 0
                        self.chars = characters
                        self.hideActivityIndicator()
                },
                    onError: { error in
                        self.chars = []
                        self.noContentView.isHidden = false
                        self.errorLabel.text = error.localizedDescription + "\n Try reload, if it doesn't work reload the application."
                        self.hideActivityIndicator()
                }
                )
                .disposed(by: disposeBag)
        }
    }
}

extension CharactersController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        
        let character = chars[indexPath.row]
        cell.setup(char: character)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == chars.count - 2 {
            offset += limit
            fetch(query: searchBar.text ?? "", fetchLimit: limit, fetchOffset: offset, fetchMore: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let char = chars[indexPath.row]
        let content = self.storyboard!.instantiateViewController(withIdentifier: "CharacterDetail") as! CharacterDetailController
        content.char = char
        
        self.navigationController?.pushViewController(content, animated: true)
    }
}

extension CharactersController: UISearchBarDelegate {
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetch(query: "", fetchLimit: limit, fetchOffset: offset, fetchMore: false)
        self.view.endEditing(true)
        self.searchBar.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count < 2 {
            fetch(query: "", fetchLimit: limit, fetchOffset: offset, fetchMore: false)
        } else {
            fetch(query: searchText, fetchLimit: limit, fetchOffset: offset, fetchMore: false)
        }
    }
}
