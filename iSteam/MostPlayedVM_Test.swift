import XCTest

@testable import iSteam

@MainActor final class MostPlayedVM_Test: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        scraperService = ScraperService()
        steamChartsService = MockSteamChartsService()
        
        sut = MostPlayedVM(
            scraperService: scraperService,
            steamChartsService: steamChartsService
        )
    }
    
    override func tearDown() {
        scraperService = nil
        steamChartsService = nil
        sut = nil
        super.tearDown()
    }
    
    func testMockFetch() async throws {
        XCTAssertEqual(sut.games.count, 0)
        
        await sut.fetch()
        
        XCTAssertEqual(sut.games.count, 6)
        
        guard let game = sut.games.first else {
            XCTFail("No games found")
            return
        }
        
        XCTAssertEqual(game.rank, "1")
        XCTAssertEqual(game.name, "Counter-Strike: Global Offensive")
        XCTAssertEqual(game.price, "Free To Play")
        XCTAssertEqual(game.url.absoluteString, "https://store.steampowered.com/app/730/CounterStrike_Global_Offensive?snr=1_7001_7005__7003")
        XCTAssertEqual(game.imgSrc.absoluteString, "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg?t=1683566799")
    }
    
    func testRealFetch() async throws {
        scraperService = ScraperService()
        steamChartsService = SteamChartsService()
        
        sut = MostPlayedVM(
            scraperService: scraperService,
            steamChartsService: steamChartsService
        )
        
        XCTAssertEqual(sut.games.count, 0)
        
        await sut.fetch()
        
        XCTAssertEqual(sut.games.count, 6)
        
        guard let game = sut.games.first else {
            XCTFail("No games found")
            return
        }
        
        XCTAssertEqual(game.rank, "1")
        XCTAssertEqual(game.name, "Counter-Strike: Global Offensive")
        XCTAssertEqual(game.price, "Free To Play")
        XCTAssertEqual(game.url.absoluteString, "https://store.steampowered.com/app/730/CounterStrike_Global_Offensive?snr=1_7001_7005__7003")
        XCTAssertEqual(game.imgSrc.absoluteString, "https://cdn.cloudflare.steamstatic.com/steam/apps/730/capsule_231x87.jpg?t=1683566799")
    }
    
    // MARK: Private
    
    private var sut: MostPlayedVM!
    private var scraperService: ScraperService!
    private var steamChartsService: SteamChartsServiceProtocol!
}
