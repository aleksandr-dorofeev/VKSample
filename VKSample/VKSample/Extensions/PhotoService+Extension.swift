// PhotoService+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Reload collection and table.
extension ImageService {
    /// Reload UITableViewController.
    class TableViewController: DataReloadable {
        // MARK: - Private properties.

        private let table: UITableViewController

        // MARK: - Initializers.

        init(table: UITableViewController) {
            self.table = table
        }

        // MARK: - Public methods.

        func reloadRow() {
            table.tableView.reloadData()
        }
    }

    /// Reload UICollectionViewController.
    class CollectionViewController: DataReloadable {
        // MARK: - Private properties.

        private let collection: UICollectionViewController

        // MARK: - Initializers.

        init(collection: UICollectionViewController) {
            self.collection = collection
        }

        // MARK: - Public methods.

        func reloadRow() {
            collection.collectionView.reloadData()
        }
    }
}
