//
//  PolicyButtonView.swift
//  Climate Campaign
//
//  Created by Beau Rubin-Rottenberg on 1/5/24.
//

import SwiftUI
import TipKit

@available(iOS 17.0, *)
struct PolicyButtonView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    @State var image: String
    @State var policy: Policy
    @State var sheetshown = false
    @State var toggleView = true
    var body: some View {
        
        VStack {
            Button {
                sheetshown = true
                
            } label: {
                VStack(alignment: .leading) {
                    Image(image)
                        .resizable()
                        .frame(width: 147, height: 100)
                    VStack(alignment: .leading) {
                        Text(policy.name)
                            .font(.system(size: 15))
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 5.0)
                            .foregroundColor(.primary)
                        
                        // Assuming displaying details from the first level
                        HStack {
                            environmentalChangeView(icon: "smoke.fill", value: policy.currentLevel.impact.emissionsChange, color: .red)
                            environmentalChangeView(icon: "drop.fill", value: policy.currentLevel.impact.waterChange, color: .blue)
                            environmentalChangeView(icon: "wind.circle.fill", value: policy.currentLevel.impact.airChange, color: .brown)
                        }
                        .padding(.bottom, 3.0)

                        HStack {
                            environmentalChangeView(icon: "dollarsign.circle.fill", value: policy.currentLevel.cost, color: .green)
                            environmentalChangeView(icon: "person.2.fill", value: policy.currentLevel.popularityChange, color: .orange)
                        }
                        .padding(.bottom, 15.0)
                    }
                    .padding([.leading, .bottom, .trailing], 10.0)
                }
                .background(Color.gray.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .sheet(isPresented: $sheetshown, content: {
                    PolicySpecificView(opened: $sheetshown, viewModel: viewModel, policy: policy)
                })
            }
            .padding(.trailing)
        }
    }

    func environmentalChangeView(icon: String, value: Double, color: Color) -> some View {
        HStack {
            Image(systemName: icon)
            Text(forTrailingZero(value))
        }
        .foregroundColor(color)
        .font(.system(size: 12))
    }

    func forTrailingZero(_ temp: Double) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
}
