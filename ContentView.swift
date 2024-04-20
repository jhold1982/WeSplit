//
//  ContentView.swift
//  WeSplit
//
//  Created by Justin Hold on 7/27/22.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - PROPERTIES
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
	
	// shortcut for reducing currency modifier
	let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(
		code: Locale.current.currency?.identifier ?? "USD"
	)
	
	let tipPercentages: [Int] = [10, 15, 20, 25, 0]
	
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
	
    var totalPerPerson: Double {
        grandTotal / Double(numberOfPeople + 2)
    }
	
	// MARK: - VIEW BODY
    var body: some View {
		
		NavigationStack {
			
			Form {
				
				Section {
					TextField("Check Amount", value: $checkAmount, format: localCurrency)
						.keyboardType(.decimalPad)
						.focused($amountIsFocused)
					
					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(2..<100) {
							Text("\($0) people")
						}
					}
					.pickerStyle(.menu)
				}
				
				Section("Good Karma") {
					Picker("Tip Percentage", selection: $tipPercentage) {
						ForEach(0..<101) {
							Text($0, format: .percent)
						}
					}
					.pickerStyle(.menu)
				}
				
				Section("Total Amount") {
					Text(grandTotal, format: localCurrency)
						.foregroundColor(tipPercentage == 0 ? .red : .primary)
				}
				
				Section("Amount Per Person") {
					Text(totalPerPerson, format: localCurrency)
				}
			}
			.navigationTitle("WeSplit")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					Button("Done") {
					amountIsFocused = false
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



