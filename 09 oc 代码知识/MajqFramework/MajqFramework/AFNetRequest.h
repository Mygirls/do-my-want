//
//  AFNetRequest.h
//  MajqFramework
//
//  Created by JQ on 2017/9/3.
//  Copyright © 2017年 majq. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CompletionLoad)(id result);

@interface AFNetRequest : NSObject


+ (void)requestWithURL:(NSString *)url
                params:(NSMutableDictionary *)params
            httpMethod:(NSString *)httpMethod
                 block:(CompletionLoad)block;
@end
