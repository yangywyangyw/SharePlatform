//
//  LoginManager.m
//  SharePlatform
//
//  Created by weiy on 12-8-18.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "ShareSDKAbstract.h"
#import "LoginManager.h"
#import "SinaShare.h"
#import "TecentShare.h"
#import "TBAuthManeger.h"
#import "QQShare.h"


@implementation LoginManager

- (void)otherPlatformLogin:(LoginType)currentLogin
               LoginedType:(LoginType*)loginedType
              AddtionParam:(NSMutableDictionary**)additionParam{
    
    ShareSDKAbstract *sinaShare = [[[SinaShare alloc] init] autorelease];
    ShareSDKAbstract *tecentShare = [[[TecentShare alloc] init] autorelease];
    TBAuthManeger *tbAuthManager = [[[TBAuthManeger alloc] init] autorelease];
    ShareSDKAbstract *qqShare = [[[QQShare alloc] init] autorelease];
    
    (*loginedType) = NO_PLATFORM_LOGIN;
    
    if ([sinaShare isLogin] && currentLogin != SINA_WEIBO_LOGIN) {
        (*loginedType) = SINA_WEIBO_LOGIN;
        [(*additionParam) setObject:[((SinaShare*)sinaShare).sinaEngine userID] forKey:@"sina_id"];
    }
    else if([tecentShare isLogin] && currentLogin != TENCENT_WEIBO_LOGIN){
        (*loginedType) = TENCENT_WEIBO_LOGIN;
      //  (*additionParam) setObject:[((TecentShare*)tecentShare).manageAppKey ] forKey:<#(id)#>
    }
    else if([tbAuthManager isLogin] && currentLogin != TOP_LOGIN){
        (*loginedType) = TOP_LOGIN;
    }
    else if([qqShare isLogin] && currentLogin != QQ_LOGIN){
        (*loginedType) = QQ_LOGIN;
    }
    
}

@end
