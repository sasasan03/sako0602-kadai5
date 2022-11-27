import SwiftUI

var alert = false


func calc(numText1: String, numText2: String) throws -> Double {
    let num1 = Double(numText1)
    let num2 = Double(numText2)
    
    guard let unwrappedNum1 = num1 else {
        alert = true
        print("num1は無効な数です")
        
        throw DivisionError.leftEmptyError
    }
    guard let unwrappedNum2 = num2 else {
        alert = true
        print("num2は無効な数です")
        throw DivisionError.rightEmptyError
    }
    
    guard num2 != 0 else {
        alert = true
        print("num2は0です")
        throw DivisionError.rightZeroError
    }
    print("すべてのguardを通りました")
    
    return unwrappedNum1 / unwrappedNum2
}

enum DivisionError: Error {
    case leftEmptyError
    case rightEmptyError
    case rightZeroError
    
    var divisionErrorType: String {
        switch self {
        case .leftEmptyError: return "左が空"
        case .rightEmptyError: return "右が空"
        case .rightZeroError: return "右が０"
        }
    }
}

var a = false
var b = false
var c = false

do {
    var total:Double = 0
    try total = calc(numText1: "9", numText2: "")
    print("計算結果は\(total)です")
    //キャストする意味とは？
    //error -> opt + クリック（型が見れる）-> error はErrorプロトコルになっている。 -> errorをDivisionErrorとして扱うためにキャストを行う。
} catch let error as DivisionError {
    //@State var alertText = ""をstructのスコープ内で宣言すると、書き換え易いためよくない。
    // ❌ alertText = error.divisionErrorType
    //ケースに分けて書く
    switch error {
    case .leftEmptyError:
        a = true
    case .rightEmptyError:
        b = true
    case .rightZeroError:
        c = true
    }
    print(error.divisionErrorType)
}

let divisionError = DivisionError.leftEmptyError
let leftEmpty = divisionError.divisionErrorType
let divisionErrorRight = DivisionError.rightEmptyError
let rightEmpty = divisionErrorRight.divisionErrorType

if a {
    print(leftEmpty)
}
if b {
    print(rightEmpty)
}
if c {
    print("c")
}



