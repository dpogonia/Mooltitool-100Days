//  Created by Dmitrii Pogonia on 04.01.2024.
import SwiftUI
import SwiftData
import MapKit

// MARK: VISION VIEW
struct VisionView: View {
    
    @State private var areas: [String] = ["HEALTH", "GROWTH", "FINANCE", "SOCIAL"]
    @State private var areaToAdd: String = ""
    @State private var infoToAdd: String = ""
    @State private var selectedArea: String?
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: HEADER ZONE
                VStack {
                    VStack(spacing: 8) {
                        Image(systemName: "aqi.medium")
                            .font(.largeTitle)
                            .foregroundStyle(.mint)
                            .foregroundColor(.primary)
                            .symbolRenderingMode(.hierarchical)
                            .imageScale(.large)
                        Text("CHOOSE YOUR AREAS OF DEVELOPMENT")
                    }
                }
                
                // MARK: AREAS ZONE
                List {
                    ForEach(areas, id: \.self) { area in
                        VStack {
                            Label(area, systemImage: "chart.bar")
                        }
                        .onTapGesture {
                            if selectedArea == area {
                                selectedArea = nil
                            } else {
                                selectedArea = area
                            }
                        }
                        
                        if selectedArea == area {
                            Text(infoToAdd)
                            TextField("Additional information for \(area)", text: $infoToAdd, onCommit: {
                                if !infoToAdd.isEmpty {
                                    Text(infoToAdd)
                                }
                            })
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: deleteItems)
            }
                // Form of list view items
                .clipShape(RoundedRectangle(cornerRadius: 8))
                // Adding "plus" button at the top of the view
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            isTextFieldFocused = true
                        }) {
                            Label("Add Item", systemImage: "plus")
                        }
                        .focused($isTextFieldFocused)
                        .onSubmit {
                            isTextFieldFocused = false
                            areaToAdd = ""
                        }
                    }
                }
                MapView()
                Spacer()
                CircleImage()
                    .offset(y: -130)
                    .padding(.bottom, -130)
                    
                
                // MARK: TEXT FIELD TO ADD AREAS
                TextField("Type a new development area to add", text: $areaToAdd, onCommit: {
                    if !areaToAdd.isEmpty {
                        areas.append(areaToAdd)
                        areaToAdd = ""
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 30)
                .autocorrectionDisabled()
                .focused($isTextFieldFocused)
                .onSubmit {
                    isTextFieldFocused = false
                    areaToAdd = ""
                }
                Spacer()
            }
        }
    }
    
    // MARK: FUNCTIONS
    // Delete area
    private func deleteItems(at offsets: IndexSet) {
        areas.remove(atOffsets: offsets)
    }
}


struct CircleImage: View {
    var body: some View {
        Image("apollo15")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct MapView: View {
    var body: some View {
        if #available(iOS 17.0, *) {
            Map(initialPosition: .region(region))
        }
        else {
            // Fallback on earlier versions
        }
    }
    
    private var region: MKCoordinateRegion {
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
}

#Preview {
    VisionView()
}
