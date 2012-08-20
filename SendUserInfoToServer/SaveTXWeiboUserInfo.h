//
//  SaveTXWeiboUserInfo.h
//  SharePlatform
//
//  Created by weiy on 12-8-18.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "SaveUserInfoToServer.h"

@interface SaveTXWeiboUserInfo : SaveUserInfoToServer{
    
    NSString *tokenKey;
    NSString *tokenSecret;
    NSMutableData *resultData;
}

- (id)initWithTokenKey:(NSString*)tokenKey AndTokenSecret:(NSString*)tokenSecret;
- (void)saveUserInfo;

@end
