//
//  BaseTopRightBadges.swift
//  PracticalSwiftUI
//
//  Created by Lysimachos Giatrakis on 9/12/21.
//

import Foundation
import SwiftUI

struct BaseTopRightBadges: View {

    var body: some View {
        return
            HStack(spacing: 24) {
                Button(action: {
                    // TODO
                }) {
                    ZStack {
                        Image("chat-icon")
                        BadgeCircle(badgeValue: "1")
                    }
                }
                Button(action: {
                    // TODO
                }) {
                    ZStack {
                        Image("share-icon")
                        BadgeCircle(badgeValue: "2")
                    }
                }
            }.padding(8)
    }

    
}

struct BadgeCircle: View {
    
    var badgeValue: String
    
    var body: some View {
        Group {
            Capsule()
                .fill(Color.ui.primaryGreen)
            
            Text((badgeValue))
                .foregroundColor(Color.white)
        }.frame(width: 20, height: 20)
            .offset(x: 12, y: -11)
    }
    
}


struct NavTopRightBadges_Previews: PreviewProvider {
    static var previews: some View {
        return BaseTopRightBadges()
    }
}