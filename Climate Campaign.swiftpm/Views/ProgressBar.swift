//
//  ProgressBar.swift
//  Climate Campaign
//
//  Created by Beau Rubin-Rottenberg on 1/4/24.
//

import SwiftUI

struct ProgressBar: View {
    @StateObject var viewModel = ContentViewModel()
    
    var value: Double
    var total: ClosedRange<Double>
    var title: String
    var type: String
    var color: Color
    var icon: String
    
    var body: some View {
        Gauge(value: value, in: total) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.system(size: 16))
                    .bold()
            }
        } currentValueLabel: {
            Text("\(viewModel.forTrailingZero(value)) \(type)")
                .font(.system(size: 15))
        }
        .tint(color)
        
        
    }
}

#Preview {
    ProgressBar(value: 1.0, total: 0...5.0, title: "Hello", type: "dollars", color: .blue, icon: "dollarsign.circle.fill")
}
