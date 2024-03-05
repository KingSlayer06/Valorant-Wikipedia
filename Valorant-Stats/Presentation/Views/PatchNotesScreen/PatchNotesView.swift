//
//  PatchNotesView.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 04/03/24.
//

import SwiftUI

struct PatchNotesView: View {
    var body: some View {
        let url = URL(string: "https://playvalorant.com/en-us/news/tags/patch-notes/")!
        
        WebViewRepresentable(url: url)
            .onAppear {
                AppAnalytics.shared.ScreenVisit(screen: AppAnalytics.shared.patchNotesScreen)
            }
    }
}

#Preview {
    PatchNotesView()
}
