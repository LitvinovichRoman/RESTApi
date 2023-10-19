import UIKit
import MapKit

class DetailUserVC: UIViewController {

    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var userNameLbl: UILabel!
    @IBOutlet private weak var emailLbl: UILabel!
    @IBOutlet private weak var phoneLbl: UILabel!
    @IBOutlet private weak var websiteLbl: UILabel!
    @IBOutlet private weak var adressLbl: UILabel!
   
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetail(user: user)
    }
        
    
    @IBAction func openMapsButtonTapped(_ sender: UIButton) { openMapsForUserLocation() }
    
    @IBAction func editBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "EditUserVC") as! EditUserVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openPostFlow() {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostsTVC") as! PostsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toDoBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ToDo", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ToDoTVC") as! ToDoTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openAlbomFlow() {
        let storyboard = UIStoryboard(name: "AlbumsAndPhotos", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlbumsTVC") as! AlbumsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func openMapsForUserLocation() {
        if let user = user,
           let latitudeString = user.address?.geo?.lat,
           let longitudeString = user.address?.geo?.lng,
           let latitude = Double(latitudeString),
           let longitude = Double(longitudeString)
        {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let placemark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = user.name
            mapItem.openInMaps(launchOptions: nil)
        }
    }
    
    private func setDetail(user: User?) {
        if let user = user {
            nameLbl.text = user.name
            userNameLbl.text = user.username
            emailLbl.text = user.email
            phoneLbl.text = user.phone
            websiteLbl.text = user.website
            if let city = user.address?.city,
               let street = user.address?.street,
               let suite = user.address?.suite,
               let zipcode = user.address?.zipcode {
                adressLbl.text = "\(city)\n\(street)\n\(suite)\n\(zipcode)"
            } else {
                adressLbl.text = "Unknown"
            }
        }
    }

}
