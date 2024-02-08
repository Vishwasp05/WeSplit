//
//  ContentView.swift
//  WeSplit
//
//  Created by Vishwas Sharma on 07/02/24.
//

import SwiftUI //this tells Xcode to import the entire SWIFTUI library into the file

struct ContentView: View {
  
  @State private var totalBillAmount = 0.0
  @State private var noOfPeople = 2
  @State private var percentageTip = 10
  @FocusState private var amountIsFocused: Bool
  
  
  let tipPercentages = [0, 10,15,20,25]
  
  var totalPerPerson: Double {
    let peopleCount = Double(noOfPeople + 2)
    let tipSelection = Double(percentageTip)
    
    
    let tipValue = totalBillAmount / 100.0 * Double(percentageTip)
    let grandTotal = totalBillAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount
    
    return amountPerPerson
  }
  var body: some View {
    NavigationStack {
      Form {
        Section {
          Text("Amount")
          TextField("Amount ", value: $totalBillAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
          Picker("No of People", selection: $noOfPeople){
            ForEach(2..<100) {
              Text("\($0) people")
            }
            
          }
          
          
        }
        
        Section("Tips, if any :)"){
          
          Picker("% Tip, if any", selection: $percentageTip) {
            ForEach(tipPercentages, id: \.self) {
              Text($0, format: .percent)
            }
            
        }
        .pickerStyle(.segmented)
        
        
        
        }
        
        
        Section("Total Bill Amount: ") {
          Text("Your total bill amounts to \(totalPerPerson)")
        }
                
      }.navigationTitle("WeSplit")
        .toolbar {
          if amountIsFocused {
            Button("Done") {
              amountIsFocused = false
            }
          }
        }
    }
    
  }
}

//just there for Xcode to preview the code we've written above
#Preview {
  ContentView()
}
