//
//  ViewController.m
//  滚动
//
//  Created by JQ on 2017/9/5.
//  Copyright © 2017年 majq. All rights reserved.
//

#import "ViewController.h"
#import "WMPanGestureRecognizer.h"
#import "FirstViewController.h"
static CGFloat const kWMMenuViewHeight = 50.0;

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSArray *musicCategories;
@property (nonatomic, strong) WMPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) UIView *redView;


@end

@implementation ViewController

- (NSArray *)musicCategories {
    if (!_musicCategories) {
        _musicCategories = @[@"单曲", @"详情", @"歌词",@"单曲1", @"详情1", @"歌词1",@"单曲2", @"详情2", @"歌词2"];
    }
    return _musicCategories;
}



//- (instancetype)init {
//    if (self = [super init]) {
//        self.titleSizeNormal = 15;
//        self.titleSizeSelected = 15;
//        self.menuViewStyle = WMMenuViewStyleLine;
//        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.musicCategories.count;
//        self.viewTop = kNavigationBarHeight + kWMHeaderViewHeight;
//        self.titleColorSelected = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
//        self.titleColorNormal = [UIColor greenColor];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleSizeNormal = 15;
    self.titleSizeSelected = 15;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.musicCategories.count;
    self.viewTop = kNavigationBarHeight + kWMHeaderViewHeight;
    self.titleColorSelected = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    self.titleColorNormal = [UIColor greenColor];

    
    // Do any additional setup after loading the view.
    self.title = @"专辑";
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, [UIScreen mainScreen].bounds.size.width, kWMHeaderViewHeight)];
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    [self.view addSubview:self.redView];
    
    self.panGesture = [[WMPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];
}

- (void)btnClicked:(id)sender {
    NSLog(@"touch up inside");
}

- (void)panOnView:(WMPanGestureRecognizer *)recognizer {
    NSLog(@"pannnnnning received..");
    
    CGPoint currentPoint = [recognizer locationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.lastPoint = currentPoint;
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat targetPoint = velocity.y < 0 ? kNavigationBarHeight : kNavigationBarHeight + kWMHeaderViewHeight;
        NSTimeInterval duration = fabs((targetPoint - self.viewTop) / velocity.y);
        
        if (fabs(velocity.y) * 1.0 > fabs(targetPoint - self.viewTop)) {
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.viewTop = targetPoint;
            } completion:nil];
            
            return;
        }
        
    }
    CGFloat yChange = currentPoint.y - self.lastPoint.y;
    self.viewTop += yChange;
    self.lastPoint = currentPoint;
    
    
}

// MARK: ChangeViewFrame (Animatable)
- (void)setViewTop:(CGFloat)viewTop {
    _viewTop = viewTop;
    
    if (_viewTop <= kNavigationBarHeight) {
        _viewTop = kNavigationBarHeight;
    }
    
    if (_viewTop > kWMHeaderViewHeight + kNavigationBarHeight) {
        _viewTop = kWMHeaderViewHeight + kNavigationBarHeight;
    }
    
    self.redView.frame = ({
        CGRect oriFrame = self.redView.frame;
        oriFrame.origin.y = _viewTop - kWMHeaderViewHeight;
        oriFrame;
    });
    NSLog(@"_viewTop = %f",_viewTop);
    [self forceLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.musicCategories.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    FirstViewController *vc = [[FirstViewController alloc] init];
   
    
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.musicCategories[index];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

//menuview frame
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, _viewTop, self.view.frame.size.width, kWMMenuViewHeight);
}

//contentView frame
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = _viewTop + kWMMenuViewHeight;
    NSLog(@"originY = %f",originY);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

#pragma mark - 计算
- (void)reloadHeight: (CGFloat)h {
    NSLog(@"h = %f",h);
    //    CGFloat temH = 0;
    //
    //    if (h >= 0 && h <= 200) {
    //        _viewTop = 264 - h;
    //        temH = h;
    //        NSLog(@"_viewTop = %f ,h = %f",_viewTop,h);
    //
    //    } else if (h > 200) {
    //        _viewTop = 264 - 200;
    //        temH = 200;
    //    } else {
    //
    //        _viewTop = 264;
    //        temH = 0;
    //    }
    //
    //    self.redView.frame = ({
    //        CGRect oriFrame = self.redView.frame;
    //        oriFrame.origin.y = 64 - temH;
    //        oriFrame;
    //    });
    //
    //    [self forceLayoutSubviews];
}

- (void)reloadViewTop:(CGFloat)viewTop {
    _viewTop = viewTop;
    
    if (_viewTop <= kNavigationBarHeight) {
        _viewTop = kNavigationBarHeight;
    }
    
    if (_viewTop > kWMHeaderViewHeight + kNavigationBarHeight) {
        _viewTop = kWMHeaderViewHeight + kNavigationBarHeight;
    }
    
    self.redView.frame = ({
        CGRect oriFrame = self.redView.frame;
        oriFrame.origin.y = _viewTop - kWMHeaderViewHeight;
        oriFrame;
    });
    
    [self forceLayoutSubviews];
}


@end
