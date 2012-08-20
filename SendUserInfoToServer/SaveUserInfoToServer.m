//
//  SaveUserInfoToServer.m
//  SharePlatform
//
//  Created by weiy on 12-8-17.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "SaveUserInfoToServer.h"
#import "WBEngine.h"

#import "ASIFormDataRequest.h"
#import "UIDevice+IdentifierAddition.h"
#import "Utils.h"

#define kWebSiteURL  @"http://buyer.test.hortor.net" //Test Server


@implementation SaveUserInfoToServer

@synthesize requestList;

- (void)saveUserInfo{

}

- (void)startRequestMethod:(NSString *)method
                    params:(NSDictionary *)params
              onCompletion:(FunMatchEngineRequestCompletion)onCompletion
                   onError:(FunMatchEngineRequestError)onError
{
    //  NSLog(@"===========request method:%@=============", method);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", kWebSiteURL, method]];
    
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    _currentRequest = request;
    [self.requestList addObject:request];
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceSn = [device uniqueDeviceIdentifier];
    NSString *iosVersion = [device systemVersion];
    NSInteger deviceType = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 1 : 2;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary]; //取出info文件里面的信息
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    [request addPostValue:[NSNumber numberWithInt:deviceType] forKey:@"device_type"]; //设备类型
    [request addPostValue:deviceSn forKey:@"device_sn"]; //设备编号
    [request addPostValue:iosVersion forKey:@"ios_version"];  //客户端应用名及版本
    [request addPostValue:appVersion forKey:@"app_verion"];   //操作系统版本号
    
    for (NSString *key in [params keyEnumerator])
    {
        [request addPostValue:[params valueForKey:key] forKey:key];
    }
    
    [request setCompletionBlock:^{
        
        NSDictionary *jsonData = [request.responseString objectFromJSONString];
        //  NSLog(@"response jsonData:%@", jsonData);
        NSInteger statusCode = [[jsonData valueForKey:@"status_code"] intValue];
        if (statusCode == 0 && ![jsonData isKindOfClass:[NSNull class]] && jsonData != nil) {
            if (onCompletion != nil) {
                onCompletion(jsonData);
            }
            NSLog(@"save user inforamtion to server success....");
        } else {
            NSString *errorMsg = [jsonData valueForKey:@"error_msg"];
            if (errorMsg == nil) errorMsg = @"";
            NSError *error = [NSError errorWithDomain:@"funMatch" code:statusCode userInfo:[NSDictionary dictionaryWithObject:errorMsg forKey:@"error_msg"]];
            if (onError != nil) {
                onError(error);
            }
            NSLog(@"save user information to server failed:%@",error);
        }
        [self.requestList removeObject:request];
    }];
    [request setFailedBlock:^{
        [self.requestList removeObject:request];
        NSLog(@"save user information to server failed....");
    }];
    [request startAsynchronous];
    [deviceSn release];
}


@end
