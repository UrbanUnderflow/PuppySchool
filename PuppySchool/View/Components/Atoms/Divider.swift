//
//  Divider.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/25/23.
//

import SwiftUI

struct Divider: View {
    var color: Color
    var height: CGFloat
    
    var body: some View {
          HStack {
              Rectangle()
                  .fill(color)
                  .frame(height: 1)
          }
    }
}

struct Divider_Previews: PreviewProvider {
    static var previews: some View {
        Divider(color: .gray, height: 1)
    }
}
