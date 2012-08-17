//
//  TBAuthManeger.m
//  SharePlatform
//
//  Created by weiy on 12-8-13.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "TBAuthManeger.h"
#import "TopIOSClient.h"

@implementation TBAuthManeger


@synthesize userIds;

- (id)init{
    if (self = [super init]) {
        [TopIOSClient registerIOSClient:kTBSDKAppKey appSecret:kTBSDKAppSecret callbackUrl:kTBCallFuncUrl needAutoRefreshToken:true];
        userIds = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
    [userIds release];
    userIds = nil;
}

- (void)loginByOAuth{
    TopIOSClient *iosClient = [TopIOSClient getIOSClientByAppKey:kTBSDKAppKey];
    [iosClient auth:self cb:@selector(authCallback:)];

}

- (void)responseOutsideRequest:(NSURL *)url{
    TopIOSClient *iosClient = [TopIOSClient getIOSClientByAppKey:kTBSDKAppKey];
    [iosClient authCallback:url];
}

-(void)authCallback:(id)data
{
    if ([data isKindOfClass:[TopAuth class]])
    {
        TopAuth *auth = (TopAuth *)data;
        [userIds addObject:[auth user_id]];
        NSLog(@"%@",[auth user_id]);
    }
    else
    {
        NSLog(@"%@",data);
    }
}

@end
