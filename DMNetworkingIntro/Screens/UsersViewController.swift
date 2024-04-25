//
//  UsersViewController.swift
//  DMNetworkingIntro
//
//  Created by David Ruvinskiy on 4/10/23.
//

import UIKit

/**
 1. Create the user interface. See the provided screenshot for how the UI should look.
 2. Follow the instructions in the `User` file.
 3. Follow the instructions in the `NetworkManager` file.
 */
class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetworkManagerDelegate, NetServiceDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    var users: [User] = []
    /**
     4. Create a variable called `users` and set it to an empty array of `User` objects.
     */
    
    /**
     5. Connect the UITableView to the code. Create a function called `configureTableView` that configures the table view. You may find the `Constants` file helpful. Make sure to call the function in the appropriate spot.
     */
    
    // UITableViewDataSource
    
    func configureTableView()  {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.userReuseID)
    }
    
    func usersRetrieved(userArray: [User]) {
        users = userArray
        print("Inside UsersViewController: \(users)")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad ran")
        NetworkManager.shared.delegate = self
        configureTableView()
        self.getUsers()
//        self.tableView.reloadData()
    }
    
    /**
     6.1 Set the `NetworkManager`'s delegate property to the `UsersViewController`. Have the `UsersViewController` conform to the `NetworkManagerDelegate` protocol. Call the `NetworkManager`'s `getUsers` function. In the `usersRetrieved` function, assign the `users` property to the array we got back from the API and call `reloadData` on the table view.
     */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(users.count)
        return users.count
//        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userReuseID, for: indexPath)
        var content = cell.defaultContentConfiguration()
        let user = users[indexPath.row]
        
        content.text = user.firstName
        content.secondaryText = user.email

        cell.contentConfiguration = content
        
        
        return cell
    }
    
    func getUsers() {
        NetworkManager.shared.getUsers()
    }
}

