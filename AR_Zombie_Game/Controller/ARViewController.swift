//
//  ViewController.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/18.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/Dungeon.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        addGun()
        addReloadButton()
    }
    

    private func addGun() {

        let gun = SCNScene(named: "art.scnassets/gun.dae")!
        guard let gunNode = gun.rootNode.childNode(withName: "Gun", recursively: true) else { return }
        
        self.sceneView.scene.rootNode.addChildNode(gunNode)
    }
    
    private func addReloadButton() {
        let reloadButton = UIButton()
        reloadButton.titleLabel?.text = "Reload"
        reloadButton.titleLabel?.textColor = .orange
        reloadButton.backgroundColor = .gray
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        reloadButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        self.sceneView.addSubview(reloadButton)
    }
    
    @objc private func reloadButtonTapped() {
        
        guard let gunNode = self.sceneView.scene.rootNode.childNode(withName: "Gun", recursively: true) else {return}
        
        reloadGun(node: gunNode)
    }
    
    
    private func reloadGun(node: SCNNode) {
        
        let action = SCNAction.rotate(by: .pi*2, around: SCNVector3(1, 0, 0), duration: 0.5)
        node.runAction(action)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

  
}
