//
//  Singleton.swift
//  MyDiary
//
//  Created by 전도균 on 2022/10/07.
//

import Foundation
import UIKit

class Singleton {
    static let shared = Singleton()
    
    var title: [String]
    var image = UIImageView()
    var description: [String]
    var writeDate: [String]
    
    private init() {
        image = UIImageView(image: UIImage(named: "title"))
        title = ["A", "B", "C"]
        description = ["""
abc
""",
"""
def
""",
"""
ghi
"""]
        writeDate = [Date().dateToString(), Date().dateToString(), Date().dateToString()]
    }
    
}

