import SwiftUI

struct ActionButton: View {
    let title: String
    let action: @MainActor () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(.white)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.blue)
                }
        }
    }
}

#Preview {
    ActionButton(title: "Title") {
        print("tap")
    }
}
