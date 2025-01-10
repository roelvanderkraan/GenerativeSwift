//
//  GenerativeApp.swift
//  Generative
//
//  Created by Roel van der Kraan on 04/01/2025.
//

import SwiftUI

@main
struct GenerativeApp: App {
    var body: some Scene {
        WindowGroup {
            Genuary10(increaseTau: Double.pi * 2)
        }
    }
}
