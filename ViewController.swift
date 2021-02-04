//
//  ViewController.swift
//  MyToDoList
//
//  Created by Hidenori Shima on 2021/01/24.
//

import UIKit

//プロトコル追加
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    //テーブルに表示するデータの箱
    var todoList = [String]()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //データ読み込み
        if let storedTodoList = userDefaults.array(forKey: "todoList") as? [String] {
            todoList.append(contentsOf: storedTodoList)
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func addBtnAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Todo追加", message: "ToDoを入力してくだだい", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: nil)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction) in
            // processing  after tapping OK button
            if let textField = alertController.textFields? .first {
                self.todoList.insert(textField.text!, at: 0)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
                
                // 追加したTodoを保存
                self.userDefaults.set(self.todoList, forKey: "todoList")
            }
        }
        alertController.addAction(okAction)
        let cancellButton = UIAlertAction(title: "CANCELL", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancellButton)
        present(alertController, animated: true, completion: nil)
    }
    
    // セルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    //セルの中身を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        let todoTitle = todoList[indexPath.row]
        cell.textLabel?.text = todoTitle
        return cell
    }
    //セルの削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            // 削除した内容を保存
            userDefaults.set(todoList, forKey: "todoList")
        }
    }
}

