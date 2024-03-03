//
//  TLButton.swift
//  Tootoo
//
//  Created by Beau Rubin-Rottenberg on 8/19/23.
//

import SwiftUI

struct TLButton: View {
    let title: String
    let bgColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(bgColor)
                
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}

struct TLButton_Previews: PreviewProvider {
    static var previews: some View {
        TLButton(title: "Button", bgColor: .blue) {
            //action
        }
    }
}
