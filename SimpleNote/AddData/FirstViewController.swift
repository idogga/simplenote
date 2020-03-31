//
//  FirstViewController.swift
//  SimpleNote
//
//  Created by Admin on 12/02/2020.
//  Copyright © 2020 tap. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var nameErrorLbl: UILabel!
    @IBOutlet weak var lenghtText: UITextField!
    
    @IBOutlet weak var lenghtErrorLbl: UILabel!
    @IBOutlet weak var loadingBtn: LoadButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var ageErrorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingBtn.indicator = BallPulseIndicator()
        loadingBtn.bgColor = .white
        loadingBtn.addTarget(self, action: #selector(tapBtn(_:)), for: .touchUpInside)
        lenghtText.delegate=self
        nameText.delegate=self
        datePicker.locale=Locale.init(identifier: "ru")
        datePicker.addTarget(self, action: #selector(ageChanged(picker:)), for: .valueChanged)
        datePicker.maximumDate=Date()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(onOpenKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        bottomConstraint.constant=view.safeAreaInsets.bottom
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func onOpenKeyboard(notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            bottomConstraint.constant=keyboardHeight
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func onHideKeyboard(notification: Notification){
        bottomConstraint.constant = view.safeAreaInsets.bottom
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc private func tapBtn(_ sender: LoadButton){
        if(sender.isLoading) {
            sender.hideLoader()
        }
        else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let validator=Validator()
            if(!checkResult(result: validator.validateAge(dateOfBirth: datePicker.date))){
                sender.hideLoader()
                return;
            }
            
            if(!checkResult(result: validator.validateLenght(lengthStr: lenghtText.text!))) {
                sender.hideLoader()
                return;
            }
            if(!checkResult(result: validator.validateName(baseName: nameText.text!))) {
                sender.hideLoader()
                return;
            }
            
            sender.showLoader(userInteraction: true)
            let person = Person(context: context);
            person.lenght = Double(lenghtText.text!)!
            person.name = nameText.text
            person.age = datePicker.date
            
            context.insert(person)
            do {
                try context.save()
            }
            catch{
                showAlert(description: error.localizedDescription)
            }
            clear()
            sender.hideLoader()
        }
    }
    
    @IBAction func namePrimaryAction(_ sender: Any) {
        lenghtText.becomeFirstResponder()
    }
    
    @IBAction func nameEditingChanged(_ sender: Any) {
        let validator=Validator()
        let validateStr=validator.validateName(baseName: nameText.text!)
        nameErrorLbl.text=validateStr
        loadingBtn.isEnabled=checkErrors()
}
    
    @IBAction func lenghtChanged(_ sender: Any) {
        let validator=Validator()
        let validateStr=validator.validateLenght(lengthStr: (sender as! UITextField).text!)
        lenghtErrorLbl.text=validateStr
        loadingBtn.isEnabled=checkErrors()
}
    
    @objc func ageChanged(picker: UIDatePicker) {
        let validator=Validator()
        let validateStr=validator.validateAge(dateOfBirth:  picker.date)
        ageErrorLbl.text=validateStr
        loadingBtn.isEnabled=checkErrors()
}
    
    private func checkResult(result:String) -> Bool {
        if(!result.isEmpty) {
            showAlert(description: result)
            return false
        }
        return true
    }
    
    private func showAlert(description:String){
        let alert = UIAlertController(title: "Внимание", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Щас исправлю", style: .cancel, handler: {action in self.clear()}))
        self.present(alert, animated: true, completion: clear)
    }
    
    private func clear(){
        nameText.text=""
        lenghtText.text=""
        datePicker.date=Date()
    }
    
    private func checkErrors()->Bool{
        return (nameErrorLbl.text?.isEmpty ?? true)
            && (lenghtErrorLbl.text?.isEmpty ?? true)
            && (ageErrorLbl.text?.isEmpty ?? true)
    }
}
