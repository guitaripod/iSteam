import Foundation

protocol SteamChartsServiceProtocol {
    func mostPlayed() async throws -> String
}

/// This service is responsible for fetching the HTML of the Steam Charts page.
final class SteamChartsService: SteamChartsServiceProtocol {
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// This function fetches the HTML from the Steam Most Played page.
    /// - Throws: An instance of `HTTPError`.
    /// - Returns: The HTML of the Steam Charts page.
    func mostPlayed() async throws -> String {
        guard let url = URL(string: "https://store.steampowered.com/charts/mostplayed") else {
            throw HTTPError.badURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPError.badResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw HTTPError.statusCode(httpResponse.statusCode)
        }
        
        let html = String(decoding: data, as: UTF8.self)
        
        return html
    }
    
    // MARK: Private
    
    private let session: URLSession
}

final class MockSteamChartsService: SteamChartsServiceProtocol {
    func mostPlayed() async throws -> String {
        guard let url = Bundle.main.url(forResource: "most-played", withExtension: "html") else {
            throw HTTPError.badURL
        }
        let html = try String(contentsOf: url)
        return html
    }
}
