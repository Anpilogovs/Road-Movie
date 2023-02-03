//
//  SearchResultProtocol.swift
//  Movies
//
//  Created by Сергей Анпилогов on 14.11.2022.
//

import Foundation

protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResuldidTapToCell(viewModel: DetailViewModel)
}
