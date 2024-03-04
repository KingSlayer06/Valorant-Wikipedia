//
//  AboutView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 04/03/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                KeyVariables.secondaryColor
                
                VStack(spacing: 10) {
                    Image("app-icon")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(spacing: 5) {
                        Text("Valorant Wikipedia")
                            .font(Font.custom(KeyVariables.primaryFont, size: 17))
                        
                        Text("Wikipedia for Valorant")
                            .font(Font.custom(KeyVariables.primaryFont, size: 12))
                            .opacity(0.5)
                    }
                    .padding(.bottom, 10)
                    
                    Group {
                        Text("Valorant Wikipedia")
                            .foregroundStyle(KeyVariables.primaryColor)
                        +
                        Text(" is just an informative App and not endorsed by Riot Games in any way.")
                    }
                    .font(Font.custom(KeyVariables.primaryFont, size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Riot Games, Valorant, and all associated properties are trademarks or registered trademarks of Riot Games, Inc.")
                        .font(Font.custom(KeyVariables.primaryFont, size: 15))
                    
                    VStack(spacing: 5) {
                        Text("Contact")
                            .foregroundStyle(KeyVariables.primaryColor)
                            .font(Font.custom(KeyVariables.primaryFont, size: 17))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)
                        
                        Text("contact.valorant.wiki@gmail.com")
                            .font(.headline.bold())
                            .accentColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                EmailController.shared.sendEmail(subject: "", body: "")
                            }
                    }
                    
                    VStack(spacing: 5) {
                        Text("Other Links")
                            .foregroundStyle(KeyVariables.primaryColor)
                            .font(Font.custom(KeyVariables.primaryFont, size: 17))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)
                        
                        HStack {
                            Image("github-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 13, height: 13)
                                .background {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 15, height: 15)
                                }
                                .clipShape(Circle())
                            
                            Text("Github")
                                .font(Font.custom(KeyVariables.primaryFont, size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    openUrl(url: "https://github.com/KingSlayer06")
                                }
                        }
                        
                        HStack {
                            Image("linkedin-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                            
                            Text("LinkedIn")
                                .font(Font.custom(KeyVariables.primaryFont, size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    openUrl(url: "https://www.linkedin.com/in/himanshu-sherkar/")
                                }
                        }
                        
                        HStack {
                            Image("twitter-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.white)
                                        .frame(width: 15, height: 15)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            Text("Twitter")
                                .font(Font.custom(KeyVariables.primaryFont, size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    openUrl(url: "https://twitter.com/KingSlayer0826")
                                }
                        }
                    }
                }
                .padding()
            }
        }
        .overlay(alignment: .bottom) {
            VStack {
                Text(KeyVariables.appVersion)
                    .font(Font.custom(KeyVariables.primaryFont, size: 12))
                    .opacity(0.5)
                
                Text("© KingSlayer06")
                    .font(Font.custom(KeyVariables.primaryFont, size: 12))
                    .opacity(0.5)
            }
            .padding(.bottom, 20)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                withAnimation(.easeInOut(duration: 3)) {
                    Text("About")
                        .font(Font.custom(KeyVariables.primaryFont, size: 20))
                        .foregroundStyle(.foreground)
                }
            }
        }
    }
    
    func openUrl(url: String) {
        if let url = URL(string: url) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

#Preview {
    AboutView()
}
