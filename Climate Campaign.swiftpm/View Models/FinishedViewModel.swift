//
//  FinishedViewModel.swift
//
//
//  Created by Beau Rubin-Rottenberg on 2/14/24.
//

import Foundation
import SwiftUI

class FinishedViewModel: ObservableObject {
    @Published var revealp1 = false
    @Published var revealp2 = false
    @Published var revealp3 = false
    @Published var revealp4 = false
    @Published var revealp5 = false
    @Published var revealp6 = false
    
    func revealAll() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            withAnimation(.spring) {
                self.revealp1 = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            withAnimation(.spring) {
                self.revealp2 = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            withAnimation(.spring) {
                self.revealp3 = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            withAnimation(.spring) {
                self.revealp4 = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            withAnimation(.spring) {
                self.revealp5 = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6)) {
            withAnimation(.spring) {
                self.revealp6 = true
            }
        }
    }
}
