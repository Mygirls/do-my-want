//
//  ViewController.m
//  AR 2D 演示效果
//
//  Created by JQ on 2017/10/10.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
#import "Scene.h"

@interface ViewController () <ARSKViewDelegate>

// ARSKView 是ARKit框架中负责展示2d AR 的预览视图
@property (nonatomic, strong) IBOutlet ARSKView *sceneView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the view's delegate 设置场景试图代理
    self.sceneView.delegate = self;
    
    // Show statistics such as fps and node count 设置帧率
    self.sceneView.showsFPS = YES;
    
    //显示界面节点 游戏开发中，一个角色对应一个节点
    self.sceneView.showsNodeCount = YES;
    
    // Load the SKScene from 'Scene.sks' 加载2d 场景 2d是平面的
    Scene *scene = (Scene *)[SKScene nodeWithFileNamed:@"Scene"];
    
    // Present the scene AR 预览视图展示场景 这一点与3d 视图家在有区别
    [self.sceneView presentScene:scene];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];

    // Run the view's session
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - ARSKViewDelegate
//点击界面会调用，类似于touch Begin 方法，anchor 是2d 坐标的喵点
- (SKNode *)view:(ARSKView *)view nodeForAnchor:(ARAnchor *)anchor {
    // Create and configure a node for the anchor added to the view's session.
    // 创建节点 节点可以理解为AR 将要展示的2d 图像
    SKLabelNode *labelNode = [SKLabelNode labelNodeWithText:@"👾"];
    labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    return labelNode;
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
