
import Foundation

protocol CollectionTableViewCellDetailDelegate: AnyObject {
    func collectionTableViewCellDidSelectItem(_ cell: CollectionTableViewCell, viewModel: DetailViewModel)
}
