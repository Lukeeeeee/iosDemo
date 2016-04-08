//
//  CalculatorBrain.swift
//  CalculatorSelfWriting
//
//  Created by 董林森 on 16/2/11.
//  Copyright © 2016年 Luke. All rights reserved.
//

import Foundation

class CalculatorBrain { //Model
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()

    
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
     init() {
        knownOps["+"] = Op.BinaryOperation("+") { $0 + $1 }
        knownOps["−"] = Op.BinaryOperation("−") { $1 - $0}
        knownOps["×"] = Op.BinaryOperation("×") { $0 * $1}
        knownOps["÷"] = Op.BinaryOperation("÷") { $1 / $0}
        knownOps["√"] = Op.UnaryOperation("√") { sqrt($0) }
    }
    private func evaluate(ops: [Op]) -> (result: Double?, remaingOps: [Op]){
        if !ops.isEmpty {
            var remaindOps = ops
            let op = remaindOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remaindOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remaindOps)
                if let operand = operandEvaluation.result{
                    return (operation(operand), operandEvaluation.remaingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1 = evaluate(remaindOps)
                if let op1Evaluation = op1.result {
                    let op2 = evaluate(op1.remaingOps)
                    if let op2Evaluation = op2.result {
                        return (operation(op1Evaluation, op2Evaluation), op2.remaingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(opStack)
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperator(symbol: String) ->Double? {
        if let operand = knownOps[symbol] {
            opStack.append(operand)
        }
        return evaluate()
    }
    
}
