// DateFormatter+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Date formatter.
extension DateFormatter {
    // MARK: - Private Constants.

    private enum Constants {
        static let dateFormatString = "MM.dd.yyyy HH:mm"
    }

    // MARK: - Public methods.

    class func convertDate(dateValue: Int) -> String {
        let truncatedTime = TimeInterval(dateValue)
        let date = Date(timeIntervalSince1970: truncatedTime)
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormatString
        return formatter.string(from: date)
    }
}
