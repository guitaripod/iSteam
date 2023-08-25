import SwiftUI

struct ContentView: View {
    
    @StateObject var model = MostPlayedVM()
    
    var body: some View {
        List(model.games) { game in
            ZStack(alignment: .leading) {
                AsyncImage(url: game.imgSrc) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                
                Color.black.opacity(0.5)
                
                VStack(alignment: .leading) {
                    Text(game.rank)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(game.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(game.price)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ContentView()
}
