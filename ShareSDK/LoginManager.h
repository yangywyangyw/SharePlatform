//
//  LoginManager.h
//  SharePlatform
//
//  Created by weiy on 12-8-18.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    NO_PLATFORM_LOGIN,
    TENCENT_WEIBO_LOGIN,
    SINA_WEIBO_LOGIN,
    QQ_LOGIN,
    TOP_LOGIN
}LoginType;

@interface LoginManager : NSObject

- (void)otherPlatformLogin:(LoginType)currentLogin //in
               LoginedType:(LoginType*)loginedType //out
              AddtionParam:(NSMutableDictionary**)additionParam; //out

@end
