//
//  QQShare.h
//  SharePlatform
//
//  Created by weiy on 12-8-16.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TencentOAuth.h"
#import "ShareSDKAbstract.h"

@interface QQShare : ShareSDKAbstract<ShareDelegate,TencentSessionDelegate>{
    TencentOAuth *tencentOAuth;
    NSMutableArray *permisions;
    id<ShareDelegate> delegate;
}

@property (nonatomic,retain) TencentOAuth *tencentOAuth;
@property (nonatomic,retain) NSMutableArray *permissions;
@property (nonatomic,assign) id delegate;

- (void)getUserInfo;
- (bool)isLogin;

@end
