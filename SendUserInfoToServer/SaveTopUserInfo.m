//
//  SaveTopUserInfo.m
//  SharePlatform
//
//  Created by weiy on 12-8-20.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "SaveTopUserInfo.h"
#import "TopAuth.h"

@implementation SaveTopUserInfo

@synthesize topAuth;

- (id)initWithTopAuth:(TopAuth *)topAuthParam{
    
    if (self = [super init]) {
        self.topAuth = topAuthParam;
    }
    return self;
}

- (void)saveUserInfo{
    

}

@end
