import UIKit

class PostsTVC: UITableViewController {
    
    var user: User?
    var posts: [Post] = []

    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }

    
    @IBAction func addPostAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "createNewPost", sender: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }

    

   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let posts = posts[indexPath.row]
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PostDetailVC") as! PostDetailVC
        vc.post = posts
        navigationController?.pushViewController(vc, animated: true)
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let postId = posts[indexPath.row].id
            NetworkService.deletePost(postID: postId) { result, error in
                self.posts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewPostVC {
            vc.user = user
        }
    }
    

    private func fetchPosts() {
        let userId = user?.id.description ?? ""
        let urlPath = "\(ApiConstants.postsPath)?userId=\(userId)"
        guard let url = URL(string: urlPath) else { return  }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self,
                  let data = data else { return  }
            do {
                posts = try JSONDecoder().decode([Post].self, from: data)
                print(posts)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}
