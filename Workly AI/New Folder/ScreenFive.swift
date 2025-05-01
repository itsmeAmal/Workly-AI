//
//  ScreenFive.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//



import SwiftUI

struct ScreenFive: View {
    @State private var userInput: String = ""
    private let navColor = Color(red: 0.11, green: 0.17, blue: 0.29)
    private let sheetColor = Color(red: 0.95, green: 0.95, blue: 0.93)

    var body: some View {
        ZStack {
            navColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                // Navigation Bar Title
                Spacer().frame(height: 44)
                HStack(spacing: 4) {
                    Spacer()
                    Text("Workly.AI Live")
                        .font(.title2)
                        .foregroundColor(.white)
                    Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                    Spacer()
                }
                .padding(.bottom, 8)

                // Chat Container
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        // WA Bubble
                        HStack(alignment: .top) {
                            Circle()
                                .fill(navColor)
                                .frame(width: 32, height: 32)
                                .overlay(Text("WA").font(.caption).foregroundColor(.white))
                            Text("Great !")
                                .padding(8)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                        }
                        HStack(alignment: .top) {
                            Spacer()
                            Text("Yeh, I completed Masters in Software Engineering")
                                .padding(8)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                                .overlay(
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 32, height: 32)
                                        .overlay(Text("JS").font(.caption).foregroundColor(.white)), alignment: .trailing
                                )
                        }
                        HStack(alignment: .top) {
                            Circle()
                                .fill(navColor)
                                .frame(width: 32, height: 32)
                                .overlay(Text("WA").font(.caption).foregroundColor(.white))
                            Text("Are you familiar with any programming languages or tools?")
                                .padding(8)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                        }
                        HStack(alignment: .top) {
                            Spacer()
                            Text("Yes I’m familiar with Java, snowflake, SpringBoot")
                                .padding(8)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                                .overlay(
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 32, height: 32)
                                        .overlay(Text("JS").font(.caption).foregroundColor(.white)), alignment: .trailing
                                )
                        }
                        // Page indicator
                        HStack(spacing: 6) {
                            Circle().fill(Color.gray).frame(width: 8, height: 8)
                            Circle().fill(Color.gray).frame(width: 8, height: 8)
                            Circle().fill(Color.gray).frame(width: 8, height: 8)
                            Circle().fill(Color.gray.opacity(0.5)).frame(width: 8, height: 8)
                        }
                        .padding(.top, 8)
                    }
                    .padding(16)
                    .background(sheetColor)
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                }

                // Suggestions
                VStack(alignment: .leading, spacing: 12) {
                    Text("Based on our conversation, here are some job suggestions:")
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
//                    WrapView(items: [
//                        "Software Engineer at XYZ Corp",
//                        "Data Scientist at ABC Inc.",
//                        "Data Engineer at Tech Co. Ohio, Texas, USA"
//                    ])
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 16)

                // Input field
                ZStack(alignment: .trailing) {
                    TextField("", text: $userInput)
                        .frame(height: 60)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                    Button(action: {
                        // Send message
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.title2)
                            .foregroundColor(navColor)
                    }
                    .padding(.trailing, 32)
                }
                .padding(.bottom, 8)

                // Bottom Navigation Bar
                HStack {
                    ScreenFiveTabBarItem(icon: "house", text: "Home", selected: false)
                    Spacer()
                    ScreenFiveTabBarItem(icon: "bubble.left.and.bubble.right", text: "Bot Guide", selected: true)
                    Spacer()
                    ScreenFiveTabBarItem(icon: "list.bullet", text: "Interview", selected: false)
                    Spacer()
                    ScreenFiveTabBarItem(icon: "person.crop.circle", text: "Profile", selected: false)
                    Spacer()
                    ScreenFiveTabBarItem(icon: "gearshape", text: "Settings", selected: false)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 24)
                .background(Color.white)
            }
        }
    }
}

//// MARK: - WrapView for chips
//struct WrapView: View {
//    let items: [String]
//    var body: some View {
//        VStack {
//            var width = CGFloat.zero
//            var height = CGFloat.zero
//            GeometryReader { geo in
//                ZStack(alignment: .topLeading) {
//                    ForEach(items, id: \"\") { item in
//                        Text(item)
//                            .font(.caption)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 6)
//                            .background(Color.blue.opacity(0.3))
//                            .cornerRadius(12)
//                            .alignmentGuide(.leading) { d in
//                                if abs(width - d.width) > geo.size.width - 32 {
//                                    width = 0
//                                    height -= d.height
//                                }
//                                let result = width
//                                if item == items.last { width = 0 } else { width -= d.width }
//                                return result
//                            }
//                            .alignmentGuide(.top) { _ in height }
//                    }
//                }
//                .frame(height: abs(height) + 40)
//            }
//            .frame(height: 100)
//        }
//    }
                            

// MARK: - Bottom Tab Bar Item for ScreenFive
struct ScreenFiveTabBarItem: View {
    let icon: String
    let text: String
    let selected: Bool
    private let navColor = Color(red: 0.11, green: 0.17, blue: 0.29)

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: selected ? "\(icon).fill" : icon)
                .font(.system(size: 20))
                .foregroundColor(selected ? navColor : .gray)
            Text(text)
                .font(.caption)
                .foregroundColor(selected ? navColor : .gray)
        }
    }
}

struct ScreenFive_Previews: PreviewProvider {
    static var previews: some View {
        ScreenFive()
    }
}
