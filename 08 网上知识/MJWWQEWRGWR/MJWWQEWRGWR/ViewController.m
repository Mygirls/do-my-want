//
//  ViewController.m
//  MJWWQEWRGWR
//
//  Created by 曹健 on 17/3/6.
//  Copyright © 2017年 曹健. All rights reserved.
//

#import "ViewController.h"
#import "MJRefreshGifHeader.h"
#import "SBHeadView.h"

#define headHeight 300
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    SBHeadView *_sbView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ];
   // _tableView.backgroundColor = [UIColor yellowColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset=UIEdgeInsetsMake(headHeight, 0, 0, 0);
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   　// _tableView.tableHeaderView = self.headView;
  //  _tableView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeInteractive;//UIScrollViewKeyboardDismissModeInteractive;
    _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(upDateData)];
    [self.view addSubview:_tableView];
    
    _sbView = [[SBHeadView alloc]initWithFrame:CGRectMake(0, -headHeight, [UIScreen mainScreen].bounds.size.width, headHeight)];
    _sbView.backgroundColor = [UIColor redColor];
    [_tableView addSubview:_sbView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)upDateData
{

    [_tableView.mj_header endRefreshing];
}


#pragma mark tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
//    cell.backgroundColor = [UIColor orangeColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    // NSLog(@"%ld --will",indexPath.row);
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView) {
        
        
        CGFloat xxx = scrollView.contentOffset.y >= -headHeight ? -headHeight : scrollView.contentOffset.y;
        NSLog(@"%f  - xxx  = %f",scrollView.contentOffset.y,xxx );
        _sbView.frame = CGRectMake(0, xxx, _sbView.bounds.size.width, _sbView.bounds.size.height);
     }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
