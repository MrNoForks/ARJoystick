//
//  ViewController.swift
//  ARJoystick
//
//  Created by Boppo on 06/05/19.
//  Copyright © 2019 Boppo. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView : ARSCNView!
    
    @IBOutlet weak var stackViewButton: UIStackView!
    
    private var virtualModelLoader = ModelLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.showsStatistics = true
        
        virtualModelLoader.loadModel(modelName: "UFO_A", positionX: 0, positionY: 0, positionZ: -0.7, modelSize: 0.05)
        
        sceneView.scene.rootNode.addChildNode(virtualModelLoader)
        
        view.bringSubviewToFront(stackViewButton)
        
    }
    override var prefersStatusBarHidden: Bool{            
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        
    }
    
    @IBAction func joystickPress(_ sender: UIButton) {
        switch sender.currentTitle {
        case "Up":
            print("Up")
            print()
            changeModelPosition(xPos: virtualModelLoader.position.x, yPos: virtualModelLoader.position.y + 0.2)
        case "Down":
            print("Down")
            changeModelPosition(xPos: virtualModelLoader.position.x, yPos: virtualModelLoader.position.y - 0.2)
        case "Left":
            print("Left")
            changeModelPosition(xPos: virtualModelLoader.position.x - 0.2, yPos: virtualModelLoader.position.y )
        case "Right":
            print("Right")
            changeModelPosition(xPos: virtualModelLoader.position.x + 0.2, yPos: virtualModelLoader.position.y)
        default:
            print("Title not present")
        }
    }
    
    
    private func changeModelPosition(xPos x : Float = 0,yPos y : Float = 0,zPos z : Float = -0.7){
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.2
        virtualModelLoader.position = SCNVector3(x: x, y: y, z: z)
        SCNTransaction.commit()
    }
}

