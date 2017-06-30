//
//  ViewController.m
//  PushTest
//
//  Created by cfzq on 2017/6/21.
//  Copyright © 2017年 cfzq. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

#define kLocalNotificationKey @"kLocalNotificationKey"
#define kNotificationCategoryIdentifile @"kNotificationCategoryIdentifile"
#define kNotificationActionIdentifileStar @"kNotificationActionIdentifileStar"
#define kNotificationActionIdentifileComment @"kNotificationActionIdentifileComment"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)send:(id)sender {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        [self sendiOS10LocalNotification];
    } else {
        [self sendiOS8LocalNotification];
    }
}

- (IBAction)cancle:(id)sender {
    for (UILocalNotification *obj in [UIApplication sharedApplication].scheduledLocalNotifications) {
        if ([obj.userInfo.allKeys containsObject:kLocalNotificationKey]) {
            [[UIApplication sharedApplication] cancelLocalNotification:obj];
        }
    }
    //直接取消全部本地通知
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];

}

- (void)sendiOS10LocalNotification
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.body = @"Body:夏目友人帐";
    content.badge = @(1);
    content.title = @"Title:夏目·贵志";
    content.subtitle = @"SubTitle:三三";
    content.categoryIdentifier = kNotificationCategoryIdentifile;
    content.userInfo = @{kLocalNotificationKey: @"iOS10推送"};
    //    content.launchImageName = @"xiamu";
    //推送附件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"0" ofType:@"mp4"];
    NSError *error = nil;
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"AttachmentIdentifile" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    content.attachments = @[attachment];
    
    //推送类型
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Test" content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"iOS 10 发送推送， error：%@", error);
    }];
}

- (void)sendiOS8LocalNotification
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    //触发通知时间
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //重复间隔
    //    localNotification.repeatInterval = kCFCalendarUnitMinute;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    //通知内容
    localNotification.alertBody = @"i am a test local notification";
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    //通知参数
    localNotification.userInfo = @{kLocalNotificationKey: @"iOS8推送"};
    
    localNotification.category = kNotificationCategoryIdentifile;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}



//- (void)sendiOS10LocalNotification
//{
//    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
//    content.body = @"Body:夏目友人帐";
//    content.badge = @(1);
//    content.title = @"Title:夏目·贵志";
//    content.subtitle = @"SubTitle:三三";
//    content.categoryIdentifier = kNotificationCategoryIdentifile;
//    content.userInfo = @{kLocalNotificationKey: @"iOS10推送"};
//    //    content.launchImageName = @"xiamu";
//    //推送附件
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"0" ofType:@"mp4"];
//    NSError *error = nil;
//    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"AttachmentIdentifile" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
//    content.attachments = @[attachment];
//    
//    //推送类型
//    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
//    
//    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Test" content:content trigger:trigger];
//    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
//        NSLog(@"iOS 10 发送推送， error：%@", error);
//    }];
//}
//
//- (void)sendiOS8LocalNotification
//{
//    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    //触发通知时间
//    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
//    //重复间隔
//    //    localNotification.repeatInterval = kCFCalendarUnitMinute;
//    localNotification.timeZone = [NSTimeZone defaultTimeZone];//设置时区，一般设置为 [NSTimeZone defaultTimeZone],跟随手机的时区
//    
//    //通知内容
//    localNotification.alertBody = @"i am a test local notification";
//    localNotification.applicationIconBadgeNumber = 5;//设置提醒后应用程序右上角图标标记
//    localNotification.soundName = UILocalNotificationDefaultSoundName;//设置推送声音，值为声音文件名，默认值为 UILocalNotificationDefaultSoundName ，模拟器无效
//    //localNotification.alertAction = @"呵呵";//设置提醒的按钮文字 / 锁屏时界面底部的闪光文字（滑动来...）
//   
//    //通知参数
//    localNotification.userInfo = @{kLocalNotificationKey: @"iOS8推送"};
//    
//    localNotification.category = kNotificationCategoryIdentifile;//发送通知时，给通知对象设置一个 category 标识符，用于AppDelegate中的配置
//    
//    //调度本地通知 (将本地通知加入本地通知调度池，iOS 7 到这一步完毕，不需要授权)
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//}
@end
