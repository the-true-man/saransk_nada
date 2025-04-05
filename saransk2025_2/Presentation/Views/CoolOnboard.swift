import SwiftUI

struct CoolOnboard: View {
    @StateObject var model = OnboardViewModel()
    
    var body: some View {
        if let currentItem = model.currentItem {
            Image(currentItem.image)
                .resizable()
                .scaledToFit()
            Text(currentItem.title)
            Text(currentItem.description)
            
            Button {
                model.nextOnboard()
            } label: {
                Text(currentItem.textButton)
            }
        }
    }
}

#Preview {
    CoolOnboard()
}

final class OnboardViewModel: ObservableObject {
    @Published private(set) var currentItem: OnboardItem?
    private var onboards: [OnboardItem] = []
    
    init() {
        setupInitialQueue()
    }
    
    private func setupInitialQueue() {
        if let savedOnboards = UserDefaults.standard.data(forKey: "onboards") {
            if let decodedOnboards = try? JSONDecoder().decode([OnboardItem].self, from: savedOnboards) {
                onboards = decodedOnboards
            }
        }
        
        if onboards.isEmpty {
            onboards = [
                OnboardItem(title: "Confidence in your words",
                            description: "With conversation-based learning, you'll be talking from lesson one",
                            textButton: "Next",
                            image: "onb1"),
                OnboardItem(title: "Take your time to learn",
                            description: "Develop a habit of learning and make it a part of your daily routine",
                            textButton: "More",
                            image: "onb2"),
                OnboardItem(title: "The lessons you need to learn",
                            description: "Using a variety of learning styles to learn and retain",
                            textButton: "Choose a language",
                            image: "onb3")
            ]
            
            if let encodedOnboards = try? JSONEncoder().encode(onboards) {
                UserDefaults.standard.set(encodedOnboards, forKey: "onboards")
            }
        }
        
        if let savedCurrentItemData = UserDefaults.standard.data(forKey: "currentOnboard"),
           let decodedCurrentItem = try? JSONDecoder().decode(OnboardItem.self, from: savedCurrentItemData) {
            currentItem = decodedCurrentItem
        } else {
            currentItem = onboards.first
        }
    }
    
    func nextOnboard() {
        guard let index = onboards.firstIndex(where: { $0.image == currentItem?.image }) else { return }
        
        if index < onboards.count - 1 {
            currentItem = onboards[index + 1]
            if let encodedCurrentItem = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedCurrentItem, forKey: "currentOnboard")
            }
        } else {
            complete()
        }
    }
    
    private func complete() {
        currentItem = nil
        UserDefaults.standard.removeObject(forKey: "currentOnboard")
    }
}

struct OnboardItem: Codable {
    let title: String
    let description: String
    let textButton: String
    let image: String
}
