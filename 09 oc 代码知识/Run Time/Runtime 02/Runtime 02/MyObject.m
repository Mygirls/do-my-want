//
//  MyObject.m
//  Runtime 02
//
//  Created by JQ on 2017/9/19.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "MyObject.h"
#import <objc/runtime.h>


static NSMutableDictionary *map = nil;

@implementation MyObject


+ (void)load
{
    map = [NSMutableDictionary dictionary];
    map[@"name1"]                = @"name";
    map[@"status1"]              = @"status";
    map[@"name2"]                = @"name";
    map[@"status2"]              = @"status";
}

//上面的代码将两个字典中不同的字段映射到MyObject中相同的属性上，这样，转换方法可如下处理：

//- (void)setDataWithDic:(NSDictionary *)dic
//{
//    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
//        NSString *propertyKey = [self propertyForKey:key];
//        if (propertyKey)
//        {
//            objc_property_t property = class_getProperty([self class], [propertyKey UTF8String]);
//            // TODO: 针对特殊数据类型做处理
//            NSString *attributeString = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
//            //...
//            [self setValue:obj forKey:propertyKey];
//        }
//    }];
//}

//https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html
@end
