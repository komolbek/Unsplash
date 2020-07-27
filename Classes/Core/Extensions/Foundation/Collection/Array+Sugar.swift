//
//  Created by Komolbek Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

extension Array {
    
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
    
  subscript (safe range: ClosedRange<Int>) -> [Element] {
    return Array<Int>(range).compactMap { index -> Element? in
      return indices.contains(index) ? self[index] : nil
    }
  }
}
