//
//  SearchBarView.swift
//  JournalAppdinaibr
//
//  Created by dina alswailem on 02/05/1447 AH.

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var accent: Color

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white.opacity(0.7))
            TextField("Search", text: $text)
                .foregroundColor(.white)
                .tint(accent)
            Spacer(minLength: 0)
            Image(systemName: "mic.fill")
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial, in: Capsule())
        .overlay(Capsule().stroke(Color.white.opacity(0.08), lineWidth: 1))
        .padding(.horizontal, 16)
        .padding(.bottom, 30)
        .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 8)
    }
}

