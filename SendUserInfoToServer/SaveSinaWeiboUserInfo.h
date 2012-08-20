//
//  SaveSinaWeiboUserInfo.h
//  SharePlatform
//
//  Created by weiy on 12-8-18.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "SaveUserInfoToServer.h"
#import "WBEngine.h"

@interface SaveSinaWeiboUserInfo : SaveUserInfoToServer<WBEngineDelegate>{
    WBEngine *weiboEngine;
}

@property (nonatomic,retain) WBEngine *weiboEngine;

- (void)saveUserInfo;

@end
