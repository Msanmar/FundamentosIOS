//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Monica Sanmartin on 24/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Westeros


class ChapterTests: XCTestCase {
    
    var epi1S1: Chapter!
    var epi2S1: Chapter!
    var epi3S1: Chapter!
    var epi1S2: Chapter!
    var epi2S2: Chapter!
    var epi3S2: Chapter!
    var epi10S1: Chapter!
    var season1: Season!
    var season2: Season!
    var season3: Season!
   

    override func setUp() {
        
        // Creamos las tres primeras temporadas
        season1 = Season(seasonNumber: 1,totalEpisodes: 10,releaseDate: formatDateAsString(dateAsString: "17-04-2011")!, summary: "")
        season2 = Season(seasonNumber: 2, totalEpisodes: 10, releaseDate:  formatDateAsString(dateAsString: "01-04-2012")!, summary: "")
        season3 = Season(seasonNumber: 2, totalEpisodes: 10, releaseDate:  formatDateAsString(dateAsString: "31-03-2013")!, summary: "")
        
        // Creamos los tres primeros episodios de la temporada 1 + episodio 10
        epi1S1 = Chapter(title: "Winter is coming", launchingDate: formatDateAsString(dateAsString: "17-04-2011")!, episodeNumber: 1, season: season1, director: "Tim Van Patten", summary: "")
        epi2S1 = Chapter(title: "The Kingsroad", launchingDate: formatDateAsString(dateAsString: "24-04-2011")!, episodeNumber: 2, season: season1, director: "Tim Van Patten", summary: "")
        epi3S1 = Chapter(title: "Lord Snow", launchingDate: formatDateAsString(dateAsString: "01-05-2011")!, episodeNumber: 3, season: season1, director: "Brian Kirk", summary: "")
        epi10S1 = Chapter(title: "Fire and Blood", launchingDate: formatDateAsString(dateAsString: "19-06-2011")!, episodeNumber: 10, season: season1, director: "Alan Taylor", summary: "")
       
        // Creamos los tres primeros episodios de la temporada 2
        epi1S2 = Chapter(title: "The north remembers", launchingDate: formatDateAsString(dateAsString: "01-04-2012")!, episodeNumber: 1, season: season2, director: "Alan Taylor", summary: "")
        epi2S2 = Chapter(title: "The night lands", launchingDate: formatDateAsString(dateAsString: "08-04-2012")!, episodeNumber: 2, season: season2, director: "Alan Taylor", summary: "")
        epi3S2 = Chapter(title: "What Is Dead May Never Die", launchingDate: formatDateAsString(dateAsString: "15/04/2012")!, episodeNumber: 3, season: season2, director: "Alik Shakharov", summary: "")
        
        
    }
    
    func formatDateAsString(dateAsString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return (dateFormatter.date(from: dateAsString))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   func testChapterExistence() {
        XCTAssertNotNil(epi1S1)
    }
    
    func testLaunchingDateExistence() {
        XCTAssertNotNil(epi3S1.launchingDate)
    }

    func testNumberOfEpisode() {
        XCTAssertLessThan(epi1S1.episodeNumber, 11)
        XCTAssertLessThan(epi10S1.episodeNumber, 11)
    }
    
    
    func testChapterConformsToHashable() {
        XCTAssertNotNil(epi1S1.hashValue)
    }
    
    func testChapterEquality() {
        // 1. Identidad
        XCTAssertEqual(epi2S2, epi2S2)
        
        // 2. Igualdad
       let epi = Chapter(title: "The night lands", launchingDate: formatDateAsString(dateAsString: "08-04-2012")!, episodeNumber: 2, season: season2, director: "Alan Taylor", summary: "")
        XCTAssertEqual(epi2S2, epi)
        
        // 3. Desigualdad
        XCTAssertNotEqual(epi3S2, epi3S1)
    }
    
    func testChapterComparison() { // Compara episodios según fecha lanzamiento
        XCTAssertLessThan(epi1S1, epi2S1)
        XCTAssertGreaterThan(epi3S2, epi3S1)
    }
 
 

}
