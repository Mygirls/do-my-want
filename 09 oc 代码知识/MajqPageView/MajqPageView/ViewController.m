//
//  ViewController.m
//  MajqPageView
//
//  Created by JQ on 2017/9/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "MajqTableView.h"
#import "MajqPageScrollView.h"
#define majqScreenW  [UIScreen mainScreen].bounds.size.width
#define majqScreenH  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)MajqTableView *tableView;
@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)MajqPageScrollView *pageScrollView;
@property(nonatomic,strong)NSMutableArray *childVCs;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;

@end

@implementation ViewController

- (NSMutableArray *)childVCs
{
    if (_childVCs == nil) {
        _childVCs = [[NSMutableArray array]init];
    }
    return _childVCs;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[MajqTableView alloc]initWithFrame:CGRectMake(0, 0, majqScreenW, majqScreenH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;

        
    }
    return _tableView;
}

- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, majqScreenW, 200)];
        _headerView.backgroundColor = [UIColor orangeColor];
    }
    
    return _headerView;
}

- (MajqPageScrollView *)pageScrollView
{
    if (_pageScrollView == nil) {
        _pageScrollView = [[MajqPageScrollView alloc]initWithFrame:CGRectMake(0, 45, majqScreenW, majqScreenH - 45)];
        FirstViewController *vc1 = [[FirstViewController alloc]initWithCurrent:@"1"];
        SecondViewController *vc2 = [[SecondViewController alloc]init];
        ThirdViewController *vc3 = [[ThirdViewController alloc]init];
        vc1.view.tag = 1;
        vc2.view.tag = 1;
        vc3.view.tag = 1;

        
        [self.childVCs addObject:vc1];
        [self.childVCs addObject:vc2];
        [self.childVCs addObject:vc3];
        
       
        

        [self.pageScrollView addController:self.childVCs];
        
        [self addChildViewController:vc1];
        [self addChildViewController:vc2];
        [self addChildViewController:vc3];
        [self.pageScrollView setCurrentIndex:0];
        
        
        
    }
    return _pageScrollView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpConfig];

    
}

- (void)setUpConfig {
    [self.view addSubview: self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.rowHeight = majqScreenH - 45;
}

#pragma mark - 协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:self.pageScrollView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    

}




@end
