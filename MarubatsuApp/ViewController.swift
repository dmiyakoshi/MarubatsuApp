//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by 宮越大輝 on 2021/11/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestionNum: Int = 0
    
    var questions: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    
    @IBAction func tappedNoButton(_ sender: UIButton) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tappedYesButton(_ sender: UIButton) {
        checkAnswer(yourAnswer: true)
    }
    
    func showQuestion() {
        if questions.count != 0 {
            let question = questions[currentQuestionNum]
            
            if let que = question["question"] as? String {
                questionLabel.text = que
            }
        }else {
            questionLabel.text = "問題がありません、問題を作ってみましょう"
        }
    }
    
    func checkAnswer(yourAnswer: Bool)  {
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"] as? Bool {
            if yourAnswer == ans {
                //正解のとき 次の問題を表示
                currentQuestionNum += 1
                showAlert(message: "正解!")
            } else {
                //不正解のとき 何もしない
                showAlert(message: "不正解...")
            }
        } else {
            print("答えが入っていません")
            return
        }
        // out of range回避
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        //正解時は次の問題へ、不正解のときは同じ問題を表示
        showQuestion()
    }
    
    func showAlert(message: String)  {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        
        alert.addAction(close)
        present(alert, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: "add") != nil {
            questions = userDefaults.object(forKey: "add") as! [[String: Any]]
        }
        
        showQuestion()
    }
}
