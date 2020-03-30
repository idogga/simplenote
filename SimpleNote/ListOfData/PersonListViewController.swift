//
//  PersonListViewController.swift
//  SimpleNote
//
//  Created by Admin on 16/03/2020.
//  Copyright © 2020 tap. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PersonListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var persons = [Person]()
    var img = UIImageView.fromGif(frame: CGRect(x: 0, y: 0, width: 300, height: 300), resourceName: "nonData")
    @IBOutlet weak var personTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personTable.dataSource=self
        personTable.delegate=self
        personTable.tableFooterView=UIView()
        
        let x=(view.frame.width - img!.frame.width) / 2
        let y=(view.frame.height - img!.frame.height) / 2
        img?.frame=CGRect(x: x, y: y, width: img!.frame.width, height: img!.frame.height)
        view.addSubview(img!)
        img!.isHidden=true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
        personTable.reloadData()
    }
    
    /// - parameter reloadData: Обновление данных
    private func reloadData()-> Void{
        persons.removeAll()
        let fetchedRequest = NSFetchRequest<Person>(entityName: "Person")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do{
            let results = try context.fetch(fetchedRequest)
            if results.isEmpty{
                hideTable()
                return
            }
            showTable()
            for result in results {
                persons.append(result)
            }
        }
        catch{
            print(error)
        }
    }
    
    /// - parameter hideTable : Скрыть данные.
    private func hideTable(){
        personTable.isHidden=true
        
        img!.startAnimating()
        img?.isHidden=false
    }
    
    /// - parameter showTable : Показ данных.
    private func showTable(){
        personTable.isHidden=false
        img!.stopAnimating()
        img?.isHidden=true
    }
    
    // MARK: - TableView делегат
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(persons[indexPath.row])
            try? context.save()
            reloadData()
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "personCell") as! PersonCell
        let person = persons[indexPath.row]
        cell.update(person: person)
        return cell
    }
}

// MARK: - UIImageView
extension UIImageView{
    /// Загрузить GIF-анимацию.
    /// - Parameters:
    ///   - frame: Рамка для отрисовки.
    ///   - resourceName: Путь к ресурсу.
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
            let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
    
}
