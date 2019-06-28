//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Monica Sanmartin on 24/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {
    
    var epi1S1: Chapter!
    var epi2S1: Chapter!
    var epi3S1: Chapter!
    var epi1S2: Chapter!
    var epi2S2: Chapter!
    var epi3S2: Chapter!
    var epi4S2: Chapter!
    var epi10S1: Chapter!
    var season1: Season!
    var season2: Season!
    var season3: Season!

    override func setUp() {
        // Creamos las tres primeras temporadas
        season1 = Season(seasonNumber: 1,totalEpisodes: 10,releaseDate: formatDateAsString(dateAsString: "17-04-2011")!, summary: "")
        season2 = Season(seasonNumber: 2, totalEpisodes: 10, releaseDate:  formatDateAsString(dateAsString: "01-04-2012")!, summary: "")
        season3 = Season(seasonNumber: 3, totalEpisodes: 10, releaseDate:  formatDateAsString(dateAsString: "31-03-2013")!, summary: "")
        
        // Creamos los tres primeros episodios de la temporada 1 + episodio 10
        epi1S1 = Chapter(title: "Winter is coming", launchingDate: formatDateAsString(dateAsString: "17-04-2011")!, episodeNumber: 1, season: season1, director: "Tim Van Patten", summary: "")
        epi2S1 = Chapter(title: "The Kingsroad", launchingDate: formatDateAsString(dateAsString: "24-04-2011")!, episodeNumber: 2, season: season1, director: "Tim Van Patten", summary: "")
        epi3S1 = Chapter(title: "Lord Snow", launchingDate: formatDateAsString(dateAsString: "01-05-2011")!, episodeNumber: 3, season: season1, director: "Brian Kirk", summary: "")
        epi10S1 = Chapter(title: "Fire and Blood", launchingDate: formatDateAsString(dateAsString: "19-06-2011")!, episodeNumber: 10, season: season1, director: "Alan Taylor", summary: "")
        
        // Creamos los tres primeros episodios de la temporada 2
        epi1S2 = Chapter(title: "The north remembers", launchingDate: formatDateAsString(dateAsString: "01-04-2012")!, episodeNumber: 1, season: season2, director: "Alan Taylor", summary: "")
        epi2S2 = Chapter(title: "The night lands", launchingDate: formatDateAsString(dateAsString: "08-04-2012")!, episodeNumber: 2, season: season2, director: "Alan Taylor", summary: "")
        epi3S2 = Chapter(title: "What Is Dead May Never Die", launchingDate: formatDateAsString(dateAsString: "15/04/2012")!, episodeNumber: 3, season: season2, director: "Alik Shakharov", summary: "")
        
        //Añadimos episodios a cada temporada
        season1.add(episode: epi1S1)
        season1.add(episode: epi2S1)
        season1.add(episode: epi3S1)
        season1.add(episode: epi10S1)
        
        season2.add(episode: epi1S2)
        season2.add(episode: epi2S2)
        season2.add(episode: epi3S2)
        
        
        
    }

    override func tearDown() {

    }

    func formatDateAsString(dateAsString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return (dateFormatter.date(from: dateAsString))
    }

    func testSeasonExistence() {
        XCTAssertNotNil(season1)
     
    }
    
    func testMaxNumEpisodes() {
       XCTAssertLessThanOrEqual(season1.count, season1.totalEpisodes)
        print(season1.count)
        print(season1.totalEpisodes)
    
    }
    
   
    // Given - When - Then
    func testSeasonAddEpisodes() {
        
        XCTAssertEqual(season1.count, 4)
        
        epi4S2 = Chapter(title: "Garden of bones", launchingDate: formatDateAsString(dateAsString: "22-04-2012")!, episodeNumber: 4, season: season2, director: "David Petrarca", summary: "")
       season2.add(episode: epi4S2)
       
        XCTAssertEqual(season2.count, 4) //Lo cuenta una vez añadido
        
       season2.add(episode: epi4S2)
        XCTAssertEqual(season2.count, 4) //No lo cuenta si se añade uno repetido
        
        /*starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2) */
    }
    
    /*
    func testHouseAddPersonsAtOnce() {
        starkHouse.add(persons: robb, arya, tyrion)
        XCTAssertEqual(starkHouse.count, 2)
    } */
    
    func testSeasonEquality() {
        // Identidad
        XCTAssertEqual(season1, season1)
        
        // Igualdad
        let seasonAux = Season(seasonNumber: 2, totalEpisodes: 10, releaseDate: formatDateAsString(dateAsString: "01-04-2012")!, summary: "")
        XCTAssertEqual(season2, seasonAux)
        
        // Desigualdad
        XCTAssertNotEqual(season2, season1)
    }
    
    func testSeasonComparison() { //Compara por fecha de lanzamiento
        XCTAssertLessThan(season1, season2) // season 1 < season 2
    }
    
    func testSeasonSortedMembersReturnsASortedListOfMembers() {
        //XCTAssertEqual(season1.sortedMembers, starkHouse.sortedMembers.sorted())
        XCTAssertEqual(season1.sortedEpisodes, season1.sortedEpisodes.sorted())
        
    }
    
    
    
}

