import XCTest

@testable import iSteam

final class ScraperService_Test: XCTestCase {
    
    func testScrapeMostPlayed() throws {
        guard let url = Bundle.main.url(forResource: "most-played", withExtension: "html") else {
            XCTFail("Failed to load HTML file")
            return
        }
        
        let html = try String(contentsOf: url, encoding: .utf8)
        
        let games = try ScraperService().scrapeMostPlayed(html)
        
        XCTAssertEqual(games.count, 6)
        
        let game = games.first!
        
        XCTAssertEqual(game.rank, "1")
        XCTAssertEqual(game.name, "Counter-Strike: Global Offensive")
        XCTAssertEqual(game.price, "Free To Play")
        XCTAssertEqual(game.url.absoluteString, "https://store.steampowered.com/app/730/CounterStrike_Global_Offensive?snr=1_7001_7005__7003")
        XCTAssertEqual(game.imgSrc.absoluteString, "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg?t=1683566799")
    }
}
