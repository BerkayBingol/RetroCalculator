//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Berkay Bingol on 13/02/2018.
//  Copyright © 2018 Berkay Bingol. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValueStr = ""
    var rightValueStr = ""
    var result = ""
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        outputLabel.text = "0"
    }
    @IBAction func numberPressed(sender: UIButton)
    {
        playSound()
        runningNumber += "\(sender.tag)"
        //hangi rakam geliyorsa senderin tagini aliyor running numberia ekleyip labelin textini degistiriyor.
        
        outputLabel.text = runningNumber
        
    }
    @IBAction func onDividePressed(sender: AnyObject)
    {
        processOperation(operation: .Divide)
    }
    @IBAction func onMultipyPressed(sender: AnyObject)
    {
        processOperation(operation: .Multiply)

    }
    @IBAction func onSubtractPressed(sender: AnyObject)
    {
        processOperation(operation: .Subtract)

    }
    @IBAction func onAddPressed(sender: AnyObject)
    {
        processOperation(operation: .Add)

    }
    @IBAction func onEqualPressed(sender: AnyObject)
    {
        processOperation(operation: currentOperation)
        
    }
    func processOperation(operation: Operation)
    {
        if currentOperation != Operation.Empty{
            
            if runningNumber != ""{
                rightValueStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueStr)! * Double(rightValueStr)!)"
                }
                else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValueStr)! / Double(rightValueStr)!)"
                }
                else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValueStr)! - Double(rightValueStr)!)"
                }
                else if currentOperation == Operation.Add{
                    result = "\(Double(leftValueStr)! + Double(rightValueStr)!)"
                }
                leftValueStr = result
                outputLabel.text = result
                
            }
            currentOperation = operation
        }
        else {
            leftValueStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
   func playSound()
   {
    if btnSound.isPlaying {
        btnSound.stop()
    }
    btnSound.play()
    }


}

