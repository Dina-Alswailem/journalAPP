//
//  Panel.swift
//  JournalAppdinaibr
//
//  Created by dina alswailem on 02/05/1447 AH.
//
import SwiftUI

struct Panel<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }

    var body: some View {
        ZStack {
            Color.black.opacity(0.85).ignoresSafeArea()
            VStack { content }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(Color(red: 24/255, green: 24/255, blue: 24/255))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                )
                .padding(.horizontal, 12)
                .padding(.top, 8)
                .padding(.bottom, 20)
                .ignoresSafeArea(.keyboard)
        }
    }
}

