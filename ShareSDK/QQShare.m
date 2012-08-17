//
//  QQShare.m
//  SharePlatform
//
//  Created by weiy on 12-8-16.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "QQShare.h"
#import "CommonDefine.h"

@implementation QQShare

@synthesize tencentOAuth;
@synthesize permissions;
@synthesize delegate;

- (id)init{
    if (self = [super init]) {
        self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:kQQAppKey andDelegate:self];
        permissions =  [[NSArray arrayWithObjects:
                          @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album",
                          @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil] retain];
        tencentOAuth.redirectURI = @"www.qq.com";
    }
    return self;
}

- (void)loginByOAuth{
    [self.tencentOAuth authorize:permissions inSafari:NO];
}

- (void)loginOutByOAuth{
    
}


- (void)getUserInfo{
    [self.tencentOAuth getUserInfo];
}

- (void)getUserInfoResponse:(APIResponse *)response{
    if (response.retCode == URLREQUEST_SUCCEED){
        if ([self.delegate respondsToSelector:@selector(getUserInfoSuccess:)]) {
            [self.delegate getUserInfoSuccess:response];
            NSLog(@"get user information from qq platform success...");
        }
	}
	else {
        if ([self.delegate respondsToSelector:@selector(getUserInfoFailure:)]) {
            [self.delegate getUserInfoFailure];
            NSLog(@"get user information from qq platform falure...");
        }
	}
}

- (void)tencentDidLogin{
    NSLog(@"login qq platform success...");
    if ([self.delegate respondsToSelector:@selector(loginSuccess:)]) {
        [self.delegate loginSuccess];
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        NSLog(@"user cancelled login....");
    }
    else{
        if ([self.delegate respondsToSelector:@selector(loginFailure:)]) {
            [self.delegate loginFailure];
        }
        NSLog(@"login qq platform failed...");
    }
}

@end
