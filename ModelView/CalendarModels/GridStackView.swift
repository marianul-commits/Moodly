//
//  GridStackView.swift
//  Moodly
//
//  Created by Marian Nasturica on 28.07.2024.
//

import SwiftUI

struct GridStackView<Content: View>: View {

    let rows: Int
    let cols: Int
    let content: (Int, Int) -> Content

    var body: some View {

        VStack {
            ForEach(0..<self.rows) { row in
                HStack {
                    ForEach(0..<self.cols) { col in
                        Spacer()
                        self.content(row, col)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                        Spacer()
                    }
                }

            }
        }
    }


    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.cols = columns
        self.content = content
    }

}

#Preview {
    GridStackView(rows: 5, columns: 7) { row, col in
        Text("1")
    }
}
