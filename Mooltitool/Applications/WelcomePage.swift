//
//  Learning2.swift
//  Mooltitool
//
//  Created by Dmitrii Pogonia on 23.12.2023.
//

import SwiftUI

let gradientColors: [Color] = [
    .gradientTop,
    .gradientBottom
]

struct tabView: View {
    var body: some View {
        TabView {
            WelcomePage()
            FeaturesPage()
            LearningView()
        }
        .background(Gradient(colors: gradientColors))
        .tabViewStyle(.page)
        .foregroundStyle(.white)
    }
}
    

struct WelcomePage: View {
    var body: some View {
        VStack(spacing: 30){
            ZStack {
                RoundedRectangle(cornerRadius: 180)
                    .foregroundStyle(.accent)
                    
                .frame(width: 100, height: 100)
                
                Image(systemName: "figure.boxing")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .background(.accent)
            }
            Text("Welcome Page")
                .font(.title)
                .fontWeight(.black)
                .fontWidth(.condensed)
                .fontDesign(.rounded)
                .padding(.bottom)
            Text("Description")
                .font(.callout)
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
                .border(.orange)
        }
        .padding()
        .border(.orange, width: 1.5)
    }
}

struct FeaturesPage: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Features")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom)
                .padding(.top, 100)
            
            FeatureCard(iconName: "person.2.crop.square.stack.fill",
                                    description: "A multiline description about a feature paired with the image on the left.")
            
            FeatureCard(iconName: "quote.bubble.fill", description: "Short summary")
            
            Spacer()


        }
        .padding()
    }
}

struct FeatureCard: View {
    let iconName: String
    let description: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.largeTitle)
                .frame(width: 50)
                .padding(.trailing, 10)
            
            Text(description)
            
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.tint)
                .opacity(0.25)
                .brightness(-0.4)
        }
        .foregroundStyle(.white)
    }
}

struct LearningView: View {
    var body: some View {
        
            VStack {
                HStack {
                    ScrollView {
                        VStack {
                            HStack {
                                
                                DayForecast(day: "Monday", high: 17, low: 13, isRainy: true)
                                
                                DayForecast(day: "Tuesday", high: 18, low: 14, isRainy: false)
                                
                                DayForecast(day: "Wednesday", high: 19, low: 16, isRainy: false)
                                
                                DayForecast(day: "Thursday", high: 20, low: 16, isRainy: false)
                                
                                DayForecast(day: "Friday", high: 20, low: 14, isRainy: false)
                                
                                DayForecast(day: "Saturday", high: 19, low: 15, isRainy: false)
                                
                                DayForecast(day: "Sunday", high: 22, low: 18, isRainy: false)
                                
                            }
                        }
                        WeekForecast()
                        
                        VStack(spacing: 10) {
                            Text("Knock, knock!")
                                .padding()
                                .background(Color.teal, in: RoundedRectangle(cornerRadius: 8))
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            Text("Who's there?")
                                .padding()
                                .background(Color.yellow, in: RoundedRectangle(cornerRadius: 8))
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                        .padding()
                    }
                }
        }
    }
}

struct DayForecast: View {
    let day: String
    let high: Int
    let low: Int
    let isRainy: Bool
    
    var body: some View {
        VStack {
            Text(day)
                .font(.headline)
                .fontWeight(.black)
                .fontDesign(.rounded)
            Image(systemName: isRainy ? "sun.max.fill" : "sun.rain")
                .foregroundStyle(Color.yellow)
                .font(.largeTitle)
                .padding(3)
            Text("\(high)º")
                .fontWeight(.black)
                .fontDesign(.rounded)
                .foregroundColor(high > 18 ? .red : .blue)
            Text("\(low)º")
                .fontWeight(.black)
                .fontDesign(.rounded)
                .foregroundStyle(.secondary)
                .foregroundColor(high > 18 ? .red : .blue)
        }
        .padding()
    }
}

struct WeekForecast: View {
    var body: some View {
        HStack { ScrollView([.horizontal, .vertical]) {
            ForEach(0..<32) {
                Text("\($0)")
            }
        }
        }
    }
}


#Preview {
    tabView()

}
