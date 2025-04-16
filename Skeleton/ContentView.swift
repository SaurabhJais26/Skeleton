//
//  ContentView.swift
//  Skeleton
//
//  Created by Saurabh Jaiswal on 17/04/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoading: Bool = false
    @State private var card: Card?
    
    var body: some View {
        VStack {
            SomeCardView(card: card)
                .onTapGesture {
                    withAnimation(.smooth) {
                        if card == nil {
                            card = .init(title: "World Wide Developer Conference 2025", subTitle: "From June 9th 2025", image: "WWDC 2025", description: "Be there for the reveal of the latest Apple tools, frameworks, and features. Learn to elevate your apps and games through video sessions hosted by Apple engineers and designers.")
                        } else {
                            card = nil
                        }
                    }
                }
            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
}

struct Card: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var subTitle: String
    var image: String
    var description: String
}


struct SomeCardView: View {
    var card: Card?
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Rectangle()
                .foregroundStyle(.clear)
                .overlay {
                    if let card {
                        Image(card.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        SkeletonView(.rect)
                    }
                }
                .frame(height: 220)
                .clipped()
                
                VStack(alignment: .leading, spacing: 10) {
                    if let card {
                        Text(card.title)
                            .fontWeight(.semibold)
                    } else {
                        SkeletonView(.rect(cornerRadius: 5))
                            .frame(height: 20)
                    }
                    
                    Group {
                        if let card {
                            Text(card.subTitle)
                                .font(.callout)
                                .foregroundStyle(.secondary)
                        } else {
                            SkeletonView(.rect(cornerRadius: 5))
                                .frame(height: 15)
                        }
                    }
                    .padding(.trailing)
                    
                    ZStack {
                        if let card {
                            Text(card.description)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        } else {
                            SkeletonView(.rect(cornerRadius: 5))
                        }
                    }
                    .frame(height: 50)
                    .lineLimit(3)
                }
                .padding([.horizontal, .top], 15)
                .padding(.bottom, 25)
        }
        .background(.background)
        .clipShape(.rect(cornerRadius: 15))
        .shadow(color: .black.opacity(0.1), radius: 10)
        
    }
}

#Preview {
    ContentView()
}
