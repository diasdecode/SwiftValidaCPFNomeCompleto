//
//  ExtensionString.swift
//  
//
//  Created by Lilian Chaves Dias.
//
//

import Foundation
extension String {
    var isFullName: Bool {
        let fullName = self.trimmingCharacters(in:.whitespacesAndNewlines).components(separatedBy: " ")
        guard fullName[0].characters.count > 2 else { return false }
        guard fullName.count > 1 else { return false }
        return true
    }
    
    var isValidCPF: Bool {
        let rawCPF = self.replacingOccurrences(of: ".", with: "").replacingOccurrences(of:"-", with: "").characters.filter{"0123456789".characters.contains($0)}
        if rawCPF.count == 11 && !self.isCPFCheated(rawCPF) {
            let digitTen = (Int(String(rawCPF[9])) ?? 0)
            let digitEleven = (Int(String(rawCPF[10])) ?? 0)
            var resultModuleOne: Int = 0, resultModuleTwo: Int = 0, realValue: Int = 0
            for index in 0...9 {
                realValue = (Int(String(rawCPF[index])) ?? 0)
                if index != 9   {
                    resultModuleOne += realValue * (10 - index)
                }
                resultModuleTwo += realValue * (11 - index)
            }
            resultModuleOne %= 11
            resultModuleOne = resultModuleOne < 2 ? 0 : 11-resultModuleOne
            
            resultModuleTwo %= 11
            resultModuleTwo = resultModuleTwo < 2 ? 0 : 11-resultModuleTwo
            
            if (resultModuleOne == digitTen && resultModuleTwo == digitEleven) { return true }
        }
        return false
    }
    
    private func isCPFCheated(_ rawCPF: [Character]) -> Bool {
        if rawCPF == [Character] (String(repeatElement("0", count: 11)).characters) || rawCPF == [Character] (String(repeatElement("1", count: 11)).characters) || rawCPF == [Character] (String(repeatElement("2", count: 11)).characters) || rawCPF == [Character] (String(repeatElement("3", count: 11)).characters) || rawCPF == [Character] (String(repeatElement("4", count: 11)).characters) || rawCPF == [Character] (String(repeatElement("5", count: 11)).characters) || rawCPF == [Character] (String(repeatElement("6", count: 11)).characters) || rawCPF == [Character] (String(repeatElement("7", count: 11)).characters) || rawCPF == [Character] (String(repeatElement("8", count: 11)).characters) || rawCPF == [Character] (String(repeatElement("9", count: 11)).characters) {
            return true
        }
        return false
    }
}
