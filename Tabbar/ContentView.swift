import SwiftUI

struct ContentView: View {
    @State var selectedTab = "home"
    @State var TabbarItems = ["home", "profile", "middle", "notes", "settings"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                ForEach(TabbarItems, id: \.self) { item in
                    getView(for: item)
                        .tag(item)
                }
            }
            
            CustomTabBar(selectedTab: $selectedTab, items: TabbarItems)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    @ViewBuilder
    func getView(for item: String) -> some View {
        switch item {
        case "home":
        View:do {
            Text("sasas").frame(maxWidth: .infinity, maxHeight: .infinity) .background(Color.red)
        }
        case "profile":
            Text("Profile View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.yellow)
                .edgesIgnoringSafeArea(.all)
        case "notes":
            Text("Notes View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.green)
                .edgesIgnoringSafeArea(.all)
        case "settings":
            Text("Settings View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
        case "middle":
            Text("Middle View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
        default:
            Text("View not found")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: String
    var items: [String]
    
    var body: some View {
        ZStack {
            MiddleCurveTabBackgrounds()
                .fill(Color(hex: "#272652"))
                .shadow(radius: 5)
                .frame(height: 70)
                .edgesIgnoringSafeArea(.bottom)
            
            HStack {
                ForEach(items, id: \.self) { item in
                    Spacer()
                    
                    Button(action: {
                        selectedTab = item
                    }) {
                        VStack {
                            if item == "middle" {
                                ZStack {
                                    Circle()
                                        .fill(
                                            RadialGradient(
                                                gradient: Gradient(colors: [
                                                    Color(hex: "#181AA3"),
                                                    Color(hex: "#5D5FEF"),
                                                    Color(hex: "#9496FF")
                                                ]),
                                                center: .center,
                                                startRadius: 10,
                                                endRadius: 35
                                            )
                                        )
                                        .frame(width: 60, height: 60)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white)
                                        )
                                    
                                    Image("middle")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                }
                                .shadow(radius: 5)
                                .offset(y: -45) .contentShape(Rectangle())
                            } else {
                                Image(selectedTab == item ? item + "Active" : item + "Inactive")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .frame(height: 70)
        }
    }
}

struct MiddleCurveTabBackgrounds: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let mid = rect.width / 2
            path.move(to: CGPoint(x: mid - 70, y: 0))
            
            let to1 = CGPoint(x: mid, y: 35)
            let control1 = CGPoint(x: mid - 35, y: 0)
            let control2 = CGPoint(x: mid - 35, y: 30)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            let to2 = CGPoint(x: mid + 70, y: 0)
            let control3 = CGPoint(x: mid + 35, y: 30)
            let control4 = CGPoint(x: mid + 35, y: 0)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    ContentView()
}
