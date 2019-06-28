//
//  Season.swift
//  Westeros
//
//  Created by Monica Sanmartin on 24/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

typealias Episodes = Set<Chapter>

final class Season {
    let totalEpisodes: Int //mandatory
    let releaseDate: Date //mandatory
    let seasonNumber: Int
    let summary: String
    var name : String { //mandatory - calculated
        return "Season \(seasonNumber)"
    }
   
    private var _episodes: Episodes
    
    init(seasonNumber: Int, totalEpisodes: Int, releaseDate: Date, summary: String) {
        self.seasonNumber = seasonNumber
        self.totalEpisodes = totalEpisodes
        self.releaseDate = releaseDate
        self.summary = summary
        _episodes = Episodes()
    }
}

extension Season {
    var count: Int {
        return _episodes.count
    }
    
    var sortedEpisodes: [Chapter] {
        return _episodes.sorted()
        
    }

    
    func add(episode: Chapter) {
        if self == episode.season {
            _episodes.insert(episode)
        }
    }
    
}

extension Season {
    var proxyForEquality: String {
        return "\(name) \(releaseDate)"
    }
    
    var proxyForComparison: Date {
        return releaseDate
    }
    
    
}


extension Season: Equatable {
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}


extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        // alguna lógica para definir cuándo el lhs < rhs
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
