//
//  Policy.swift
//  Climate Campaign
//
//  Created by Beau Rubin-Rottenberg on 1/6/24.
//

import Foundation


struct Policy {
    var name: String
    var image: String
    var description: String
    var levelslabel: String
    var levelstype: String
    var levels: [PolicyLevel]
    var currentLevelNum: Int = 1
    var currentLevel: PolicyLevel {
            // Return PolicyLevel w/ current level number
            // If no matching level found, default to the first level
            levels.first { $0.level == currentLevelNum } ?? levels.first!
        }

    struct EnvironmentalChanges {
        var emissionsChange: Double
        var waterChange: Double
        var airChange: Double
    }

    struct PolicyLevel {
        var level: Int
        var contextNumber: String
        var impact: EnvironmentalChanges
        var cost: Double
        var popularityChange: Double
    }
}
