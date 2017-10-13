//
//  ARSCNViewController.m
//  ARKit 自定义
//
//  Created by JQ on 2017/10/10.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ARSCNViewController.h"

@interface ARSCNViewController ()

//AR视图：展示3D界面
@property(nonatomic,strong)ARSCNView *arSCNView;

//AR会话，负责管理相机追踪配置及3D相机坐标
@property(nonatomic,strong)ARSession *arSession;

//会话追踪配置：负责追踪相机的运动
@property(nonatomic,strong)ARConfiguration *arSessionConfiguration;

//飞机3D模型(本小节加载多个模型)
@property(nonatomic,strong)SCNNode *planeNode;

@end

@implementation ARSCNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];

}


#pragma mark - 懒加载
- (ARConfiguration *)arSessionConfiguration
{
    if (_arSessionConfiguration != nil) {
        return _arSessionConfiguration;
    }
    
    //1.创建世界追踪会话配置（使用ARWorldTrackingSessionConfiguration效果更加好），需要A9芯片支持
    ARWorldTrackingConfiguration *configuration = [[ARWorldTrackingConfiguration alloc] init];
   
    //2.设置追踪方向（追踪平面，后面会用到）
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    _arSessionConfiguration = configuration;
   
    //3.自适应灯光（相机从暗到强光快速过渡效果会平缓一些）
    _arSessionConfiguration.lightEstimationEnabled = YES;
    
    return _arSessionConfiguration;
}

//懒加载拍摄会话
- (ARSession *)arSession
{
    if(_arSession != nil)
    {
        return _arSession;
    }
    //1.创建会话
    _arSession = [[ARSession alloc] init];
   
    //2返回会话
    return _arSession;
}

//创建AR视图
- (ARSCNView *)arSCNView
{
    if (_arSCNView != nil) {
        return _arSCNView;
    }
    //1.创建AR视图
    _arSCNView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
   
    //2.设置视图会话
    _arSCNView.session = self.arSession;
  
    //3.自动刷新灯光（3D游戏用到，此处可忽略）
    _arSCNView.automaticallyUpdatesLighting = YES;
    
    return _arSCNView;
}

#pragma mark - 开启AR扫描
/**
 ***这里需要特别注意的是，最好将开启ARSession的代码放入viewDidAppear而不是viewDidLoad中，这样可以避免线程延迟的问题。开启ARSession的代码可不可以放入viewDidLoad中呢？答案是可以的，但是笔者不建议大家那么做***
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //1.将AR视图添加到当前视图
    [self.view addSubview:self.arSCNView];
   
    //2.开启AR会话（此时相机开始工作）
    [self.arSession runWithConfiguration:self.arSessionConfiguration];
    
}

#pragma mark - 点击屏幕添加飞机
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.使用场景加载scn文件（scn格式文件是一个基于3D建模的文件，使用3DMax软件可以创建，这里系统有一个默认的3D飞机）--------在右侧我添加了许多3D模型，只需要替换文件名即可
    //SCNScene *scene = [SCNScene sceneNamed:@"Models.scnassets/ship.scn"];
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];

    //2.获取飞机节点（一个场景会有多个节点，此处我们只写，飞机节点则默认是场景子节点的第一个）
    //所有的场景有且只有一个根节点，其他所有节点都是根节点的子节点
    SCNNode *shipNode = scene.rootNode.childNodes[0];
    //SCNNode *node = [SCNNode new];

    //椅子比较大，可以可以调整Z轴的位置让它离摄像头远一点，，然后再往下一点（椅子太高我们坐不上去）就可以看得全局一点
    //shipNode.position = SCNVector3Make(0, -1, -1);//x/y/z/坐标相对于世界原点，也就是相机位置
    
    //3.将飞机节点添加到当前屏幕中
    [self.arSCNView.scene.rootNode addChildNode:shipNode];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
