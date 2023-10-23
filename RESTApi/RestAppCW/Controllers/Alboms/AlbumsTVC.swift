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
           return alboms?.count ?? 0
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           let album = alboms?[indexPath.row]
           cell.textLabel?.text = album?.title
           return cell
       }
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let album = alboms?[indexPath.row]
           performSegue(withIdentifier: "showPhotos", sender: album)
       }

       private func fetchAlboms() {
           guard let user = user else { return  }
           NetworkService.getAlboms(userID: user.id) { [weak self] alboms, error in
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
              let album = sender as? Albom {
               vc.albom = album
           }
       }
   }
