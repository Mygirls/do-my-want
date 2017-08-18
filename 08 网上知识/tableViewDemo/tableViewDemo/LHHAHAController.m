//
//  LHHAHAController.m
//  tableViewDemo
//
//  Created by liuhao on 17/3/28.
//  Copyright © 2017年 liuhao. All rights reserved.
//

#import "LHHAHAController.h"

@interface LHHAHAController ()

@end

@implementation LHHAHAController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSString *)description {
    return @"haha";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    return v;
}
@end
