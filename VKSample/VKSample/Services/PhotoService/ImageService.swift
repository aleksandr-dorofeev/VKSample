// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Service for download and cache images.
final class ImageService {
    // MARK: - Private Constants.

    private enum Constants {
        static let separatorCharacter: Character = "/"
        static let defaultNameString: Substring = "default"
        static let imagesDirectoryString = "images"
        static let defaultPlaceholderName = "userPlaceholder"
    }

    // MARK: - Public properties.

    var placeholderImage: UIImage? = UIImage(named: Constants.defaultPlaceholderName)

    // MARK: - Private properties.

    private let container: DataReloadable
    private var imagesMap: [String: UIImage] = [:]
    private lazy var fileManager = FileManager.default

    // MARK: - Initializers.

    init(container: UITableViewController) {
        self.container = TableViewController(table: container)
    }

    init(container: UICollectionViewController) {
        self.container = CollectionViewController(collection: container)
    }

    // MARK: - Public methods.

    func getPhoto(url: String) -> UIImage? {
        if let image = imagesMap[url] {
            return image
        } else if let image = getImageFromDisk(url: url) {
            return image
        } else {
            loadImage(url: url)
            return placeholderImage
        }
    }

    // MARK: - Private methods.

    private func getImageFromDisk(url: String) -> UIImage? {
        guard
            let filePath = getImagePath(url: url),
            let image = UIImage(contentsOfFile: filePath)
        else {
            return nil
        }
        imagesMap[url] = image
        return image
    }

    private func loadImage(url: String) {
        AF.request(url).responseData { [weak self] response in
            guard
                let self = self,
                let data = response.data,
                let image = UIImage(data: data)
            else { return }
            self.imagesMap[url] = image
            self.saveImageToDisk(url: url, image: image)
            self.container.reloadRow()
        }
    }

    private func getImagePath(url: String) -> String? {
        guard let folderUrl = cacheFolderPath() else { return nil }
        let fileName = url.split(separator: Constants.separatorCharacter).last ?? Constants.defaultNameString
        return folderUrl.appendingPathComponent(String(fileName)).path
    }

    private func cacheFolderPath() -> URL? {
        guard let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        let url = docDirectory.appendingPathComponent(Constants.imagesDirectoryString, isDirectory: true)
        if !fileManager.fileExists(atPath: url.path) {
            do {
                try fileManager.createDirectory(
                    at: url,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            } catch {
                print(error.localizedDescription)
            }
        }
        return url
    }

    private func saveImageToDisk(url: String, image: UIImage) {
        guard
            let filePath = getImagePath(url: url),
            let data = image.jpegData(compressionQuality: 200)
        else { return }
        fileManager.createFile(atPath: filePath, contents: data)
    }
}
