//
//  Validator.swift
//  SimpleNote
//
//  Created by Admin on 20/03/2020.
//  Copyright © 2020 tap. All rights reserved.
//

import Foundation

class Validator {
    
    /**
     Валидация возраста.
     - dateOfBirth: Дата рождения.
     */
    func validateAge(dateOfBirth:Date) -> String {
        let calendar=Calendar.current
        let component = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
        if(component.year! < 18) {
            return "Вы должны быть совершеннолетним."
        }
        return ""
    }
    
    /**
     Валидация имени.
    - lenghtStr: Строка с высотой
    */
    func validateName(baseName:String)->String {
        if(baseName.range(of: " ") == nil){
            return "Имя должно состоять из нескольких частей"
        }
        return "";
    }
    
    /**
     # Валидация роста.
     - lenghtStr: Строка с высотой
     */
    func validateLenght(lengthStr:String)->String{
        let double     = Double(lengthStr)
        if(double==nil) {
            return "Не является числом."
        }
        if(double! < 0) {
            return "Возраст дожен быть больше 0."
        }
        if(double! > 200) {
            return "Слишком большая высота."
        }
        return ""
    }
}
