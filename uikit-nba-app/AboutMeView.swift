//
//  AboutMeView.swift
//  uikit-nba-app
//
//  Created by Ikhsan on 31/08/2022.
//

import SwiftUI

struct AboutMeView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image(systemName: "person.fill")
                .font(.system(size: 30, weight: .medium, design: .default))
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(Color.indigo)
                .cornerRadius(50)
            Text("Ikhsan Haikal")
                .font(.largeTitle)
            Text("github.com/ikhsanhaikal")
                .font(.subheadline)
            Spacer()
        }
    }
}

struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        AboutMeView()
    }
}
