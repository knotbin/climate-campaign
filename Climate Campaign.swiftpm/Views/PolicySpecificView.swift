//
//  PolicySpecificView.swift
//  Climate Campaign
//
//  Created by Beau Rubin-Rottenberg on 1/20/24.
//

import SwiftUI
import TipKit

@available(iOS 17.0, *)
struct PolicySpecificView: View {
    @Binding var opened: Bool
    @ObservedObject var viewModel: ContentViewModel
    @State var policy: Policy
    private let values = [1.0, 2.0, 3.0]
    @State var value: Double = 1

    @State var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(policy.name)
                    .bold()
                .font(.system(size: 45))
                .foregroundColor(.primary)
            }
            
            Text(policy.description)
                .font(.system(size: 25))
                .padding(.bottom, 20.0)
                .multilineTextAlignment(.leading)
                .foregroundColor(.primary)
            HStack {
                environmentalChangeView(icon: "dollarsign.circle.fill", value: policy.currentLevel.cost, color: .green, text: "Cost in billions:", twotext: "lower is better")
                    .padding(.trailing)
                environmentalChangeView(icon: "person.2.fill", value: policy.currentLevel.popularityChange, color: .orange, text: "Popularity change:", twotext: "higher is better")
            }
            .padding(.bottom, 5.0)
            HStack {
                environmentalChangeView(icon: "smoke.fill", value: policy.currentLevel.impact.emissionsChange, color: .red, text: "Emmisions Change", twotext: "lower is better")
                    .padding(.trailing)
                environmentalChangeView(icon: "drop.fill", value: policy.currentLevel.impact.waterChange, color: .blue, text: "Water Change:", twotext: "lower is better")
                    .padding(.trailing)
            }
            .padding(.bottom, 5.0)
            environmentalChangeView(icon: "wind.circle.fill", value: policy.currentLevel.impact.airChange, color: .brown, text: "Air Quality Change:", twotext: "lower is better")
            Spacer()
            VStack(alignment: .leading) {
                Text(policy.levelslabel).bold()
                    .font(.system(size: 30))
                Text("Select to change effectivity, cost, and popularity.")
                Form {
                    Section {
                        Picker(selection: $policy.currentLevelNum) {
                            ForEach (policy.levels, id: \.level) { level in
                                Text(String("\(level.contextNumber) \(policy.levelstype)"))
                                    .tint(.primary)
                            }
                        } label: {}
                        .pickerStyle(.inline)
                    }
                    .listRowBackground(Color.gray.opacity(0.2))
                }
                .frame(height: 200.0)
                .scrollContentBackground(.hidden)
                .tint(.blue)
                
                TLButton(title: "Add Policy", bgColor: .blue) {
                    if viewModel.currentPolicies.contains(where: { $0.name == policy.name}) {
                        showAlert = true
                    } else {
                        withAnimation(.bouncy(duration: 1.2)) {
                            viewModel.currentPolicies.insert(policy, at: 0)
                        }
                        opened = false
                    }
                }
                .frame(height: 80.0)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Policy already added."),
                message: Text("You cannot add multiple of the same policy.")
            )
        }
    }
    func environmentalChangeView(icon: String, value: Double, color: Color, text: String, twotext: String) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(text)
                    .font(.system(size: 20))
                    .bold()
                Text(forTrailingZero(value))
                    .bold()
                    .font(.system(size: 20))
            }
            .foregroundColor(color)
            .padding(.trailing, 2.0)
            Text(twotext)
                .foregroundColor(.gray)
        }
    }
    func forTrailingZero(_ temp: Double) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
}
