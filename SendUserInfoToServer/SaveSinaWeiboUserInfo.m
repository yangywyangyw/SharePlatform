//
//  SaveSinaWeiboUserInfo.m
//  SharePlatform
//
//  Created by weiy on 12-8-18.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "SaveSinaWeiboUserInfo.h"
#import "CommonDefine.h"
#define kWebSiteURL  @"http://buyer.test.hortor.net" //Test Server


@implementation SaveSinaWeiboUserInfo

@synthesize weiboEngine;

- (id)init{
    if (self = [super init]) {
        self.weiboEngine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
        [self.weiboEngine setDelegate:self];
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
    [self.weiboEngine release];
}

- (void)saveUserInfo{
    if (![self.weiboEngine isLoggedIn]) {
        NSLog(@"save sina weibo user information to server failed as no weibo user login..");
        return ;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSLog(@"user id is:%@",weiboEngine.userID);
    [params setObject:weiboEngine.userID forKey:@"uid"];
    [weiboEngine loadRequestWithMethodName:@"users/show.json"
                                httpMethod:@"GET"
                                    params:params
                              postDataType:kWBRequestPostDataTypeNone
                          httpHeaderFields:nil];
}

- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error{
    NSLog(@"get sina weibo user informaiton error:%@",error);
}

- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[result objectForKey:@"name"] forKey:@"user_name"];
    [params setValue:[result objectForKey:@"screen_name"] forKey:@"screen_name"];
    [params setValue:[result objectForKey:@"gender"] forKey:@"gender"];
    [params setValue:weiboEngine.accessToken forKey:@"access_token"];
    [params setValue:[result objectForKey:@"avatar_large"] forKey:@"avatar_large"];
    [params setValue:weiboEngine.userID forKey:@"weibo_id"];
    
    [self startRequestMethod:@"user/register"
                      params:params
                onCompletion:nil
                     onError:nil];
}

@end
