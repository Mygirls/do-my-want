//
//  ViewController.m
//  RACTest
//
//  Created by JQ on 2017/9/28.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"

#import <AFNetworking.h>
#import <ReactiveObjC.h>
@interface ViewController ()
{
//    NSString *username;
    
}
@property(nonatomic,strong) NSString *username;

@property(nonatomic,assign) BOOL createEnabled;
@property(nonatomic,strong) NSString *passwordConfirmation;
@property(nonatomic,strong) NSString *password;

@property(nonatomic,strong) UIButton *button;

@property(nonatomic,strong) RACCommand *loginCommand;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpConfig];

}

- (void)setUpConfig
{
 
    [self setUpView];
    
    //[self test01];
    
    //[self test02];
    
    //[self test03];
    
    //[self test04];
    
    [self test05];
}

- (void) setUpView
{
    [self.view addSubview:self.button];
    
}

- (UIButton *)button
{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(100, 100, 100, 100);
        _button.backgroundColor = [UIColor orangeColor];
    }
    
    return _button;
}


#pragma mark - 初探
- (void)test01 {
    
    //当username改变时候，就会在控制台输出新的username
    //
    //RACObserve(self, username) creates a new RACSignal that sends the current
    //value of self.username, then the new value whenever it changes
    //-subscribeNext: will execute the block whenever the signal sends a value.（只要信号发送一个值，它将执行该块代码）
    [RACObserve(self, username) subscribeNext:^(NSString * newName) {
        NSLog(@"%@",newName);
    }];
    
    //RACObserve(<#TARGET#>, <#KEYPATH#>)
    
    
   
}

- (void)test02 {
    // Only logs names that starts with "j".
    //
    // -filter returns a new RACSignal that only sends a new value when its block
    // returns YES.
    [[RACObserve(self, username)
      filter:^(NSString *newName) {
          
          return [newName hasPrefix:@"j"];
          
      }] subscribeNext:^(NSString *newName) {
          NSLog(@"%@", newName);
      }];
    
    
    // Filters out values in the receiver that don't pass the given test.(过滤接收器中未通过给定测试的值。)
    ///
    /// This corresponds to the `Where` method in Rx.(这对应于Rx中的“Where”方法。)
    ///
    /// Returns a new signal with only those values that passed.(返回一个新信号，只有那些通过的值。)
    [RACObserve(self , username) filter:^BOOL(id  _Nullable value) {
        return true;
    }];
}

- (void)test03 {
    
    // Creates a one-way binding so that self.createEnabled will be
    // true whenever self.password and self.passwordConfirmation
    // are equal.创建单向绑定，以使self.createEnabled在self.password和self.passwordConfirmation相等时都为true。
    //
    // RAC() is a macro that makes the binding look nicer.
    //
    // +combineLatest:reduce: takes an array of signals, executes the block with the
    // latest value from each signal whenever any of them changes, and returns a new
    // RACSignal that sends the return value of that block as values.
    NSLog(@"%d",_createEnabled);

    RAC(self, createEnabled) = [RACSignal
                                combineLatest:@[ RACObserve(self, password), RACObserve(self, passwordConfirmation) ]
                                reduce:^(NSString *password, NSString *passwordConfirm) {
                                    
                                    return @([passwordConfirm isEqualToString:password]);
                                }];
    
    NSLog(@"%d",_createEnabled);
}

- (void)test04 {
    
    // Logs a message whenever the button is pressed.
    //
    // RACCommand creates signals to represent UI actions. Each signal can
    // represent a button press, for example, and have additional work associated
    // with it.
    //
    // -rac_command is an addition to NSButton. The button will send itself on that
    // command whenever it's pressed. -rac_command是NSButton的补充。 当执行pressed命令时，该button发送自己。
    self.button.rac_command = [[RACCommand alloc] initWithSignalBlock:^(id _) {
        NSLog(@"button was pressed!");
        return [RACSignal empty];
    }];
}

//又问题
- (void)test05 {
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    
        return [[RACSignal alloc] init];
    }];
    
    // -executionSignals returns a signal that includes the signals returned from
    // the above block, one for each time the command is executed.
    [self.loginCommand.executionSignals subscribeNext:^(RACSignal *loginSignal) {
        // Log a message whenever we log in successfully.
        [loginSignal subscribeCompleted:^{
            NSLog(@"Logged in successfully!");
        }];
    }];
    
    // Executes the login command when the button is pressed.
    self.button.rac_command = self.loginCommand;
    
}

- (void)test06 {
    
    
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int i = 10;
    i += 1;
    self.username = [NSString stringWithFormat:@"j张三 %d",i];
    
    self.password = @"121";
    self.passwordConfirmation = @"121";

    NSLog(@"%d",_createEnabled);

}

@end
