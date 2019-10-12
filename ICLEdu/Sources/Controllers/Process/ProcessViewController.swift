//
//  MenuViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/20.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit

let noteCell = "NoteCell"
let processCell = "ProcessCell"

class ProcessViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tổng quan"
        tableView.register(UINib(nibName: processCell, bundle: nil), forCellReuseIdentifier: processCell)
        tableView.register(UINib(nibName: noteCell, bundle: nil), forCellReuseIdentifier: noteCell)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: processCell) as! ProcessCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: noteCell) as! NoteCell
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return tableView.bounds.width
        }
        return 100
    }
}
