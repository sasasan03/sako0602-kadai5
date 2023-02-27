//
//  ContentView.swift
//  sako0602-kadai5
//
//  Created by sako0602 on 2022/11/08.


import SwiftUI

private enum DivisionError: Error {
    case leftEmptyError
    case rightEmptyError
    case rightZeroError
    var message: String {
        switch self {
        case .leftEmptyError: return "割られる数を入力してください"
        case .rightEmptyError: return "割る数を入力してください"
        case .rightZeroError: return "割る数に０を入力しないでください"
        }
    }
}

struct ContentView: View {
    
    @State private var showingAlert = false
    @State private var alertMessage = ""

    @State private var numText1 = ""
    @State private var numText2 = ""
    @State private var total:Double = 0

    var body: some View {
        
        VStack {
            HStack {
                TextField("", text: $numText1)
                    .frame(width: 50, height: 30)
                    .border(Color.black)
                    .padding()
                Text("÷")
                TextField("", text: $numText2)
                    .frame(width: 50, height: 30)
                    .border(Color.black)
                    .padding()
            }
            Button("計算") {
                do {
                    try total = calc()
                } catch let error as DivisionError {
                    alertMessage = error.message
                    showingAlert = true
                } catch {
                    print("不明なエラー: \(error)")
                }
            }
            Text(String(format: "%.2f", total))
                .padding()
        }
        // https://developer.apple.com/documentation/swiftui/hstack/alert(_:ispresented:presenting:actions:message:)-agi7
        .alert(
            "課題５",
            isPresented: $showingAlert,
            presenting: alertMessage,
            actions: { _ in },
            message: { message in Text(message) }
        )
    }
    
    func calc () throws -> Double {
        //Optional型のnum1とnum2
        //アンラップしなければならない。guardでアンラップ
        let num1 = Double(numText1)
        let num2 = Double(numText2)
        
        guard let unwrappedNum1 = num1 else {
            throw DivisionError.leftEmptyError
        }
        guard let unwrappedNum2 = num2 else {
            throw DivisionError.rightEmptyError
        }
        guard num2 != 0 else {
            throw DivisionError.rightZeroError
        }
        return unwrappedNum1 / unwrappedNum2
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
