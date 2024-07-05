//
//  ContentView.swift
//  WeSplit
//
//  Created by Pratyusha Joginipally on 6/27/24.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = 0.0
  @FocusState private var amountIsFocused: Bool
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 20
  let tipPercentages = [10, 15, 20, 25, 0]

  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentage)

    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount

    return amountPerPerson
  }

  // Challenge 2 solution
  var grandTotal: Double {
    let tipSelection = Double(tipPercentage)

    let tipValue = checkAmount / 100 * tipSelection
    return checkAmount + tipValue
  }

  var body: some View {
    NavigationView {

      NavigationStack {
        Form {
          Section {
            TextField("Enter Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD") )
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)

            Picker("Number of people", selection: $numberOfPeople) {
              ForEach(2..<100) {
                Text("\($0) people")
              }
            }
          }

//          Section("How much tip do you want to leave?") {
//              Picker("Tip percentage", selection: $tipPercentage) {
//                  ForEach(tipPercentages, id: \.self) {
//                      Text($0, format: .percent)
//                  }
//              }
//              .pickerStyle(.segmented)
//          }

          // Challenge 3 solution
          Section("How much tip do you want to leave?") {
              Picker("Tip percentage", selection: $tipPercentage) {
                ForEach(0..<101) {
                      Text($0, format: .percent)
                  }
              }
              .pickerStyle(.navigationLink)
          }

          // Challenge 2 solution
          Section("Grand total") {
            Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
          }

          // Challenge 1 solution
          Section("Amount per person") {
            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
          }
        }
        .navigationTitle("WeSplit")
        .toolbar {
            if amountIsFocused {
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
