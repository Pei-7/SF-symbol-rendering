//
//  ViewController.swift
//  SF symbol and swich color
//
//  Created by 陳佩琪 on 2023/6/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet var sfSymbolImageView: UIImageView!
    
    @IBOutlet var renderingSegmentedControl: UISegmentedControl!
    
    @IBOutlet var colorSegmentControl: UISegmentedControl!
    
    
    @IBOutlet var colorSliders: [UISlider]!
    
    
    @IBOutlet var redSlider: UISlider!
    
    @IBOutlet var greenSlider: UISlider!
    
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValue: UILabel!
    
    @IBOutlet var greenValue: UILabel!
    
    @IBOutlet var blueValue: UILabel!
    
    
    @IBOutlet var levelLabel: UILabel!
    
    @IBOutlet var levelSlider: UISlider!
    
    @IBOutlet var levelValue: UILabel!
    
    @IBOutlet var randomButton: UIButton!
    
    var color1 = UIColor.systemBlue
    var color2 = UIColor.systemBlue
    
    var red1 = 0
    var green1 = 122
    var blue1 = 255
    var red2 = 0
    var green2 = 122
    var blue2 = 255
    
    var levelVariableValue = 1.0
    
    var hierConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .systemBlue)
    var paletteConfiguration = UIImage.SymbolConfiguration(paletteColors: [.systemBlue,.systemBlue,.systemBlue])
    var multiColorConfiguration = UIImage.SymbolConfiguration.preferringMulticolor()
    
    
    let sfSymbolsName = ["cloud.sun.fill","externaldrive.fill.badge.wifi","chart.bar.doc.horizontal.fill"]
    var index = 0
    
    var segmentedIndex = 0
    
    var sfSymbolImage = UIImage()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let systemBlue = [0,122,255]
        
        for (index, slider) in colorSliders.enumerated() {
            slider.minimumValue = 0
            slider.maximumValue = 255
            slider.value = Float(systemBlue[index])
        }
        
        
        levelSlider.minimumValue = 0
        levelSlider.maximumValue = 1
        levelSlider.value = 1
        
        
        hierConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: color1)
        paletteConfiguration = UIImage.SymbolConfiguration(paletteColors: [color1,color2])

        sfSymbolImage = UIImage(systemName: sfSymbolsName[segmentedIndex])!
        
    
        sfSymbolImageView.image = sfSymbolImage

        colorSegmentControl.isHidden = true
        levelHidden(status: true)

        
    }
    
    
    func levelHidden(status: Bool) {
        levelLabel.isHidden = status
        levelValue.isHidden = status
        levelSlider.isHidden = status
    }

    @IBAction func changeSymbols(_ sender: Any) {
        segmentedIndex = segmentedControl.selectedSegmentIndex
        
        if segmentedControl.selectedSegmentIndex == 0 {
            levelHidden(status: true)
        } else {
            levelHidden(status: false)
        }

        updateImage()
        
    }
    
    
    fileprivate func updateImage() {
        if renderingSegmentedControl.selectedSegmentIndex == 0 {
            colorSegmentControl.isHidden = true
            mono()
            
        } else if renderingSegmentedControl.selectedSegmentIndex == 1 {
            colorSegmentControl.isHidden = true
            hier()
            
        } else if      renderingSegmentedControl.selectedSegmentIndex == 2 {
            colorSegmentControl.isHidden = false
            palette()
        } else {
            colorSegmentControl.isHidden = true
            multi()
        }
        sfSymbolImageView.image = sfSymbolImage
    }
    
    @IBAction func changeRenderSegment(_ sender: Any) {
        updateImage()
        returnToColor1()
    }
    
    
    
    
    fileprivate func mono() {
        //mono
        
        sfSymbolImage = UIImage(systemName: sfSymbolsName[segmentedIndex],variableValue: levelVariableValue)!
        sfSymbolImageView.tintColor = color1
    }
    
    fileprivate func hier() {
        //hier
        hierConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: color1)
        sfSymbolImage = UIImage(systemName: sfSymbolsName[segmentedIndex],variableValue: levelVariableValue, configuration: hierConfiguration)!
    }
    
    fileprivate func palette() {
        //palette
        paletteConfiguration = UIImage.SymbolConfiguration(paletteColors: [color1,color2])
        
        sfSymbolImage = UIImage(systemName: sfSymbolsName[segmentedIndex],variableValue: levelVariableValue, configuration: paletteConfiguration)!
    }
    
    fileprivate func multi() {
        //multi
        sfSymbolImage = UIImage(systemName: sfSymbolsName[segmentedIndex], variableValue: levelVariableValue, configuration: multiColorConfiguration)!
        sfSymbolImageView.tintColor = color1
    }
    
    @IBAction func adjustColor(_ sender: Any) {
        
        levelVariableValue = Double(levelSlider.value)
        levelValue.text = String(format:"%.1f",levelVariableValue)
        
        
        if colorSegmentControl.selectedSegmentIndex == 0 {
            red1 = Int(colorSliders[0].value)
            green1 = Int(colorSliders[1].value)
            blue1 = Int(colorSliders[2].value)
        
            color1 = UIColor(red: CGFloat(red1)/255, green: CGFloat(green1)/255, blue: CGFloat(blue1)/255, alpha: 1)
            redValue.text = String(red1)
            greenValue.text = String(green1)
            blueValue.text = String(blue1)
        } else if colorSegmentControl.selectedSegmentIndex == 1 {
            red2 = Int(colorSliders[0].value)
            green2 = Int(colorSliders[1].value)
            blue2 = Int(colorSliders[2].value)
        
            
            color2 = UIColor(red: CGFloat(red2)/255, green: CGFloat(green2)/255, blue: CGFloat(blue2)/255, alpha: 1)
            redValue.text = String(red2)
            greenValue.text = String(green2)
            blueValue.text = String(blue2)
        }
        
        updateImage()
    }
    

    
    fileprivate func returnToColor1() {
        colorSegmentControl.selectedSegmentIndex = 0
        redSlider.setValue(Float(red1), animated: true)
        greenSlider.setValue(Float(green1), animated: true)
        blueSlider.setValue(Float(blue1), animated: true)
        redValue.text = String(red1)
        greenValue.text = String(green1)
        blueValue.text = String(blue1)
    }
    
    @IBAction func changeColorSegment(_ sender: Any) {
        if colorSegmentControl.selectedSegmentIndex == 0 {
            returnToColor1()
            
        } else if colorSegmentControl.selectedSegmentIndex == 1 {
            redSlider.setValue(Float(red2), animated: true)
            greenSlider.setValue(Float(green2), animated: true)
            blueSlider.setValue(Float(blue2), animated: true)
            redValue.text = String(red2)
            greenValue.text = String(green2)
            blueValue.text = String(blue2)
            
        }
    }
    
    
    @IBAction func randomColor(_ sender: Any) {

        red1 = Int.random(in: 0...255)
        green1 = Int.random(in: 0...255)
        blue1 = Int.random(in: 0...255)
        
        redSlider.setValue(Float(red1), animated: true)
        greenSlider.setValue(Float(green1), animated: true)
        blueSlider.setValue(Float(blue1), animated: true)
        
        redValue.text = String(red1)
        greenValue.text = String(green1)
        blueValue.text = String(blue1)

        color1 = UIColor(red: CGFloat(red1)/255, green: CGFloat(green1)/255, blue: CGFloat(blue1)/255, alpha: 1)
  
        red2 = Int.random(in: 0...255)
        green2 = Int.random(in: 0...255)
        blue2 = Int.random(in: 0...255)
        
        color2 = UIColor(red: CGFloat(red2)/255, green: CGFloat(green2)/255, blue: CGFloat(blue2)/255, alpha: 1)
        
        levelVariableValue = Double.random(in: 0...1)
        levelSlider.setValue(Float(levelVariableValue), animated: true)
        levelValue.text = String(format: "%.1f",levelVariableValue)
        
        updateImage()
    }
    

}

