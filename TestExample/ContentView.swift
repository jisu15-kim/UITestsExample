//
//  ContentView.swift
//  TestExample
//
//  Created by Jisu Kim on 7/22/24.
//

import SwiftUI

struct ContentView: View {
    @State var isPresentSheet = false
    @State var userName = String()
    
    var greetingMessage: String {
        if userName.isEmpty {
            return "안녕하세요! 이름을 입력해주세요😀"
        }
        return "\(userName)님, 안녕하세요"
    }
    
    var actionButtonTitle: String {
        if userName.isEmpty {
            return "✏️ 입력하러 가기"
        }
        return "✍️ 수정하러 가기"
    }
    
    var body: some View {
        VStack {
            Text(greetingMessage)
                .accessibilityIdentifier("greetingText")
            
            Button(actionButtonTitle) {
                isPresentSheet = true
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .accessibilityIdentifier("actionButton")
        }
        .padding()
        .sheet(isPresented: $isPresentSheet) {
            BottomSheetView() { name in
                self.userName = name
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ContentView()
}

struct BottomSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var inputString = String()
    var handler: (String) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🚀")
            TextField(
                "이름을 입력하세요",
                text: $inputString
            )
            .multilineTextAlignment(.center)
            .accessibilityIdentifier("userNameTextField")
            
            Button("완료") {
                handler(inputString)
                dismiss()
            }
            .buttonStyle(BorderedButtonStyle())
            .disabled(inputString.isEmpty)
            .accessibilityIdentifier("userNameApplyButton")
        }
        .padding(.horizontal, 30)
    }
}
