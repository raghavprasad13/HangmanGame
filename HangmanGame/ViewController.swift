//
//  ViewController.swift
//  HangmanGame
//
//  Created by Raghav Prasad on 14/10/17.
//  Copyright © 2017 Raghav. All rights reserved.
//

import UIKit

let words = ["RAGHAV", "PRASAD", "SWIFT", "METALLICA", "PATIENCE"]
let word = words[Int(arc4random_uniform(UInt32(words.count)))]
let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupViews(){
        let backImg = UIImageView()
        backImg.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backImg)
        backImg.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        backImg.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        backImg.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backImg.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backImg.image = #imageLiteral(resourceName: "Slide1.jpg")
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backImg.addSubview(backView)
        backView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        backView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backView.backgroundColor = UIColor.clear
        
        let skipButton = UIButton()
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(skipButton)
        skipButton.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -15).isActive = true
        skipButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 40).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(UIColor.blue, for: .normal)
        skipButton.isOpaque = true
        skipButton.backgroundColor = UIColor.lightText
        skipButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        skipButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        let hangmanImg = UIImageView()
        hangmanImg.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(hangmanImg)
        hangmanImg.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 75).isActive = true
        hangmanImg.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -75).isActive = true
        hangmanImg.topAnchor.constraint(equalTo: backView.topAnchor, constant: 120).isActive = true
        hangmanImg.heightAnchor.constraint(equalToConstant: 250).isActive = true
        hangmanImg.backgroundColor = UIColor.black
        
        let notification = UIImageView()
        notification.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(notification)
        notification.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 25).isActive = true
        notification.topAnchor.constraint(equalTo: skipButton.topAnchor).isActive = true
        notification.heightAnchor.constraint(equalTo: skipButton.heightAnchor).isActive = true
        notification.widthAnchor.constraint(equalTo: notification.heightAnchor).isActive = true
        notification.backgroundColor = UIColor.black
        
        
        let answerView = UIStackView()
        answerView.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(answerView)
        answerView.axis = .horizontal
        
        let width1 = hangmanImg.widthAnchor
        let width2 = backView.widthAnchor
        
        answerView.centerXAnchor.constraint(equalTo: hangmanImg.centerXAnchor).isActive = true
        answerView.topAnchor.constraint(equalTo: hangmanImg.bottomAnchor, constant: 70).isActive = true
        answerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        if word.count<=7 {
            answerView.widthAnchor.constraint(equalTo: width1).isActive = true
        }
            
        else{
            answerView.widthAnchor.constraint(equalTo: width2, constant: -20) .isActive = true
        }
        
        answerView.distribution = .fillEqually
        answerView.spacing = 10
        answerView.alignment = .center
        
        populateAnswerView(answerView: answerView)
        
        
        let optionView = UIStackView()
        optionView.translatesAutoresizingMaskIntoConstraints = false
        optionView.axis = .vertical
        backView.addSubview(optionView)
        
        optionView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -50).isActive = true
        optionView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 50).isActive = true
        optionView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -50).isActive = true
        optionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        optionView.distribution = .fillEqually
        optionView.spacing = 10
        optionView.alignment = .center
        
        let topOptions = UIStackView()
        topOptions.translatesAutoresizingMaskIntoConstraints = false
        topOptions.distribution = .fillEqually
        topOptions.alignment = .center
        topOptions.axis = .horizontal
        topOptions.spacing = 10
        let topButtons = populateOptionView(optionView: topOptions)
        
        let bottomOptions = UIStackView()
        bottomOptions.translatesAutoresizingMaskIntoConstraints = false
        bottomOptions.distribution = .fillEqually
        bottomOptions.alignment = .center
        bottomOptions.axis = .horizontal
        bottomOptions.spacing = 10
        let bottomButtons = populateOptionView(optionView: bottomOptions)
        
        let allButtons = topButtons + bottomButtons
        
        putLetters(buttons: allButtons)
        
        var correctButtons = [UIButton]()
        
        for x in allButtons{
            if word.characters.contains(Character((x.titleLabel?.text)!)){
                correctButtons.append(x)
            }
        }
        
        
        optionView.addArrangedSubview(topOptions)
        optionView.addArrangedSubview(bottomOptions)
        
    }
    
    @IBAction func buttonPressed(){
        print("hello")
        
    }
    
    func populateAnswerView(answerView: UIStackView) {
        let wordLetters = Array(word)
        
        let view = answerView
        
        for x in wordLetters {
            view.addArrangedSubview(createLabel(view: view, text: String(x)))
        }
        
    }
    
    func populateOptionView(optionView: UIStackView) -> [UIButton] {
        var buttons = [UIButton]()
        var counter = 0
        
        while counter<6{
            let button = UIButton()
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
            button.backgroundColor = UIColor.blue
            //button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            optionView.addArrangedSubview(button)
            buttons.append(button)
            counter+=1
        }
        
        return buttons
    }
    
    func createLabel(view: UIView, text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        label.text = text
        label.backgroundColor = UIColor.blue
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }
    
    func putLetters(buttons: [UIButton]) {
        var indices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        var answer_letters = Array(word)
        
        var correctButtons = [UIButton]()
        
        var rand_button: Int
        var rand_letter: Int
        
        
        while !answer_letters.isEmpty {
            rand_button = Int(arc4random_uniform(UInt32(indices.count)))
            rand_letter = Int(arc4random_uniform(UInt32(answer_letters.count)))
            buttons[indices[rand_button]].setTitle(String(answer_letters[rand_letter]).uppercased(), for: .normal)
            buttons[indices[rand_button]].setTitleColor(UIColor.white, for: .normal)
            correctButtons.append(buttons[indices[rand_button]])
            indices.remove(at: rand_button)
            answer_letters.remove(at: rand_letter)
        }
        
        var other_letters = Array(letters)
        
        
        while !indices.isEmpty {
            rand_button = Int(arc4random_uniform(UInt32(indices.count)))
            rand_letter = Int(arc4random_uniform(UInt32(other_letters.count)))
            buttons[indices[rand_button]].setTitle(String(other_letters[rand_letter]).uppercased(), for: .normal)
            buttons[indices[rand_button]].setTitleColor(UIColor.white, for: .normal)
            indices.remove(at: rand_button)
            other_letters.remove(at: rand_letter)
        }

    }
    
}
