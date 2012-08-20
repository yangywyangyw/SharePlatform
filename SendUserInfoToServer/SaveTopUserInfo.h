//
//  SaveTopUserInfo.h
//  SharePlatform
//
//  Created by weiy on 12-8-20.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "SaveUserInfoToServer.h"

@class TopAuth;
@interface SaveTopUserInfo : SaveUserInfoToServer{
    TopAuth *topAuth;
}

@property (nonatomic,retain) TopAuth* topAuth;

- (void)saveUserInfo;

- (id)initWithTopAuth:(TopAuth*)topAuth;

@end
