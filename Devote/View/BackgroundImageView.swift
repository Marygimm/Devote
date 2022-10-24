//
//  BackgroundImageVie.swift
//  Devote
//
//  Created by Mary Moreira on 24/10/2022.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

struct BackgroundImageVie_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}
