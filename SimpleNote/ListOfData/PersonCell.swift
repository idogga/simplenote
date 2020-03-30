//
//  PersonCell.swift
//  SimpleNote
//
//  Created by Admin on 16/03/2020.
//  Copyright © 2020 tap. All rights reserved.
//

import Foundation
import UIKit

class PersonCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// - parameter update : Обновить данные.
    func update(person: Person){
        nameLbl.text=person.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="dd.MM.yyyy"
        let years=person.age!.timeIntervalSinceNow / (-60*60*24*30*12)
        descriptionLbl.text="\(person.lenght)см  \(Int(round(years)))лет (\(dateFormatter.string(from: person.age!)))"
    }
}
