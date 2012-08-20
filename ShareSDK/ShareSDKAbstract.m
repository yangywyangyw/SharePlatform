//
//  ShareSDKAbstract.m
//  SharePlatform
//
//  Created by weiy on 12-8-10.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "ShareSDKAbstract.h"

@implementation ShareSDKAbstract

- (void)loginOutByOAuth{
}

- (void)loginByOAuth{
}

- (bool)shareWithText:(NSString *)text AndPicture:(UIImage *)image{

    return false;
}

- (bool)isLogin{

    return false;
}

@end
