//
//  ThirdViewController.m
//  MajqPageView
//
//  Created by JQ on 2017/9/16.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ThirdViewController.h"
#define majqScreenW  [UIScreen mainScreen].bounds.size.width
#define majqScreenH  [UIScreen mainScreen].bounds.size.height

@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpConfig];
}

- (void)tableViewIsScrollEnabled:(BOOL) isScrollEnabled;
{
    self.tableView.scrollEnabled = isScrollEnabled;
    
    
}


- (void)setUpConfig {
    [self.view addSubview: self.tableView];
    
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

#pragma mark - 协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 23;
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


@end
