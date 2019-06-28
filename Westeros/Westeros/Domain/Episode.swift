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
    let launchingDate: Date //mandatory
    let endDate: Date
    let episodeNumber: Int // número de episodio dentro de la temporada
    let director: String
    weak var season: Season? //
   
    
    init(episodeNumber: Int, title: String, season: Season,  director: String,launchingDate: Date, endDate: Date) {
        self.episodeNumber = episodeNumber
        self.title = title
        self.season = season
        self.director = director
        self.launchingDate = launchingDate
        self.endDate = endDate
    }
}

extension Chapter {
    var proxyForEquality: String {
        return "\(title) \(episodeNumber) \(season!.seasonNumber)"
    }
    
    var proxyForComparison: String {
        return title
    }
}

extension Chapter: Equatable {
    static func == (lhs: Chapter, rhs: Chapter) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Chapter: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(episodeNumber)
        hasher.combine(title)
        hasher.combine(season.seasonNumber)
    }
}

extension Chapter: Comparable {
    static func < (lhs: Chapter, rhs: Chapter) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
