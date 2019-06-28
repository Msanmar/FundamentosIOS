//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Alexandre Freire on 13/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
    
    // TEST HOUSES
    
    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalFactoryHasHouses() {
        let houses = Repository.local.houses
        XCTAssertNotNil(houses)
    }
    
    func testLocalFactoryHasTheCorrectHouseCount() {
        let houses = Repository.local.houses
        XCTAssertEqual(houses.count, 3)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses() {
        let houses = Repository.local.houses
        XCTAssertEqual(houses, houses.sorted())
    }
    
    func testLocalRepositoryReturnsHouseByNameCaseInsensitively() {
        let stark = Repository.local.house(named: "Stark")
        print(stark!.name)
        XCTAssertNotNil(stark)
        
      
        
        let lannister = Repository.local.house(named: "lAnniStEr")
        XCTAssertNotNil(lannister)
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryHouseFiltering() {
        let filteredHouseList = Repository.local.houses(filteredBy: { house in
            house.count == 1 // true or false
        })

        XCTAssertEqual(filteredHouseList.count, 1)
        
        let wordsFilter = { (house: House) -> Bool in
            house.words == "Se acerca el verano"
        }
        
        let list = Repository.local.houses(filteredBy: wordsFilter)
        XCTAssertEqual(list.count, 0)
    }
    
    // TEST SEASON

    func testLocalFactoryHasSeasons() {
        let seasons = Repository.local.seasons
        XCTAssertNotNil(seasons)
    }
    
    
    func testLocalFactoryHasTheCorrectSeasonsCount() {
        let seasons = Repository.local.seasons
        XCTAssertEqual(seasons.count, 7)
    }
    

    func testLocalRepositoryReturnsSortedArrayOfSeasons() {
        let seasons = Repository.local.houses
        XCTAssertEqual(seasons, seasons.sorted())
    }
    

    func testLocalRepositoryReturnsSeasonByNameCaseInsensitively() {
        let season1 = Repository.local.season(named: "Season 1")
        XCTAssertNotNil(season1)
       
        let season7 = Repository.local.season(named: "Season 7")
        XCTAssertNotNil(season7)
         print(season1!.releaseDate)
         print(season7!.releaseDate)
        
         let season2 = Repository.local.season(named: "Season 2")
        XCTAssertNotNil(season2)
        
        let patata = Repository.local.house(named: "patata")
        XCTAssertNil(patata)
        
    }
    
    
    func testLocalRepositorySeasonFiltering() {
        let filteredSeasonList = Repository.local.seasons(filteredBy: { season in
            season.count == 0 // true or false
           
        })
        
        XCTAssertEqual(filteredSeasonList.count, 0)
        
       let wordsFilter = { (season: Season) -> Bool in
            season.totalEpisodes == 10
        }
        
        let list = Repository.local.seasons(filteredBy: wordsFilter)
        XCTAssertEqual(list.count, 7)
    }
    
}
