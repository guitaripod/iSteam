import Foundation

@MainActor final class MostPlayedVM: ObservableObject {
    
    @Published var games: [Game] = []
    
    // TODO: Figure out why live site doesn't return the same HTML as in browser.
    init(
        scraperService: ScraperService = ScraperService(),
        steamChartsService: SteamChartsServiceProtocol = MockSteamChartsService()
    ) {
        self.scraperService = scraperService
        self.steamChartsService = steamChartsService
        
        Task { await fetch() }
    }
    
    func fetch() async {
        do {
            let html = try await steamChartsService.mostPlayed()
            games = try scraperService.scrapeMostPlayed(html)
        } catch let error as HTTPError {
            print(error.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Private
    
    private var scraperService: ScraperService
    private let steamChartsService: SteamChartsServiceProtocol
}
