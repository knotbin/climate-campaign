//
//  MetersView.swift
//  Climate Campaign
//
//  Created by Beau Rubin-Rottenberg on 1/12/24.
//

import SwiftUI

struct MetersView: View {
    @ObservedObject var viewModel: ContentViewModel
    var body: some View {
        VStack {
            HStack {
                ProgressBar(value: viewModel.billionsLeft, total: 0...10.0, title: "Money Left", type: "billion dollars left", color: .green, icon: "dollarsign.circle.fill")
                ProgressBar(value:  viewModel.popularity, total: 0...100, title: "Popularity", type: "percent of support (higher is better)", color: .orange, icon: "person.2.fill")
            }
            .padding(.bottom, 2)
            HStack {
                ProgressBar(value: viewModel.emmisions, total: 0...100, title: "Carbon Emmisions", type: "urgency rating (lower is better)", color: .red, icon: "smoke.fill")
                ProgressBar(value: viewModel.waterShortage, total: 0...100, title: "Water Shortage", type: "urgency rating (lower is better)", color: .blue, icon: "drop.fill")
                ProgressBar(value: viewModel.airPollution, total: 0...100, title: "Air Pollution", type: "urgency rating (lower is better)", color: .brown, icon: "wind.circle.fill")
            }
        }
        .padding(5)
    }
}

#Preview {
    MetersView(viewModel: .init())
}
