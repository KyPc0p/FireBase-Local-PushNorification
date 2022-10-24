//
//  TableViewController.swift
//  Notification - LifeCycle
//
//  Created by Артём Харченко on 24.10.2022.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    let notifications = ["Local Notification",
                         "Local Notification with Action",
                         "Local Notification with Content",
                         "Push Notification with  APNs",
                         "Push Notification with Firebase",
                         "Push Notification with Content"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notifications"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = notifications[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    // MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        let notificationType = notifications[indexPath.row]
        
        let alert = UIAlertController(
            title: notificationType,
            message: "After 5 seconds " + notificationType + " will appear",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.appDelegate?.sentNotification(with: notificationType)
        }))
        present(alert, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
