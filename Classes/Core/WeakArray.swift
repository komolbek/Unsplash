//
//  Created by Dmitry Frishbuter on 19/03/2019
//  Copyright © 2019 Ronas IT. All rights reserved.
//

import Foundation

final class WeakWrapper<Value: AnyObject> {
    weak var value: Value?

    init(_ value: Value) {
        self.value = value
    }
}

struct WeakArray<Element: AnyObject> {
    private var items: [WeakWrapper<Element>] = []

    init() {}

    init(_ elements: [Element]) {
        items = elements.map { WeakWrapper($0) }
    }
}

extension WeakArray: Collection {

    var startIndex: Int {
        return items.startIndex
    }

    var endIndex: Int {
        return items.endIndex
    }

    subscript(_ index: Int) -> Element? {
        return items[index].value
    }

    func index(after idx: Int) -> Int {
        return items.index(after: idx)
    }
}

extension WeakArray {

    func strongified() -> [Element] {
        return items.compactMap { $0.value }
    }
}

extension Array where Element: AnyObject {

    func weakified() -> WeakArray<Element> {
        return WeakArray(self)
    }
}
