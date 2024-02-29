//
//  NotesListViewController.swift
//  NotesApp
//
//  Created by Анастасия on 27.02.2024.
//

import UIKit

class NotesListViewController: UITableViewController {
    
// MARK: - Properties
    var viewModel: NotesListViewModelProtocol?
// MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewCell()
        title = "Notes"
        setupToolBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    // MARK: - Private methods
    private func setupTableViewCell() {
        tableView.separatorStyle = .none
        tableView.register(SimpleNoteTableViewCell.self, forCellReuseIdentifier: "SimpleNoteTableViewCell")
        tableView.register(ImageNoteTableViewCell.self, forCellReuseIdentifier: "ImageNoteTableViewCell")
    }
    private func setupToolBar() {
        let addButton = UIBarButtonItem(title: "Add note", style: .done, target: self, action: #selector(addAction))
        let spacing = UIBarButtonItem(systemItem: .flexibleSpace)
        setToolbarItems([spacing,addButton], animated: true)
        navigationController?.isToolbarHidden = false
    }
    @objc
    private func addAction() {
        let noteViewController = NoteViewController()
        navigationController?.pushViewController(noteViewController, animated: true)
    }
}
    // MARK: - UITableViewDataSource
extension NotesListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.section.count ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.section[section].items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let note = viewModel?.section[indexPath.section].items[indexPath.row] as? Note else { return UITableViewCell() }
        if indexPath.row == 0,
        let cell = tableView.dequeueReusableCell(withIdentifier:"SimpleNoteTableViewCell", for: indexPath) as? SimpleNoteTableViewCell {
            cell.set(note: note)
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "ImageNoteTableViewCell", for: indexPath) as? ImageNoteTableViewCell {
            cell.set(note: note)
            return cell
        }
        return UITableViewCell()
    }
}
// MARK: - UITableViewDelegate
extension NotesListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteViewController = NoteViewController()
        navigationController?.pushViewController(noteViewController, animated: true)
        guard let note = viewModel?.section[indexPath.section].items[indexPath.row] as? Note else { return }
                noteViewController.set(note: note)
    }
}
