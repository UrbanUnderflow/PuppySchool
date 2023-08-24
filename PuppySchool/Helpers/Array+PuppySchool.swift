//
//  Array+PuppySchool.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/23/23.
//

import Foundation

extension Array where Element: Hashable {
    func removeDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
}
