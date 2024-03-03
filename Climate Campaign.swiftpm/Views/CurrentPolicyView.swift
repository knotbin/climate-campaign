//
//  CurrentPolicyView.swift
//  
//
//  Created by Beau Rubin-Rottenberg on 2/5/24.
//

import SwiftUI

struct CurrentPolicyView: View {
    var policy: Policy
    var viewModel: ContentViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(policy.name)
            HStack {
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                    Text(String(viewModel.forTrailingZero(policy.currentLevel.cost)))
                        .font(.system(size: 15))
                        .bold()
                }
                    .foregroundColor(.green)
                    .padding(.trailing, 5.0)
                HStack {
                    Image(systemName: "person.2.fill")
                    Text(String(viewModel.forTrailingZero(policy.currentLevel.popularityChange)))
                        .font(.system(size: 15))
                        .bold()
                }
                    .foregroundColor(.orange)
                    .padding(.trailing, 5.0)
                HStack {
                    Image(systemName: "smoke.fill")
                    Text(String(viewModel.forTrailingZero(policy.currentLevel.impact.emissionsChange)))
                        .font(.system(size: 15))
                        .bold()
                }
                    .foregroundColor(.red)
                    .padding(.trailing, 5.0)
                HStack {
                    Image(systemName: "drop.fill")
                    Text(String(viewModel.forTrailingZero(policy.currentLevel.impact.waterChange)))
                        .font(.system(size: 15))
                        .bold()
                }
                    .foregroundColor(.blue)
                    .padding(.trailing, 5.0)
                HStack {
                    Image(systemName: "wind.circle.fill")
                    Text(String(viewModel.forTrailingZero(policy.currentLevel.impact.airChange)))
                        .font(.system(size: 15))
                        .bold()
                }
                    .foregroundColor(.brown)
            }
        }
    }
}

#Preview {
    CurrentPolicyView(policy: .init(
        name: "Green Buildings",
        image: "greenbild",
        description: "This policy requires all newly built residential buildings to adhere to the 'National Green Building Standard' which regulates water efficiency, energy efficiency, and maintenance.",
        levelslabel: "Effective when?",
        levelstype: "years from now",
        levels: [
            Policy.PolicyLevel(
                level: 1,
                contextNumber: "5",
                impact: Policy.EnvironmentalChanges(emissionsChange: -7, waterChange: -6, airChange: -1),
                cost: 1,
                popularityChange: 3
            ),
            Policy.PolicyLevel(
                level: 2,
                contextNumber: "3",
                impact: Policy.EnvironmentalChanges(emissionsChange: -10, waterChange: -9, airChange: -3),
                cost: 1.4,
                popularityChange: -2
            ),
            Policy.PolicyLevel(
                level: 3,
                contextNumber: "1",
                impact: Policy.EnvironmentalChanges(emissionsChange: -13, waterChange: -12, airChange: -6),
                cost: 1.7,
                popularityChange: -4
            ),
        ]
    ), viewModel: ContentViewModel())
}
