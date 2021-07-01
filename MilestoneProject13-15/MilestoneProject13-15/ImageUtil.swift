//
//  ImageUtil.swift
//  MilestoneProject13-15
//
//  Created by Lorand Fazakas on 2021. 06. 30..
//

import Foundation

struct ImageUtil {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
