//
//  Created by Komolbek Ibragimov on 15/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

extension String {
    
    static var defaultDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return formatter
    }()
    
    func stringToDate() -> Date? {
        let formatter = type(of: self).defaultDateFormatter
        let datetime = formatter.date(from: self)
        
        return datetime
    }
}
