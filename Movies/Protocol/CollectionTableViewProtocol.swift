//
//  CollectionTableViewProtocol.swift
//  Movies
//
//  Created by Сергей Анпилогов on 14.11.2022.
//
import Foundation

protocol CollectionTableViewCellDelegate: AnyObject {
    func collectionTableViewDidTapCell(_ cell: CollectionTableViewCell, viewModel: DetailViewModel)
}
