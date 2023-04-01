//
//  CollectionTableViewProtocol.swift
//  Movies
//
//  Created by Сергей Анпилогов on 14.11.2022.
//
import Foundation

protocol CollectionTableViewCellDetailDelegate: AnyObject {
    func collectionTableViewCellDidSelectItem(_ cell: CollectionTableViewCell, viewModel: DetailViewModel)
}
