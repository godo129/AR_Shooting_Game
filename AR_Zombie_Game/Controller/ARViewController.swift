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
    
    private var timer = Timer()
    
    private var gamePointLabel = GamePointLabel()
    
    private let menuView = GameMenuView()
    
    var point = 0
    
    private var targetList: [SCNNode] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/Dungeon.scn")!
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        self.sceneView.scene.physicsWorld.contactDelegate = self
        
        addGun()
        addReloadButton()
        gunShooting()
        
        self.sceneView.addSubview(gamePointLabel)
        gamePointLabel.frame = CGRect(x: self.sceneView.bounds.width-200, y: 0, width: 200, height: 50)
        gamePointLabel.text = "\(point) 점"
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            self.addZombie()
        })
        
    }
    
    private func addZombie() {
        

        
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let RGBValue = getRandomRGBValue()
        box.firstMaterial?.diffuse.contents = UIColor(red: RGBValue.0, green: RGBValue.1, blue: RGBValue.2, alpha: 1)
        let boxNode = SCNNode(geometry: box)
        let position = getRandomPosition()
        boxNode.position = position
        
        let shape = SCNPhysicsShape(geometry: box, options: nil)
        boxNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        boxNode.physicsBody?.isAffectedByGravity = false
        boxNode.physicsBody?.categoryBitMask = CollisionCategory.zombie.rawValue
        boxNode.physicsBody?.collisionBitMask = CollisionCategory.bullet.rawValue
        boxNode.physicsBody?.contactTestBitMask = CollisionCategory.bullet.rawValue
        
        targetList.append(boxNode)
        
//        let zombieNode = Zombie()
//        boxNode.addChildNode(zombieNode)
//        zomebieNode.position.x = position.x
//        zomebieNode?.position.y = position.y
//        zomebieNode?.position.z = position.z

        self.sceneView.scene.rootNode.addChildNode(boxNode)
        
    }
    
    private func removeAllTarget() {
        
        for target in targetList {
            target.removeFromParentNode()
        }
    }
    
    private func getRandomRGBValue() -> (CGFloat,CGFloat,CGFloat) {
        
        let R = CGFloat(Double.random(in: 0..<1))
        let G = CGFloat(Double.random(in: 0..<1))
        let B = CGFloat(Double.random(in: 0..<1))
        
        return (R,G,B)
        
    }
    
    private func getRandomPosition() -> SCNVector3 {
        
        let x = Float(Double.random(in: -0.5..<0.5))
        let y = Float(0)
        let z = Float(Double.random(in: -0.5..<0.5))
        
        return SCNVector3Make(x, y, z)
    }
    
    
    
    private func gunShooting() {
        let tagGesture = UITapGestureRecognizer(target: self, action: #selector(shoot))
        self.sceneView.addGestureRecognizer(tagGesture)
    }
    
    @objc private func shoot(recognizer: UITapGestureRecognizer) {
        
        let bulletsNode = Bullet()
        let (direction, position) = self.getUserVector()
        bulletsNode.position = position // SceneKit/AR coordinates are in meters
        let bulletDirection = direction
        let impulseVector = SCNVector3(
            x: bulletDirection.x * Float(20),
            y: bulletDirection.y * Float(20),
            z: bulletDirection.z * Float(20)
        )

//        let forceVector = SCNVector3(bulletsNode.worldFront.x * 2, bulletsNode.worldFront.y * 2, bulletsNode.worldFront.z * 2)

        bulletsNode.physicsBody?.applyForce(impulseVector, asImpulse: true)
        sceneView.scene.rootNode.addChildNode(bulletsNode)

        //3 seconds after shooting the bullet, remove the bullet node
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            // remove node
            bulletsNode.removeFromParentNode()
        })
        
    }
    
    private func getUserVector() -> (SCNVector3, SCNVector3) { // (direction, position)
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // orientation of camera in world space
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
            
            return (dir, pos)
        }
        return (SCNVector3Zero, SCNVector3Zero)
    }
    

    private func addGun() {

        let gun = SCNScene(named: "art.scnassets/gun.dae")!
        guard let gunNode = gun.rootNode.childNode(withName: "Gun", recursively: true) else { return }
        
        self.sceneView.scene.rootNode.addChildNode(gunNode)
    }
    
    private func addReloadButton() {
        let reloadButton = ReloadButton()
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        reloadButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
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

extension ARViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.zombie.rawValue || contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.zombie.rawValue {
            point += 1
            
            
            
            DispatchQueue.main.async {
                
                if self.targetList.count > 3 {
                    self.menuView.frame = self.sceneView.bounds
                    self.sceneView.addSubview(self.menuView)
                    self.removeAllTarget()
                    self.timer.invalidate()
                    
                    self.menuView.saveView.gamePointLabel.text = "\(self.point)"
                    
                }
                
                self.gamePointLabel.text = "\(self.point) 점"
                
                contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
            }
            
        }
    }

}
