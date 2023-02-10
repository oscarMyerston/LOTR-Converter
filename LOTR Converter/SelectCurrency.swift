//
//  SelectCurrency.swift
//  LOTR Converter
//
//  Created by Oscar David Myerston Vega on 10/02/23.
//

import SwiftUI

struct SelectCurrency: View {
    @State var gridLayout = [GridItem(), GridItem(), GridItem()]
    @Binding var leftCurrency: Currency
    @Binding var rightCurrency: Currency
    @Environment(\.dismiss) var Dismiss
    
    var body: some View {
        ZStack {
            // Bckground parchment image
            Image("parchment")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .background(.brown)
            
            VStack {
                // Text
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                // Currency icons
                IconGrid(currency: $leftCurrency)
                
                // Text
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                // Currency icons
                IconGrid(currency: $rightCurrency)
                
                // Done button
                Button("Done") {
                    Dismiss()
                }
                .font(.largeTitle)
                .padding(10)
                .foregroundColor(.white)
                .background(.brown)
                .cornerRadius(15)
            }
        }
    }
}

struct SelectCurrency_Previews: PreviewProvider {
    static var previews: some View {
        SelectCurrency(leftCurrency: .constant(.silverPiece), rightCurrency: .constant(.goldPiece))
    }
}
