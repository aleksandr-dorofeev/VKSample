// PhotoService+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Reload collection and table.
extension PhotoService {
    /// Reload UITableViewController.
    class TableViewController: DataReloadable {
        // MARK: - Public properties.

        let table: UITableViewController

        // MARK: - Initializers.

        init(table: UITableViewController) {
            self.table = table
        }

        // MARK: - Public methods.

        func reloadRow(atIndexPath indexPath: IndexPath) {
            table.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }

    /// Reload UICollectionViewController.
    class CollectionViewController: DataReloadable {
        // MARK: - Public properties.

        let collection: UICollectionViewController

        // MARK: - Initializers.

        init(collection: UICollectionViewController) {
            self.collection = collection
        }

        // MARK: - Public methods.

        func reloadRow(atIndexPath indexPath: IndexPath) {
            collection.collectionView.reloadItems(at: [indexPath])
        }
    }
}
