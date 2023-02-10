//
//  ContentView.swift
//  LOTR Converter
//
//  Created by Oscar David Myerston Vega on 10/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var leftApple = ""
    @State var rightApple = ""
    @State var leftAmountTemp = ""
    @State var rightAmountTemp = ""
    @State var leftTyping = false
    @State var rightTyping = false
    @State var leftCurrency: Currency = .silverPiece
    @State var rightCurrency: Currency = .goldPiece
    @State var showSelectCurrency = false
    @State var showExchangeInfo = false
    
    var body: some View {
        ZStack {
            // Background image
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Prancing pony image
                Image("prancingpony")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // Currency exchange text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                // Currency conversion section
                HStack {
                    // Left conversion section
                    VStack {
                        // Currency
                        HStack {
                            // Currency image
                            Image(CurrencyImage.allCases[Currency.allCases.firstIndex(of: leftCurrency)!].rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            // Currency text
                            Text(CurrencyText.allCases[Currency.allCases.firstIndex(of: leftCurrency)!].rawValue)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .sheet(isPresented: $showSelectCurrency) {
                            SelectCurrency(leftCurrency: $leftCurrency, rightCurrency: $rightCurrency)
                        }
                        
                        // Text field
                        TextField("Amount", text: $leftApple, onEditingChanged: {
                            typing in
                            leftTyping = typing
                            leftAmountTemp = leftApple
                        })
                        .padding(7)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(7)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: leftTyping ? leftApple : leftAmountTemp) {
                            _ in
                            rightApple = leftCurrency.convert(amountString: leftApple, to: rightCurrency)
                        }
                        .onChange(of: leftCurrency) {
                            _ in
                            leftApple = rightCurrency.convert(amountString: rightApple, to: leftCurrency)
                        }
                    }
                    
                    // Equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    // Right conversion section
                    VStack {
                        // Currency
                        HStack {
                            // Currency text
                            Text(CurrencyText.allCases[Currency.allCases.firstIndex(of: rightCurrency)!].rawValue)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            // Currency image
                            Image(CurrencyImage.allCases[Currency.allCases.firstIndex(of: rightCurrency)!].rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .sheet(isPresented: $showSelectCurrency) {
                            SelectCurrency(leftCurrency: $leftCurrency, rightCurrency: $rightCurrency)
                        }
                        
                        .padding(.bottom, -5)
                        // Text field
                        TextField("Amount", text: $rightApple, onEditingChanged: {
                            typing in
                            rightTyping = typing
                            rightAmountTemp = rightApple
                        })
                        .padding(7)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(7)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .onChange(of: rightTyping ? rightApple : rightAmountTemp) {
                            _ in
                            leftApple = rightCurrency.convert(amountString: rightApple, to: leftCurrency)
                        }
                        .onChange(of: rightCurrency) {
                            _ in
                            rightApple = leftCurrency.convert(amountString: leftApple, to: rightCurrency)
                        }
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                // .cornerRadius(50)
                
                Spacer()
                
                // Info button
                HStack {
                    Spacer()
                    
                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                    }
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.trailing)
                    .sheet(isPresented: $showExchangeInfo) {
                        ExchangeInfo()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
