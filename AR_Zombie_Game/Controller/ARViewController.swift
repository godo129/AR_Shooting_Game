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
    
    let megazine = Megazine()
    
    var bulletLabel = BulletLabel()
    
    let UIboard = UIBaord(position: SCNVector3(x: 0, y: -0.5, z: -0.5))
    
    let ARKeyboard = ARKeyBoard(position: SCNVector3(0, -0.3, -0.3))
    
//    private let menuView = GameMenuView()
    
    private var point = 0
    
    private var targetList: [SCNNode] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/Dungeon.scn")!
//        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        
        self.sceneView.scene.physicsWorld.contactDelegate = self
        
        self.sceneView.addSubview(megazine)
        self.sceneView.addSubview(bulletLabel)
        
        
        self.sceneView.scene.rootNode.addChildNode(UIboard)
        
        addGun()
        targetLabel()
        gamePlay()
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveComplete), name: gamePointSaveViewExit, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gamePlay), name: gameMenuViewExit, object: nil)
        
        
    }
    
    private func targetLabel() {
        
        let label = UILabel()
        label.text = "+"
        label.frame = CGRect(x: self.view.center.x-3, y: self.view.center.y-48, width: 50, height: 50)
        self.sceneView.addSubview(label)
   
        
    }
    
    private func layoutMagazineView() {
     
        updateMegazine()
        
        megazine.frame = CGRect(x: 20, y: self.view.frame.height-130, width: 100, height: 50)
        bulletLabel.frame = CGRect(x: megazine.frame.origin.x,
                             y: megazine.frame.origin.y+megazine.frame.height,
                             width: megazine.frame.width,
                             height: megazine.frame.height)
        
        
    }
    
    private func bulletLabelUpdate() {
        bulletLabel.text = "\(player.curAmountOfBullet) / \(player.AmountOfMagazine)"
    }
    
    @objc private func gamePlay() {
        targetList = [SCNNode]()
        layoutMagazineView()
        reset()
        addReloadButton()
        gunShooting()
        addGamePointLabel()
        startMakeTarget()
        updateMegazine()
        
        
    }
    
    private func addGamePointLabel() {
        self.sceneView.addSubview(gamePointLabel)
        gamePointLabel.frame = CGRect(x: self.sceneView.bounds.width-150, y: 0, width: 150, height: 50)
        gamePointLabel.text = "\(point) ???"
    }
    
    private func startMakeTarget() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            self.addZombie()
        })
    }
    
    private func reset() {
        point = 0
        player.curAmountOfBullet = 10
    }
    
    @objc private func saveComplete() {
        
        let alert = UIAlertController(title: "?????? ??????", message: "????????? ??? ????????? ????????? ?????????", preferredStyle: .alert)
        let restartAlertAction = UIAlertAction(title: "?????? ?????????", style: .default) { _ in
            self.gamePlay()
        }
        let closeAlertAction = UIAlertAction(title: "?????? ??????", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(restartAlertAction)
        alert.addAction(closeAlertAction)
        
        self.present(alert, animated: true, completion: nil)
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
    
    private func updateMegazine() {
        megazine.amount = player.AmountOfMagazine
        megazine.curAmount = player.curAmountOfBullet
        megazine.makeImage()
        bulletLabelUpdate()
        
    }
    
    @objc private func UIClick(recognizer: UITapGestureRecognizer) {
        guard let sceneView = recognizer.view as? SCNView else {return}
        let touchLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(touchLocation, options: [:])

        if !hitTestResults.isEmpty {
            guard let nodeName = hitTestResults.first?.node.name else {return}
            

            switch nodeName {
                
            case "cancelButton" :
                UIboard.removeFromParentNode()
            case "save" :
                UIboard.childNode(withName: "save", recursively: true)?.removeFromParentNode()
                self.sceneView.scene.rootNode.addChildNode(ARKeyboard)
            case "replay" :
                UIboard.removeFromParentNode()
                gamePlay()
            case "SHIFT" :
                ARKeyboard.pressedShift  = !ARKeyboard.pressedShift
                guard let keyboardNode = ARKeyboard.childNode(withName: "Keyboard", recursively: true) else {return}
                ARKeyboard.addKey(position: ARKeyboard.position, keyboard: ARKeyboard.keyboard , keyboardNode: keyboardNode)
            case "SPACE" :
                UIboard.nickName += " "
                UIboard.initializeBoard()
            case "<-" :
                if UIboard.nickName != "" {
                    UIboard.nickName.removeLast()
                    UIboard.initializeBoard()
                }
            default :
                if nodeName.count == 1 {
                    UIboard.nickName += nodeName
                    UIboard.initializeBoard()
                }
            }
            
        }
    }
    
    @objc private func shoot(recognizer: UITapGestureRecognizer) {
        
        
        if player.curAmountOfBullet > 0 {
            let bulletsNode = Bullet()
            let (direction, position) = self.getUserVector()
            bulletsNode.position = position // SceneKit/AR coordinates are in meters
            let bulletDirection = direction
            let impulseVector = SCNVector3(
                x: bulletDirection.x * Float(10),
                y: bulletDirection.y * Float(10),
                z: bulletDirection.z * Float(10)
            )

    //        let forceVector = SCNVector3(bulletsNode.worldFront.x * 2, bulletsNode.worldFront.y * 2, bulletsNode.worldFront.z * 2)

            bulletsNode.physicsBody?.applyForce(impulseVector, asImpulse: true)
            sceneView.scene.rootNode.addChildNode(bulletsNode)

            //3 seconds after shooting the bullet, remove the bullet node
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                // remove node
                bulletsNode.removeFromParentNode()
            })
            
            player.usedBullet()
            updateMegazine()
            
        }

    }
    
    @objc private func burstShoot(recognizer: UITapGestureRecognizer) {
        
        for _ in 0..<3 {
            shotGunShoot(recognizer: recognizer)
        }
        
    }
    
    @objc private func shotGunShoot(recognizer: UITapGestureRecognizer) {
        
        if player.curAmountOfBullet > 3 {
            
            let bulletNode1 = Bullet()
            let (direction, position) = self.getUserVector()
            bulletNode1.position = position
            let bulletDirection = direction
            let impulseVector1 = SCNVector3(
                x: bulletDirection.x * Float(20),
                y: bulletDirection.y * Float(10),
                z: bulletDirection.z * Float(10)
            )
            
            let bulletNode2 = Bullet()
            bulletNode2.position = position
            let impulseVector2 = SCNVector3(
                x: bulletDirection.x * Float(10),
                y: bulletDirection.y * Float(20),
                z: bulletDirection.z * Float(10)
            )
            
            let bulletNode3 = Bullet()
            bulletNode3.position = position
            let impulseVector3 = SCNVector3(
                x: bulletDirection.x * Float(10),
                y: bulletDirection.y * Float(10),
                z: bulletDirection.z * Float(20)
            )
            
            bulletNode1.physicsBody?.applyForce(impulseVector1, asImpulse: true)
            sceneView.scene.rootNode.addChildNode(bulletNode1)
            
            bulletNode2.physicsBody?.applyForce(impulseVector2, asImpulse: true)
            sceneView.scene.rootNode.addChildNode(bulletNode2)
            
            bulletNode3.physicsBody?.applyForce(impulseVector3, asImpulse: true)
            sceneView.scene.rootNode.addChildNode(bulletNode3)

            //3 seconds after shooting the bullet, remove the bullet node
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                // remove node
                
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                bulletNode1.removeFromParentNode()
                bulletNode2.removeFromParentNode()
                bulletNode3.removeFromParentNode()
            }
            
            player.usedBullet()
            player.usedBullet()
            player.usedBullet()
            
            updateMegazine()
            
        }
        
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
        
        player.curAmountOfBullet = player.AmountOfMagazine
        updateMegazine()
        
        guard let gunNode = self.sceneView.scene.rootNode.childNode(withName: "Gun", recursively: true) else {return}
        reloadGun(node: gunNode)
        
    }
    
    
    private func reloadGun(node: SCNNode) {
        
        let action = SCNAction.rotate(by: .pi*2, around: SCNVector3(1, 0, 0), duration: 0.5)
        node.runAction(action)
        
    }
    
    @objc private func turningGun(node: SCNNode) {
        
//        let rotateAction = SCNAction.rotateBy(x: 0, y: 0.5, z: 0, duration: 1)
//        let infiniteAction = SCNAction.repeatForever(rotateAction)
//        node.runAction(infiniteAction)
        
        guard let currentCameraPosition = sceneView.pointOfView?.position else {return}
        let toMovePosition = SCNVector3(currentCameraPosition.x, currentCameraPosition.y, currentCameraPosition.z-1.0)
        let moveAction = SCNAction.move(to: toMovePosition, duration: 0.1)
        node.runAction(moveAction)
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
                
                if self.targetList.count >  6 {
                    self.openMenuView()
                }
                
                self.gamePointLabel.text = "\(self.point) ???"
                
                contact.nodeA.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
            }
            
        }
    }
    
    private func openMenuView() {
        let menuView = GameMenuView()
        menuView.frame = self.sceneView.bounds
        self.sceneView.addSubview(menuView)
        self.removeAllTarget()
        self.timer.invalidate()
        menuView.saveView.gamePointLabel.text = "\(self.point)"
        player.curAmountOfBullet = 0
    }

}
