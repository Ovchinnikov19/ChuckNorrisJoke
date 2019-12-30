//
//  FirstViewController.swift
//  ChuckNorrisJoke
//
//  Created by Eduard Ovchinnikov on 30.12.2019.
//  Copyright © 2019 Eduard Ovchinnikov. All rights reserved.
//

import UIKit

class JokesFinderController: UIViewController, UITextFieldDelegate {
    
    private let networkService = NetworkService()
    private var jokes: [Joke] = []
    private let reuseID = "JokeCell"
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var countField: UITextField!
    @IBOutlet weak var loadButton: UIButton!
    @IBAction func loadTapped(_ sender: UIButton) {
        guard let count = Int(countField.text ?? "") else { return }
        
        networkService.fetchResponse(count: count) { [unowned self] (jokes) in
            guard let jokes = jokes as? [Joke] else { return }
            self.jokes = jokes
            
            DispatchQueue.main.async {
                self.table.reloadData()
                self.countField.text = nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        setupButtonAndTextField()
        setupTableView()
    }
    
    func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "JokeCell")
    }
    
    func setupButtonAndTextField() {
        loadButton.layer.cornerRadius = 20
        countField.delegate = self
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
}

extension JokesFinderController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID)!
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = jokes[indexPath.row].joke
        return cell
    }
}
