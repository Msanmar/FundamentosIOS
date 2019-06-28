//
//  Chapter.swift
//  Westeros
//
//  Created by Monica Sanmartin on 24/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation


final class Chapter {
    let title: String //mandatory
    let launchingDate: Date//mandatory
    let episodeNumber: Int  //número de episodio dentro de una temporada
    weak var season: Season?
    let director: String
    let summary: String
    
    init(title: String, launchingDate: Date, episodeNumber: Int, season: Season, director: String, summary: String) {
        self.title = title
        self.launchingDate = launchingDate
        self.episodeNumber = episodeNumber
        self.season = season
        self.director = director
        self.summary = summary
        
    }
}


extension Chapter {
    var proxyForEquality: String {
        return "\(title) \(launchingDate)"
    }
    
    var proxyForComparison: Date {
        return launchingDate
    }
}

extension Chapter: Equatable {
    static func == (lhs: Chapter, rhs: Chapter) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Chapter: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(launchingDate)
    }
}

extension Chapter: Comparable {
    static func < (lhs: Chapter, rhs: Chapter) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

