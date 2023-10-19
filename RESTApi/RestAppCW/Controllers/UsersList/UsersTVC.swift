import UIKit
import Alamofire
import AlamofireImage

class UsersTVC: UITableViewController {
    
    var user: User?
    var users: [User] = []

    
    override func viewWillAppear(_ animated: Bool) {
        fetchUsers()
    }

    @IBAction func addBtnAction(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "NewUserTVC") as! NewUserTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.username
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailUserVC") as! DetailUserVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewUserTVC {
            vc.user = user
        }
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userId = users[indexPath.row].id
            UserNetworkService.deleteUser(userId: userId) { [weak self] in
                self?.users.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    private func fetchUsers() {
        guard let usersURL = ApiConstants.usersURL else { return }
        URLSession.shared.dataTask(with: usersURL) { [weak self] data, response, error in
            
            guard let self else { return }
            if let error = error { print(error) }
            
            if let data = data {
                do {
                    self.users = try JSONDecoder().decode([User].self, from: data)
                    print(users)
                } catch { print(error) }
            }
            DispatchQueue.main.async { self.tableView.reloadData() }
        }.resume()
    }
}

