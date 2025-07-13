import Foundation

enum HTTPError: Error {
    case statusCode(Int)
    case badResponse
    case badData
    case decoding
    case badURL
    
    var localizedDescription: String {
        switch self {
        case .statusCode(let code):
            return "HTTP Error: \(code)"
        case .badResponse:
            return "Bad HTTP Response"
        case .badData:
            return "Bad Data"
        case .decoding:
            return "Decoding Error"
        case .badURL:
            return "Bad URL"
        }
    }
}
