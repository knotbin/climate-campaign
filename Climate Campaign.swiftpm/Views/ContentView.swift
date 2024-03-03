
import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    @Binding var sheet: Bool
    
    var body: some View {
        VStack {
            NavigationStack {
                VStack(alignment: .leading) {
                    MetersView(viewModel: viewModel)
                    HStack {
                        Text("Current Policies")
                            .font(.system(size: 25))
                            .bold()
                        Spacer()
                        if (!viewModel.currentPolicies.isEmpty) {
                            EditButton().bold()
                                .padding(.trailing)
                        }
                        Button {
                            sheet = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                    
                    if (viewModel.currentPolicies.isEmpty) {
                        ContentUnavailableView(
                            "No Policies Yet",
                            systemImage: "paperclip",
                            description: Text("Choose from policies listed below to add one.")
                        )
                    } else {
                        List {
                            ForEach(viewModel.currentPolicies, id: \.name) { policy in
                                CurrentPolicyView(policy: policy, viewModel: viewModel)
                            }
                            .onDelete(perform: viewModel.delete)
                            .listRowBackground(Color.gray.opacity(0.1))
                        }
                        .scrollContentBackground(.hidden)
                        Text("Potential Policies")
                            .font(.system(size: 25))
                            .bold()
                        if viewModel.currentPolicies.count == viewModel.potentialPolicies.count {
                            Text("All policies have been applied.")
                        }
                    }
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.potentialPolicies, id: \.name) { policy in
                                if !viewModel.currentPolicies.contains(where: { $0.name == policy.name }) {
                                    PolicyButtonView(viewModel: viewModel, image: policy.image, policy: policy)
                                        .transition(.move(edge: .top).combined(with: .opacity))
                                        .scrollTransition(.animated.threshold(.visible(0.3))) { content, phase in
                                                        content
                                                            .opacity(phase.isIdentity ? 1 : 0)
                                                            .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                                            .blur(radius: phase.isIdentity ? 0 : 10)
                                                    }
                                }
                            }
                        }
                        .padding(.leading, 15.0)
                    }
                    .mask(LinearGradient(gradient: Gradient(colors: [.clear, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .clear]), startPoint: .leading, endPoint: .trailing))
                    .padding(.bottom)
                    HStack {
                        Spacer()
                        NavigationLink {
                            FinishedView(viewModel: viewModel)
                        } label: {
                            HStack {
                                Text("Finalize Policy Selections")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.system(size: 20))
                                    .padding(13.0)
                                    .background(
                                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                            .tint(.blue)
                                    )
                            }
                        }
                        .frame(width: 260)
                        .disabled(viewModel.currentPolicies.isEmpty)
                        Spacer()
                    }
                }
                .padding(10.0)
            }
            .tint(.blue)
        }
    }
}
