//
//  ContentViewModel.swift
//  Climate Campaign
//
//  Created by Beau Rubin-Rottenberg on 1/4/24.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var billionsLeft = 10.0
    @Published var emmisions = 96.0
    @Published var waterShortage = 75.0
    @Published var airPollution = 68.0
    @Published var popularity = 35.0
    
    @Published var currentPolicies: [Policy] = [] {
        didSet {
            getTotalImpact()
        }
    }
    
    func delete(at offsets: IndexSet) {
        withAnimation(.bouncy(duration: 1.2)) {
            currentPolicies.remove(atOffsets: offsets)
        }
    }
    
    func getTotalImpact() {
        withAnimation {
            emmisions = 96
            waterShortage = 75
            airPollution = 68
            popularity = 35
            billionsLeft = 10
            for policy in currentPolicies {
                let currentImpact = policy.currentLevel.impact
                emmisions += currentImpact.emissionsChange
                waterShortage += currentImpact.waterChange
                airPollution += currentImpact.airChange
                popularity += policy.currentLevel.popularityChange
                billionsLeft -= policy.currentLevel.cost
            }
            if billionsLeft < 0 {
                popularity -= 10
            }
        }
    }
    
    func forTrailingZero(_ temp: Double) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
    
    func restart() {
        billionsLeft = 10.0
        emmisions = 96.0
        waterShortage = 75.0
        airPollution = 68.0
        popularity = 35.0
        
        currentPolicies = []
    }
    
    func findMost() -> (String) {
        let emissionsChange = 96-emmisions
        let waterChange = 75-waterShortage
        let airChange = 68-airPollution
        let popChange = popularity-35
        
        let changes = ["emissions": emissionsChange, "water urgency": waterChange, "air pollution": airChange, "popularity": popChange]
        if let maxChange = changes.max(by: { $0.value < $1.value }) {
            return (maxChange.key)
        } else {
            return "error"
        }
    }
    
    func findLeast() -> (String) {
        let emissionsChange = 96-emmisions
        let waterChange = 75-waterShortage
        let airChange = 68-airPollution
        let popChange = popularity-35
        
        let changes = ["emissions": emissionsChange, "water urgency": waterChange, "air pollution": airChange, "popularity": popChange]
        if let minChange = changes.min(by: { $0.value < $1.value }) {
            return (minChange.key)
        } else {
            return "error"
        }
    }
    
    let potentialPolicies = [
        Policy(
            name: "Green Buildings",
            image: "greenbild",
            description: "This policy requires all newly built residential buildings to adhere to the 'National Green Building Standard' which regulates water efficiency, energy efficiency, and maintenance.",
            levelslabel: "Effective when?",
            levelstype: "years from now",
            levels: [
                Policy.PolicyLevel(
                    level: 1,
                    contextNumber: "5",
                    impact: Policy.EnvironmentalChanges(emissionsChange: -4, waterChange: -3, airChange: -1),
                    cost: 1,
                    popularityChange: 3
                ),
                Policy.PolicyLevel(
                    level: 2,
                    contextNumber: "3",
                    impact: Policy.EnvironmentalChanges(emissionsChange: -5, waterChange: -6, airChange: -3),
                    cost: 1.4,
                    popularityChange: -2
                ),
                Policy.PolicyLevel(
                    level: 3,
                    contextNumber: "2",
                    impact: Policy.EnvironmentalChanges(emissionsChange: -7, waterChange: -8, airChange: -5),
                    cost: 1.7,
                    popularityChange: -4
                ),
            ]
        ),
        Policy(
            name: "Irrigation Limit",
            image: "Irrigation",
            description: "Irrigation consumes 42% of the freshwater supply in the US. This regulation sets a limit to the amount of water that can be used per acre of land for irrigation.",
            levelslabel: "Water limit per acre",
            levelstype: "thousand gallons per acre",
            levels: [
                Policy.PolicyLevel(
                    level: 1,
                    contextNumber: "650",
                    impact: Policy.EnvironmentalChanges(emissionsChange: 0, waterChange: -6, airChange: 0),
                    cost: 0.9,
                    popularityChange: 4
                ),
                Policy.PolicyLevel(
                    level: 2,
                    contextNumber: "550",
                    impact: Policy.EnvironmentalChanges(emissionsChange: 0, waterChange: -9, airChange: 0),
                    cost: 1.2,
                    popularityChange: 1
                ),
                Policy.PolicyLevel(
                    level: 3,
                    contextNumber: "480",
                    impact: Policy.EnvironmentalChanges(emissionsChange: 0, waterChange: -12, airChange: 0),
                    cost: 1.4,
                    popularityChange: -3
                )
            ]
        ),
        Policy(
            name: "CO2 Usage",
            image: "CO2",
            description: "Limit the amount of CO2 that can be released in a power plant based on the amount of energy they use.",
            levelslabel: "Amount of CO2 per kWh hour used",
            levelstype: "pounds per kWh",
            levels: [
                Policy.PolicyLevel(
                    level: 1,
                    contextNumber: "4",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -2,
                        waterChange: 0,
                        airChange: -1
                    ),
                    cost: 0.7,
                    popularityChange: 2
                ),
                Policy.PolicyLevel(
                    level: 2,
                    contextNumber: "3",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -5,
                        waterChange: 0,
                        airChange: -3
                    ),
                    cost: 1.5,
                    popularityChange: -3
                ),
                Policy.PolicyLevel(
                    level: 3,
                    contextNumber: "2",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -8,
                        waterChange: 0,
                        airChange: -6
                    ),
                    cost: 2,
                    popularityChange: -7
                )
            ]
        ),
        Policy(
            name: "Recycling Fines",
            image: "bin",
            description: "All recyclables are required to be recycled, with the penalty of a fine for putting recyclables in a landfill receptacle, in addition to any fines imposed by the local city or county.",
            levelslabel: "Fine for not recycling recyclables",
            levelstype: "dollars per violation",
            levels: [
                Policy.PolicyLevel(
                    level: 1,
                    contextNumber: "15",
                    impact: Policy.EnvironmentalChanges(emissionsChange: -2, waterChange: -1, airChange: -1),
                    cost: 1,
                    popularityChange: 1
                ),
                Policy.PolicyLevel(
                    level: 2,
                    contextNumber: "25",
                    impact: Policy.EnvironmentalChanges(emissionsChange: -4, waterChange: -3, airChange: -3),
                    cost: 1.7,
                    popularityChange: -4
                ),
                Policy.PolicyLevel(
                    level: 3,
                    contextNumber: "30",
                    impact: Policy.EnvironmentalChanges(emissionsChange: -6, waterChange: -4, airChange: -5),
                    cost: 2.1,
                    popularityChange: -5
                )
            ]
        ),
        Policy(
            name: "Water Inspection",
            image: "hydro",
            description: "Hydroelectric power provides over 1/6 of the world's electricity. However, hydroelectric power plants can pollute the surrounding waters. This policy requires these plants receive a certain amount of yearly inspections to ensure they comply with their Water Quality Certificate.",
            levelslabel: "How many inspections each year?",
            levelstype: "inspections per year",
            levels: [
                Policy.PolicyLevel(
                    level: 1,
                    contextNumber: "1",
                    impact: Policy.EnvironmentalChanges(emissionsChange: 0, waterChange: -3, airChange: -1),
                    cost: 0.9,
                    popularityChange: 0
                ),
                Policy.PolicyLevel(
                    level: 2,
                    contextNumber: "3",
                    impact: Policy.EnvironmentalChanges(emissionsChange: -1, waterChange: -5, airChange: -1),
                    cost: 1.4,
                    popularityChange: -1
                ),
                Policy.PolicyLevel(
                    level: 3,
                    contextNumber: "5",
                    impact: Policy.EnvironmentalChanges(emissionsChange: -2, waterChange: -9, airChange: -2),
                    cost: 1.9,
                    popularityChange: -4
                )
            ]
        ),
        Policy(
            name: "Car Emissions",
            image: "exaustpipe",
            description: "Limit the amount of emissions that a passenger vehicle can emit by setting a cap on how much CO2 it can emit when idling for one hour. These vehicles must meet this standard before being eligible for distribution.",
            levelslabel: "Amount of CO2 allowed to be emited during 1 hour idling",
            levelstype: "pounds of CO2",
            levels: [
                Policy.PolicyLevel(
                    level: 1,
                    contextNumber: "6",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -3,
                        waterChange: 0,
                        airChange: -2
                    ),
                    cost: 1.2,
                    popularityChange: 2
                ),
                Policy.PolicyLevel(
                    level: 2,
                    contextNumber: "5",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -5,
                        waterChange: 0,
                        airChange: -3
                    ),
                    cost: 1.7,
                    popularityChange: -2
                ),
                Policy.PolicyLevel(
                    level: 3,
                    contextNumber: "4",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -10,
                        waterChange: 0,
                        airChange: -6
                    ),
                    cost: 2.5,
                    popularityChange: -4
                )
            ]
        ),
        Policy(
            name: "Compost Required",
            image: "compost",
            description: "All waste is now required to seperate and properly label food scrap and food-soiled paper away from other waste such as trash or recycling.",
            levelslabel: "Effective when?",
            levelstype: "years from now",
            levels: [
                Policy.PolicyLevel(
                    level: 1,
                    contextNumber: "5",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: 0,
                        waterChange: -4,
                        airChange: -2
                    ),
                    cost: 1,
                    popularityChange: -2
                ),
                Policy.PolicyLevel(
                    level: 2,
                    contextNumber: "3",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: 0,
                        waterChange: -5,
                        airChange: -3
                    ),
                    cost: 1.4,
                    popularityChange: -3
                ),
                Policy.PolicyLevel(
                    level: 3,
                    contextNumber: "2",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: 0,
                        waterChange: -8,
                        airChange: -4
                    ),
                    cost: 1.8,
                    popularityChange: -5
                )
            ]
        ),
        Policy(
            name: "City Monitoring",
            image: "monitoring",
            description: "Require cities to measure and submit a public report and analysis of this metric",
            levelslabel: "Which metric?",
            levelstype: "per cubic foot",
            levels: [
                Policy.PolicyLevel(
                    level: 1,
                    contextNumber: "Pounds of CO2",
                    impact: Policy.EnvironmentalChanges(emissionsChange: -5, waterChange: 0, airChange: -1),
                    cost: 1.5,
                    popularityChange: 1
                ),
                Policy.PolicyLevel(
                    level: 2,
                    contextNumber: "Pounds of microplastics in water",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: 0,
                        waterChange: -5,
                        airChange: -1
                    ),
                    cost: 1.5,
                    popularityChange: 1
                ),
                Policy.PolicyLevel(
                    level: 3,
                    contextNumber: "Pounds of smog gasses",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -1,
                        waterChange: 0,
                        airChange: -5
                    ),
                    cost: 1.5,
                    popularityChange: 1
                )
            ]
        ),
        Policy(
            name: "Gas Stove Ban",
            image: "stove",
            description: "The buildings specified are prohibited from installing natural gas powered stoves, furnaces, and propane heating, instead opting for more environmentally friendly alternatives such as induction stoves.",
            levelslabel: "Effective in what buildings?",
            levelstype: "buildings",
            levels: [
                Policy.PolicyLevel(
                    level: 1,
                    contextNumber: "Large newly built",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -4,
                        waterChange: 0,
                        airChange: -5
                    ),
                    cost: 1.5,
                    popularityChange: -2
                ),
                Policy.PolicyLevel(
                    level: 2,
                    contextNumber: "All newly built",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -6,
                        waterChange: 0,
                        airChange: -8
                    ),
                    cost: 2,
                    popularityChange: -4
                ),
                Policy.PolicyLevel(
                    level: 3,
                    contextNumber: "All",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -10,
                        waterChange: 0,
                        airChange: -11
                    ),
                    cost: 2.9,
                    popularityChange: -6
                )
            ]
        ),
        Policy(
            name: "Carbon Price",
            image: "carbonprice",
            description: "Charge corperations for every ton of carbon they emit after 2030, encoraging them to go carbon neutral.",
            levelslabel: "What price?",
            levelstype: "per ton of carbon",
            levels: [
                Policy.PolicyLevel(
                    level: 1,
                    contextNumber: "15",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -6,
                        waterChange: -1,
                        airChange: -3
                    ),
                    cost: 2,
                    popularityChange: -1
                ),
                Policy.PolicyLevel(
                    level: 2,
                    contextNumber: "25",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -10,
                        waterChange: -3,
                        airChange: -5
                    ),
                    cost: 2.6,
                    popularityChange: -4
                ),
                Policy.PolicyLevel(
                    level: 3,
                    contextNumber: "40",
                    impact: Policy.EnvironmentalChanges(
                        emissionsChange: -15,
                        waterChange: -5,
                        airChange: -8
                    ),
                    cost: 3.1,
                    popularityChange: -8
                )
            ]
        )
    ]
    
    init() {}
}
