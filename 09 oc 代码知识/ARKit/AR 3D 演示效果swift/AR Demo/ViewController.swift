//
//  ViewController.swift
//  AR Demo
//
//  Created by JQ on 2017/10/10.
//  Copyright © 2017年 Majq. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    //ARKit框架中用于3D显示的预览视图
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate//设置代理
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information//ARKit统计信息
        sceneView.showsStatistics = true
        
        // Create a new scene
        //使用模型创建节点（scn格式文件是一个基于3D建模的文件，使用3DMax软件可以创建，这里系统有一个默认的3D飞机）
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //设置ARKit的场景为SceneKit的当前场景（SCNScene是Scenekit中的场景，类似于UIView）
        sceneView.scene = scene
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        //创建一个追踪设备配置（ARWorldTrackingSessionConfiguration主要负责传感器追踪手机的移动和旋转）
        let configuration = ARWorldTrackingConfiguration()
        /**
         （会话追踪配置）的作用是跟踪设备的方向和位置,以及检测设备摄像头看到的现实世界的表面。它的内部实现了一系列非常庞大的算法计算以及调用了你的iPhone必要的传感器来检测手机的移动及旋转甚至是翻滚
         */

        // Run the view's session
        // 开始启动ARSession会话（启动AR）
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        // 暂停ARSession会话
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        //SCNNode 节点： 指的是 3d 物体模型
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
