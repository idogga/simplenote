//
//  SimpleNoteTests.swift
//  SimpleNoteTests
//
//  Created by Admin on 30/03/2020.
//  Copyright © 2020 tap. All rights reserved.
//

import XCTest
@testable import Hello_World_

class SimpleNoteTests: XCTestCase {
    var _validator:Validator?

    override func setUp() {
        _validator = Validator.init()
    }

    func testSuccesName() {
        let s = _validator!.validateName(baseName: "test test")
        XCTAssertTrue(s.isEmpty, "Сообщение дожно быть пустым")
    }
    
    func testSuccesAge() {
        var dateComponent=DateComponents()
        dateComponent.year=2000
        dateComponent.month=1
        let calendar=Calendar.current
        let date=calendar.date(from: dateComponent)
        let s = _validator!.validateAge(dateOfBirth: date!)
        XCTAssertTrue(s.isEmpty, "Сообщение дожно быть пустым")
    }
    
    func testUnsuccesName(){
        let expect="Имя должно состоять из нескольких частей"
        let s = _validator!.validateName(baseName: "test")
        XCTAssertEqual(s, expect)
    }
    
    func testSuccesLenght() {
        let s = _validator!.validateLenght(lengthStr: "190")
        XCTAssertTrue(s.isEmpty, "Сообщение дожно быть пустым")
    }
    
    func testUnsuccesLenghtNotNumber() {
        let expect="Не является числом."
        let s = _validator!.validateLenght(lengthStr: "adsadadsad")
        XCTAssertEqual(s, expect)
    }
    
    func testUnsuccesLenghtLess(){
        let expect="Возраст дожен быть больше 0."
        let s = _validator!.validateLenght(lengthStr: "-1")
        XCTAssertEqual(s, expect)
    }
    
    func testUnsuccesLenghtMore(){
        let expect="Слишком большая высота."
        let s = _validator!.validateLenght(lengthStr: "201")
        XCTAssertEqual(s, expect)
    }
}
