//
//  AFNetRequest.m
//  MajqFramework
//
//  Created by JQ on 2017/9/3.
//  Copyright © 2017年 majq. All rights reserved.
//

#import "AFNetRequest.h"
#import "AFNetworking.h"
#import<CommonCrypto/CommonDigest.h>

#define NETWORK_URL @"https://b.baiyimao.com/baiyimao_api_b/Product/"


@implementation AFNetRequest

#pragma mark - AFNetworking 3.1
+ (void)requestWithURL:(NSString *)url
                params:(NSMutableDictionary *)params
            httpMethod:(NSString *)httpMethod
                 block:(CompletionLoad)block{
    
    
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@%@",NETWORK_URL,url];
    
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    //af设置请求头
    [manager.requestSerializer setValue:[self md5:@"bym@201505"] forHTTPHeaderField:@"certification"];
    
    if ([httpMethod isEqualToString:@"GET"]) {  // 如果是get请求
        [manager GET:urlStr  parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            // 这里可以获取到目前的数据请求的进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            if (block) {
                block(dic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求失败
            if (block) {                        //NSLog(@"%@", [error localizedDescription]);
                block(error);
            }
        }];
        
    }else if ([httpMethod isEqualToString:@"POST"]) {
        [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            if (block) {
                block(dic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (block) {
                block(error);
            }
        }];
        
        /*
         // 使用下面这个方法时候 参数传不到服务器，会显示参数错误
         [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id  _Nonnull formData) {
         // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
         
         } progress:^(NSProgress * _Nonnull uploadProgress) {
         // 这里可以获取到目前的数据请求的进度
         
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         // 请求成功，解析数据NSLog(@"%@", responseObject);
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
         if (block) {
         block(dic);
         }
         
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         // 请求失败
         if (block) {//NSLog(@"%@", [error localizedDescription]);
         block(error);
         }
         }];
         
         */
    }
}



#pragma mark - 创建多部件请求的上传任务，具有进度
- (void)uploadWithUser:(NSString *)userId UrlString:(NSString *)urlString upImg:(UIImage *)upImg
{
    // 创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 参数
    NSDictionary *param = @{@"user_id":userId};
    [manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        NSData *data = UIImagePNGRepresentation(upImg);
        // 拼接数据到请求题中
        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];


}


- (void) aaa {
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //formData appendPartWithFileData:<#(nonnull NSData *)#> name:<#(nonnull NSString *)#> fileName:<#(nonnull NSString *)#> mimeType:<#(nonnull NSString *)#>
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
        
    } error:nil];
    request.timeoutInterval = 10;

    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    
    NSURLSessionUploadTask *uploadTask;
    
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        // This is not called back on the main queue.(这在主队列上不被调用)
        // You are responsible for dispatching to the main queue for UI updates(您负责向主队列发送UI更新)
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update the progress view(更新进度视图)
            //[progressView setProgress:uploadProgress.fractionCompleted];
            NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            
        });
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
        
    }];
    
    [uploadTask resume]; //开始网络请求任务(必须要)

}

/**
 *  md5加密
 *
 */
+ (NSString *)md5:(NSString*)origString
{
    const char *original_str = [origString UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, strlen(original_str), result);//调用md5
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    
    return hash;
}


@end
