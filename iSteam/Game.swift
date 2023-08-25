import Foundation

struct Game: Codable, Identifiable {
    var id: UUID { UUID() }
    
    /// This is the rank of the game in the top 100.
    let rank: String
    /// This is the name of the game.
    let name: String
    /// This is the price of the game in USD.
    let price: String
    /// This is the URL of the game's store page.
    let url: URL
    /// This is the URL of the image of the game's cover art.
    let imgSrc: URL
}
