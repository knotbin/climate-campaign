//
//  WelcomeView.swift
//  Climate Campaign
//
//  Created by Beau Rubin-Rottenberg on 12/17/23.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var opened: Bool
//    let backgroundGradient = LinearGradient(
//        colors: [Color.green, Color.cyan],
//        startPoint: .top, endPoint: .bottom)
    var body: some View {
        VStack(alignment: .leading) {
            Text("Climate Campaign")
                .font(.largeTitle).fontWeight(.heavy)
            Text("You are the administrator of the Environmental Protection Agency.")
                .fontWeight(.semibold)
                .font(.system(size: 24))
                .multilineTextAlignment(.leading)
                .padding(.bottom, 10.0)
                .padding(.top)
            Text("Budget 💰")
                .fontWeight(.semibold)
                .font(.system(size: 30))
            Text("You will receive a 10 billion dollar budget for 2024, very similar to recent EPA budgets.")
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .font(.system(size: 23))
                .padding(.bottom, 10)
            Text("Outline ✍️")
                .fontWeight(.semibold)
                .font(.system(size: 30))
            Text("You must allocate your funding to different policies to change different environmental factors while keeping in budget and politically popular. After you finish, you will see a summary of your efforts. The goal is to balance making as much environmental change as possible with keeping within budget and maintaining popularity.")
                .multilineTextAlignment(.leading)
                .font(.system(size: 22))
            Text("What metrtics will you prioritize and what might you have to sacrifice to acheive those goals?")
                .multilineTextAlignment(.leading)
                .font(.system(size: 22))
                .bold()
                .padding(.vertical, 10.0)
            Spacer()
            HStack {
                Spacer()
                Image("epa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom))
                Spacer()
            }
                
            TLButton(title: "Let's Go", bgColor: .blue) {
                opened = false
            }
            .frame(height: 80.0)
            .padding(.horizontal, 20.0)
            
        }
        .padding(25.0)
        .foregroundColor(.white)
        .ignoresSafeArea()
        .shadow(radius: 10)
        .background(
            ZStack {
                Color.blue
                Image("lake")
                    .resizable()
                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .top, endPoint: .bottom))
                Color.green.opacity(0.2)
            }
        )
    }
}

#Preview {
    WelcomeView(opened: .constant(false))
}
