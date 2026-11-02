
import SwiftUI

struct Activity: Codable, Identifiable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount = 0

    static let example = Activity(title: "Example activity", description: "This is a test activity.")
}

class Activities: ObservableObject {
    @Published var activities: [Activity] {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }

    init() {
        if let saved = UserDefaults.standard.data(forKey: "Activities") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: saved) {
                activities = decoded
                return
            }
        }

        activities = []
    }
}


struct HabitoView: View {
    @StateObject var data = Activities()
    @State private var addingNewActivity = false
        var body: some View {
            NavigationView {
                List(data.activities) { activity in
                    NavigationLink {
                        ActivityView(data: data, activity: activity)
                    } label: {
                        HStack {
                            Text(activity.title)
                            Spacer()

                            Text(String(activity.completionCount))
                                .font(.caption.weight(.black))
                                .padding(5)
                                .frame(minWidth: 50)
                                .background(color(for: activity))
                                .clipShape(Capsule())
                        }
                    }
                }
                .navigationTitle("Habito")
                .toolbar {
                    Button {
                        addingNewActivity.toggle()
                    } label: {
                        Label("Add new activity", systemImage: "plus")
                    }
                }
                .sheet(isPresented: $addingNewActivity) {
                    AddActivity(data: data)
                }
            }
        }
    func color(for activity: Activity) -> Color {
        if activity.completionCount < 3 {
            return .red
        } else if activity.completionCount < 10 {
            return .orange
        } else if activity.completionCount < 20 {
            return .green
        } else if activity.completionCount < 50 {
            return .blue
        } else {
            return .indigo
        }
    }
}

struct AddActivity: View {
    @ObservedObject var data: Activities
    @State private var title = ""
    @State private var description = ""

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add Activity")
            .toolbar {
                Button("Save") {
                    let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
                    guard trimmedTitle.isEmpty == false else { return }

                    let activity = Activity(title: trimmedTitle, description: description)
                    data.activities.append(activity)
                    dismiss()
                }
            }
        }
    }
}


struct ActivityView: View {
    @ObservedObject var data: Activities
    var activity: Activity

    var body: some View {
        List {
            Section {
                if activity.description.isEmpty == false {
                    Text(activity.description)
                }
            }

            Section {
                Text("Completion count: \(activity.completionCount)")

                Button("Mark Completed") {
                    var newActivity = activity
                    newActivity.completionCount += 1

                    if let index = data.activities.firstIndex(of: activity) {
                        data.activities[index] = newActivity
                    }
                }
            }
        }
        .navigationTitle(activity.title)
    }
}

#Preview {
    HabitoView()
}

