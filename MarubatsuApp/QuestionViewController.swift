//
//  QuestionViewController.swift
//  MarubatsuApp
//
//  Created by 宮越大輝 on 2021/11/08.
//

import UIKit

class QuestionViewController: UIViewController {

    var questionArray: [[String: Any]] = []
    var inputAnswer = false
    
    @IBOutlet weak var questionText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "add") != nil{
            questionArray = userDefaults.object(forKey: "add") as! [[String: Any]]
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func answer(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            inputAnswer = false
        } else if sender.selectedSegmentIndex == 1 {
            inputAnswer = true
        } else {
            showAlert(message: "予期せぬエラーが発生しました")
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveQuestion(_ sender: Any) {
        if questionText.text == nil {
            showAlert(message: "問題文を入力してください")
        }
        
        let userDefault = UserDefaults.standard
        
        let question = ["question": questionText.text!, "answer": inputAnswer] as [String : Any]
        questionArray.append(question)
        userDefault.set(questionArray, forKey: "add")
        questionText.text = ""
    }
    
    @IBAction func deleteQuestion(_ sender: Any) {
        let userDefault = UserDefaults.standard
        
        userDefault.removeObject(forKey: "add")
        
        userDefault.set([], forKey: "add")
        
        showAlert(message: "問題を削除しました")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showAlert(message: String)  {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        
        alert.addAction(close)
        present(alert, animated: true)
    }
}
