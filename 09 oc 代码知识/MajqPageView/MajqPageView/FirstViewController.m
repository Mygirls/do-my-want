//
//  FirstViewController.m
//  MajqPageView
//
//  Created by JQ on 2017/9/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "FirstViewController.h"
#define majqScreenW  [UIScreen mainScreen].bounds.size.width
#define majqScreenH  [UIScreen mainScreen].bounds.size.height

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;


@property (nonatomic, assign) BOOL canScroll;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpConfig];
}

- (instancetype)initWithCurrent: (NSString *)type
{
    self = [super init];
    if (self) {
        
        [self.view addSubview: self.tableView];

    }
    return self;
}

- (void)tableViewIsScrollEnabled:(BOOL) isScrollEnabled;
{
    self.tableView.scrollEnabled = isScrollEnabled;


}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, majqScreenW, majqScreenH - 45) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (void)setUpConfig {
    
}

#pragma mark - 协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 33;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        [cell.contentView addSubview:label];
        label.text = @"121";
    }
    
    return cell;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (!self.canScroll) {
        
        [scrollView setContentOffset:CGPointZero];
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY<0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil userInfo:@{@"canScroll":@"1"}];
    }

}

@end
