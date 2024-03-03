//
//  FinishedView.swift
//
//
//  Created by Beau Rubin-Rottenberg on 2/6/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct FinishedView: View {
    var viewModel: ContentViewModel
    @StateObject var animationModel = FinishedViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            if animationModel.revealp1 == true {
                HStack {
                    StatText(icon: "dollarsign.circle.fill", value: viewModel.billionsLeft, change: 10-viewModel.billionsLeft, label: "b", title: "Money left", color: .green, appearValue: animationModel.revealp1)
                    Spacer()
                    VStack(alignment: .trailing) {
                        if viewModel.billionsLeft == 10 {
                            Text("You did not spend any of your budget on any improvements.")
                        } else
                        if viewModel.billionsLeft < 10 && viewModel.billionsLeft > 8 {
                            Text("You spent very little of your allocated budget.")
                        } else
                        if viewModel.billionsLeft < 8 && viewModel.billionsLeft > 6 {
                            Text("You spent a relatively small portion of your budget.")
                        } else
                        if viewModel.billionsLeft < 6 && viewModel.billionsLeft > 4 {
                            Text("You spent about half of your budget, still leaving the other half unused.")
                        } else
                        if viewModel.billionsLeft < 4 && viewModel.billionsLeft > 2 {
                            Text("You spent a sizeable majority of your budget but some is still left over.")
                        } else
                        if viewModel.billionsLeft < 2 && viewModel.billionsLeft > 0 {
                            Text("You spent almost all of your budget.")
                        } else
                        if viewModel.billionsLeft < 0 {
                            Text("You went over-budget, hurting your and the EPA's political standing.")
                        }
                    }
                    .multilineTextAlignment(.trailing)
                    .frame(width: 290.0)
                    .font(.system(size: 20)).bold()
                    .foregroundColor(.green)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            if animationModel.revealp2 == true {
                HStack {
                    StatText(icon: "person.fill", value: viewModel.popularity, change: viewModel.popularity-35, label: "%", title: "Popularity", color: .orange, appearValue: animationModel.revealp2)
                    Spacer()
                    VStack(alignment: .trailing) {
                        if viewModel.popularity <= 25 {
                            Text("You will almost certainly not be appointed again, and some of your changes could be reversed.")
                        } else
                        if viewModel.popularity > 25 && viewModel.popularity < 35 {
                            Text("Your popularity has been made incredibly fragile.")
                        } else
                        if viewModel.popularity == 35 {
                            Text("Your popularity is unchanged, neither improving or worsening.")
                        } else
                        if viewModel.popularity > 35 && viewModel.popularity <= 40 {
                            Text("Your popularity is getting slightly better")
                        } else
                        if viewModel.popularity > 40 && viewModel.popularity <= 45 {
                            Text("Your popularity is currently at a healthy level.")
                        } else
                        if viewModel.popularity > 45 && viewModel.popularity <= 50 {
                            Text("Your popularity is very good. Well done.")
                        } else
                        if viewModel.popularity > 50 {
                            Text("Your popularity is at an incredible height!")
                        }
                    }
                    .multilineTextAlignment(.trailing)
                    .frame(width: 290.0)
                    .font(.system(size: 20)).bold()
                    .foregroundColor(.orange)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            if animationModel.revealp3 == true {
                HStack {
                    StatText(icon: "smoke.fill", value: viewModel.emmisions, change: 96-viewModel.emmisions, label: "%", title: "Emmisions Urgency", color: .red, appearValue: animationModel.revealp3)
                    Commentary(value: viewModel.emmisions, initialValue: 96, color: .red)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            if animationModel.revealp4 == true {
                HStack {
                    StatText(icon: "drop.fill", value: viewModel.waterShortage, change: 75-viewModel.waterShortage, label: "%", title: "Water Urgency", color: .blue, appearValue: animationModel.revealp4)
                    Commentary(value: viewModel.waterShortage, initialValue: 75, color: .blue)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            if animationModel.revealp5 == true {
                HStack {
                    StatText(icon: "wind.circle.fill", value: viewModel.airPollution, change: 68-viewModel.airPollution, label: "%", title: "Pollution Urgency", color: .brown, appearValue: animationModel.revealp5)
                    Commentary(value: viewModel.airPollution, initialValue: 68, color: .brown)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            if animationModel.revealp6 == true {
                Spacer()
                Text("Progress always comes with tradeoffs. You advanced \(viewModel.findMost()) the most but had to sacrifice \(viewModel.findLeast()).").bold()
                    .font(.system(size: 22))
                    .multilineTextAlignment(.center)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                Button {
                    viewModel.restart()
                    dismiss()
                } label: {
                    Text("Try It Again")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 20))
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .tint(.blue)
                        )
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onAppear {
            animationModel.revealAll()
        }
        .padding(50.0)
    }
    struct StatText: View {
        var icon: String
        var value: Double
        var change: Double
        var label: String
        var title: String
        var color: Color
        var appearValue: Bool
        @State var bounce = false

        var body: some View {
            VStack {
                HStack {
                    Image(systemName: icon)
                        .symbolEffect(.bounce, value: bounce)
                        .font(.system(size: 65))
                        .frame(width: 50.0, height: 50.0)
                        .padding(.trailing, 40.0)
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.system(size: 23)).bold()
                        Text("\(forTrailingZero(value))\(label)")
                            .foregroundColor(color)
                            .font(.system(size: 50))
                            .bold()
                        Text("\(forTrailingZero(change))\(label) change")
                            .font(.system(size: 20)).bold()
                    }
                    .padding(.leading)
                }
                .foregroundColor(color)
                .padding(.bottom, 10.0)
            }
            .task {
                if appearValue == true {
                    bounce = true
                }
            }
        }
        func forTrailingZero(_ temp: Double) -> String {
            let tempVar = String(format: "%g", temp)
            return tempVar
        }
    }
    
    struct Commentary: View {
        var value: Double
        var initialValue: Double
        var color: Color
        
        var body: some View {
            Spacer()
            VStack(alignment: .trailing) {
                if initialValue-value < 0 {
                    Text("This issue is now worse than when you started.")
                } else
                if initialValue-value == 0 {
                    Text("You made no progress on this issue.")
                } else
                if initialValue-value < 10 && value > 0 {
                    Text("You made very little progress on this issue.")
                } else
                if initialValue-value < 20 && value >= 10 {
                    Text("While not huge strides, you made good progress on this front.")
                } else
                if initialValue - value < 30 && value >= 20 {
                    Text("You made very sizable changes to this issue.")
                } else
                if initialValue - value >= 30 {
                    Text("You made incredible breakthroughs on this subject!")
                }
            }
            .multilineTextAlignment(.trailing)
            .frame(width: 350, height: 100)
            .font(.system(size: 20)).bold()
            .foregroundColor(color)
        }
    }
}
