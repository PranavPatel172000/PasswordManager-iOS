//
//  IconImageView.swift
//  PasswordManager
//
//  Created by pranavashok.patel on 03/01/26.
//

import SwiftUI

struct IconImageView: View {
    var height: CGFloat = 45
    var width: CGFloat = 45
    var icon: String = "?"
    
    var body: some View {
        Text(icon)
            .font(.system(size: 30, weight: .bold))
            .frame(width: width, height: height)
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(.systemGray))
            )
    }
}

#Preview {
    IconImageView()
}
