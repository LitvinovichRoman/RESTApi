import UIKit

final class PhotosCVC: UICollectionViewController {

    var albom: Albom?
    var photos: [Photo]?
    var user: User?

    @IBOutlet var collectionViewCell: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "PhotoCVCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        fetchPhotos()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos?[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCVCell
        cell.thumbnailUrl = photo?.thumbnailUrl

        addContextMenu(to: cell) // Добавление выпадающего списка к ячейке

        return cell
    }

    private func fetchPhotos() {
        guard albom != nil else { return  }
        NetworkService.getPhotos(albomID: user?.id ?? 0) { [weak self] photos, error in
            if let error = error {
                print(error)
            } else if let photos = photos {
                self?.photos = photos
                self?.collectionView.reloadData()
            }
        }
    }

    func deleteThumbnail(at indexPath: IndexPath) {
        guard let photo = photos?[indexPath.row] else {
            return
        }

        NetworkService.deletePhoto(photoID: photo.id) { [weak self] result, error in
            if let error = error {
                print(error)
            } else {
                self?.photos?.remove(at: indexPath.row)
                self?.collectionView.deleteItems(at: [indexPath])
            }
        }
    }

    func addContextMenu(to cell: UICollectionViewCell) {
        let interaction = UIContextMenuInteraction(delegate: self)
        cell.addInteraction(interaction)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let photo = photos?[indexPath.row]
            let vc = PhotoVC()
            vc.photo = photo
            self.present(vc, animated: true)
        }

}

