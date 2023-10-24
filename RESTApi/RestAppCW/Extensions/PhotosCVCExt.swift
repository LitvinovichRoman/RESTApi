import UIKit

extension PhotosCVC: UIContextMenuInteractionDelegate {

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        guard let indexPath = collectionView.indexPathForItem(at: location) else {
            return nil
        }
        
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let deleteAction = UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: [.destructive]) { [weak self] _ in
                self?.deleteThumbnail(at: indexPath)
            }

            return UIMenu(title: "", children: [deleteAction])
        }

        return configuration
    }
}
