//  Created by Kamolbek on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
import UIKit

final class FeedViewModel {
    
    let feedSectionModels: [FeedSectionModel]?
    let isLoading: Bool

    init(state: FeedState) {
        self.isLoading = state.isLoading
        
        self.feedSectionModels = SectionType.allCases.compactMap({ type -> FeedSectionModel? in
            
            let cellModels: [FeedCellModel]?

            switch type {
            case .new:
                cellModels = state.feedImages.compactMap({ image -> FeedNewCellModel? in

                    let firstName: String = image.user?.firstName ?? ""
                    let createdDate = String(describing:image.createdAt?.stringToDate()?.timeSinceDate(fromDate: Date.currentDate()) ?? "")
                    let imageURL: URL? = URL(string: image.urls?.regular ?? "")
                    let width: CGFloat = CGFloat(image.width ?? 0)
                    let height: CGFloat = CGFloat(image.height ?? 0)
                    let likes: String = String(describing: image.likes ?? 0)
                    
                    return FeedNewCellModel(userName: firstName,
                                            date: createdDate,
                                            imageURL: imageURL,
                                            width: width,
                                            height: height,
                                            likes: likes)
                })

            case .explore:
                cellModels = state.feedCategories?.compactMap({ (collection) -> FeedExploreCellModel? in
                    
                    let title: String = collection.title ?? ""
                    let imageURL: URL? = URL(string: collection.coverPhoto?.urls?.regular ?? "")

                    return FeedExploreCellModel(title: title,
                                                imageURL: imageURL)
                })
            }

            return FeedSectionModel(title: type.title, cellModels: cellModels)
        })
    }
}

// MARK: -  Equatable

extension FeedViewModel: Equatable {
    
    static func == (lhs: FeedViewModel, rhs: FeedViewModel) -> Bool {
        return lhs.feedSectionModels == rhs.feedSectionModels
    }
}
