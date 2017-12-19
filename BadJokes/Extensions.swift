//
//  Extensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 08. 28..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import Foundation

extension String {
    func cutLastCharacter() -> Int {
        // Cut down the last letter, e.x. 10x -> 10 and returns as an Int
        let splitIndex = index(before: endIndex)
        guard let number = Int(self.prefix(upTo: splitIndex)) else {
            return Int()
        }
        
        return number
    }
    
    func formatLineBreaks() -> String {
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }
}

extension UserDefaults {
    func printAllUserDefaulsKeysAndValues() {
        // For debug purpose
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
        print("=========================================================")
    }
}

extension Array {
    func randomIndex() -> Int? {
        if self.isEmpty {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return index
    }
}

extension Array {
    func randomItem() -> Element? {
        if self.isEmpty {
            return nil
        }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension TimeInterval {
    func randomSec() -> UInt32 {
        let index = UInt32(arc4random_uniform(UInt32(self)))
        return index
    }
}
