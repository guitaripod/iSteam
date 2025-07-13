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
        
        var request = URLRequest(url: url)
        request.setValue("text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7", forHTTPHeaderField: "Accept")
        request.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        request.setValue("en-US,en;q=0.9", forHTTPHeaderField: "Accept-Language")
        request.setValue("max-age=0", forHTTPHeaderField: "Cache-Control")
        request.setValue("keep-alive", forHTTPHeaderField: "Connection")
        request.setValue("steamCountry=FI%7C5464471a18f0d85734b8d3b7fc9386db; sessionid=363ca51579db46f8ec858623; timezoneOffset=10800,0; cookieSettings=%7B%22version%22%3A1%2C%22preference_state%22%3A1%2C%22content_customization%22%3Anull%2C%22valve_analytics%22%3Anull%2C%22third_party_analytics%22%3Anull%2C%22third_party_content%22%3Anull%2C%22utm_enabled%22%3Atrue%7D", forHTTPHeaderField: "Cookie")
        request.setValue("1", forHTTPHeaderField: "Dnt")
        request.setValue("store.steampowered.com", forHTTPHeaderField: "Host")
        request.setValue("https://store.steampowered.com/", forHTTPHeaderField: "Referer")
        request.setValue("\"Not)A;Brand\";v=\"24\", \"Chromium\";v=\"116\"", forHTTPHeaderField: "Sec-Ch-Ua")
        request.setValue("?0", forHTTPHeaderField: "Sec-Ch-Ua-Mobile")
        request.setValue("\"macOS\"", forHTTPHeaderField: "Sec-Ch-Ua-Platform")
        request.setValue("document", forHTTPHeaderField: "Sec-Fetch-Dest")
        request.setValue("navigate", forHTTPHeaderField: "Sec-Fetch-Mode")
        request.setValue("same-origin", forHTTPHeaderField: "Sec-Fetch-Site")
        request.setValue("?1", forHTTPHeaderField: "Sec-Fetch-User")
        request.setValue("1", forHTTPHeaderField: "Upgrade-Insecure-Requests")
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
        
        let (data, response) = try await session.data(for: request)
        
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
