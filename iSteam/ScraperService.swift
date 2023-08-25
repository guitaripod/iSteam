import Foundation
import SwiftSoup

final class ScraperService {
    
    /// This function scrapes the HTML of the Steam most played page and returns an array of `Game` objects.
    /// - Parameter html: The HTML of the Steam most played page.
    /// - Returns: An array of ``Game`` objects.
    func scrapeMostPlayed(_ html: String) throws -> [Game] {
        var games: [Game] = []
        let doc: Document = try SwiftSoup.parse(html)
        let rows = try doc.select("tr.weeklytopsellers_TableRow_2-RN6")
        
        for row in rows.array() {
            let rank = try row.select("td.weeklytopsellers_RankCell_34h48").text()
            let name = try row.select("div.weeklytopsellers_GameName_1n_4-").text()
            let price = try row.select("td.weeklytopsellers_PriceCell_3IyfU").text()
            let url = try row.select("a.weeklytopsellers_TopChartItem_2C5PJ").attr("href")
            let imgSrc = try row.select("img.weeklytopsellers_CapsuleArt_2dODJ").attr("src")
            
            guard
                let gameURL = URL(string: url),
                let imageURL = URL(string: imgSrc)
            else {
                continue
            }
            
            let game = Game(
                rank: rank,
                name: name,
                price: price,
                url: gameURL,
                imgSrc: imageURL
            )
            
            games.append(game)
        }
        
        return games
    }
}
