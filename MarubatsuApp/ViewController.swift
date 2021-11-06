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
    
    let questions: [[String: Any]] = [
        [
            "question": "iPhoneアプリを開発する統合環境はZcodeである",
            "answer": false
        ],
        [
            "question": "Xcode画面の右側にはユーティリティーズがある",
            "answer": true
        ],
        [
            "question": "UILabelは文字列を表示する際に利用する",
            "answer": true
        ]
    ]
    
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
        let question = questions[currentQuestionNum]
        
        if let que = question["question"] as? String {
            questionLabel.text = que
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
    
}
