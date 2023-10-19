import UIKit

class AlbumsTVC: UITableViewController {
    
    var user: User?
    var alboms: [Albom]?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAlboms()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alboms?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let albom = alboms?[indexPath.row]
        cell.textLabel?.text = albom?.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albom = alboms?[indexPath.row]
        performSegue(withIdentifier: "showPhotos", sender: albom)
    }

    private func fetchAlboms() {
        guard let user = user else { return  }
        AlbomNetworkService.getAlboms(userID: user.id) { [weak self] alboms, error in
            if let error = error {
                print(error)
            } else if let alboms = alboms {
                self?.alboms = alboms
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos",
           let vc = segue.destination as? PhotosCVC,
           let albom = sender as? Albom {
            vc.album = albom
        }
    }
}

 
    
