//
//  GoalsView.swift
//  iChoose
//
//  Created by Dmitrii Pogonia on 04.01.2024.
//

import SwiftUI

struct GoalsView: View {
    var body: some View {
        VStack {
            DatePicker(selection: .constant(.now), label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
            Spacer()
            Photo(assetName: "deer-valley", captionText: "Deer Valley")
            Spacer()
            IfElseTrain()
            Spacer()
            EventTile(event: Event())
            Spacer()
            HStack {
                TrainCar(TrainSymbol.rare)
                TrainCar(TrainSymbol.middle)
                TrainCar(TrainSymbol.front)
            }
            Spacer()
            SpecificSpacing()
            Spacer()
            StarRating(rating: .random(in: 1..<6))
            Spacer()
        }
    }
}

struct IfElseTrain: View {
    
    @State private var longerTrain: Bool = true
    var animals: [String] = ["bird", "cat", "dog"]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: animals[0])
                Image(systemName: animals[1])
                    .opacity(longerTrain ? 1 : 0)
                Image(systemName: animals[2])
            }
            Toggle("", isOn: $longerTrain)
                .padding(.trailing, 175)
                .foregroundColor(Color("red: 0.5, green: 0.6, blue: 0.1"))
        }
    }
}

struct Photo: View {
    let assetName: String
    let captionText: String
    
    var body: some View {
        Image(assetName)
            .resizable()
            .scaledToFit()
            .overlay(alignment: .bottom) {
                Caption(text: captionText)
            }
            .clipShape(RoundedRectangle(cornerRadius: 80, style: .continuous))
            .padding()
    }
}

struct Caption: View {
    let text: String
    var body: some View {
        Text(text)
            .padding()
            .background(Color("gradientBottom").opacity(0.7), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding()
    }
}

struct Event {
    let title: String = "New Year"
    let date: Date = .now
    let location: String = "Moscow"
    let symbol: String = "football"
}

struct EventTile: View {
    let event: Event
    let stripeHeight = 15.0
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: event.symbol)
                .font(.system(size: 60))
                
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.title)
                Text(event.date, format: Date.FormatStyle()
                    .day(.defaultDigits)
                    .month(.wide)
                    .year(.extended())
                     )
                Text(event.location)
            }
        }
        .padding()
        .padding(.top, stripeHeight)
        .background {
            ZStack(alignment: .top) {
                Rectangle()
                    .opacity(0.3)
                Rectangle()
                    .frame(maxHeight: stripeHeight)
            }
            .foregroundColor(.teal)
        }
        .clipShape(RoundedRectangle(cornerRadius: stripeHeight, style: .continuous))
    }
}

enum TrainSymbol: String {
    case front = "train.side.front.car"
    case middle = "train.side.middle.car"
    case rare = "train.side.rear.car"
}

struct TrainCar: View {
    let position: TrainSymbol
    let showFrame: Bool
    
    init(_ position: TrainSymbol, showFrame: Bool = true) {
        self.position = position
        self.showFrame = showFrame
    }
    var body: some View {
        Image(systemName: position.rawValue)
            .background(Color("gradientTop"))
    }
}


struct SpecificSpacing: View {
    @ScaledMetric var trainCarSpace = 0
    var body: some View {
        HStack(spacing: trainCarSpace) {
            TrainCar(.rare)
            TrainCar(.middle)
            TrainCar(.front)
        }
        .font(.title)
    }
}

struct StarRating: View {
    @State var rating: Int
    private let maxRating = 5


    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1, id: \.self) { value in
                Image(systemName: "star")
                    .symbolVariant(value <= rating ? .fill : .none)
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        if value != rating {
                            rating = value
                        } else {
                            rating = 0
                        }
                    }
            }
        }
    }
}




#Preview {
    GoalsView()
}
