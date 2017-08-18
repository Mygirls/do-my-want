//
//  ViewController.m
//  TableView
//
//  Created by cfzq on 2017/7/27.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;

}

@property(nonatomic,strong)UISwitch *switchFunc;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 220, 600) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    [self.view addSubview:_tableView];
    
    [self.view addSubview:self.switchFunc];
 
    [self joinGroup:@"" key:@""];
}

- (BOOL)joinGroup:(NSString *)groupUin key:(NSString *)key{
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", @"618719785",@"3f4fd20a66abd578cc89b31c22f603f4a9a4eac050060e02e5876e79efdbb621"];
    NSLog(@"%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    else return NO;
    
    //mqqapi://cardow_pslcard?src_type=internal&version=1&uin=618719785&key=3f4fd20a66abd578cc89b31c22f603f4a9a4eac050060e02e5876e79efdbb621&card_type=group&source=external
    //mqqapi://card/show_pslcard?src_type=internal&version=1&uin=618719785&key=3f4fd20a66abd578cc89b31c22f603f4a9a4eac050060e02e5876e79efdbb621&card_type=group&source=external
}
-(UISwitch *)switchFunc{
    if(_switchFunc == nil){
        _switchFunc = [[UISwitch alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        [_switchFunc setOnTintColor:[UIColor colorWithRed:253/255.0 green:91/255.0 blue:120/255.0 alpha:1]];
        _switchFunc.layer.cornerRadius = 15.5f;
        _switchFunc.layer.masksToBounds = YES;
        _switchFunc.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1];
        [_switchFunc addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchFunc;
}

- (void)switchAction:(UISwitch *)swit {

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"CellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    
    return 100;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _tableView.reloadData;
    
}
    
@end
