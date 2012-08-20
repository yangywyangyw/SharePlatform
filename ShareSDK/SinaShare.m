//
//  SinaShare.m
//  SharePlatform
//
//  Created by weiy on 12-8-9.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "SinaShare.h"

@implementation SinaShare


@synthesize sinaEngine = _sinaEngine;
@synthesize delegate = _delegate;


- (id)init{

    if (self = [super init]) {
        WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
        //[engine setRootViewController:self];
        [engine setDelegate:self];
        [engine setRedirectURI:@"http://"];
        [engine setIsUserExclusive:NO];
        self.sinaEngine = engine;
        [engine release];
    }
    return self;
}

- (id)initWithRootController:(UIViewController *)controller{
    if (self = [self init]) {
        [self.sinaEngine setRootViewController:controller];
    }
    return self;
}

- (void)loginByOAuth{
    [self.sinaEngine logIn];
}


- (bool)shareWithText:(NSString *)text AndPicture:(UIImage *)image{
    if ([text isEqualToString:@""]) {
        NSLog(@"share to sina weibo failed as share text is null");
        return NO;
    }
    if ([text length] > 140) {
        NSLog(@"share to sina weibo failed as text length too large(more than 140)");
        return NO;
    }
    if ([_sinaEngine isAuthorizeExpired]) {
        [self loginByOAuth];
        NSLog(@"share to sina weibo failed as authorize expired!");
        return NO;
    }
    [self.sinaEngine sendWeiBoWithText:text image:image];
    return YES;
}

- (void)loginOutByOAuth{
    [self.sinaEngine logOut];
}

#pragma mark - WBEngineDelegate Methods
#pragma mark Authorize

- (void)engineAlreadyLoggedIn:(WBEngine *)engine{
    if ([self.delegate respondsToSelector:@selector(alreadyLogin:)]) {
        [self.delegate alreadyLogin];
    }
    NSLog(@"all ready login sina weibo!");
}

- (void)engineDiNSLogIn:(WBEngine *)engine{
    if ([self.delegate respondsToSelector:@selector(loginSuccess:)]) {
        [self.delegate loginSuccess];
    }
    NSLog(@"login sina weibo success...");
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(loginFailure:)]) {
        [self.delegate loginFailure];
    }
    NSLog(@"login sina weibo error: %@", error);
}

- (void)engineDiNSLogOut:(WBEngine *)engine{
    if ([self.delegate respondsToSelector:@selector(logoutSuccess:)]) {
        [self.delegate logoutSuccess];
    }
    NSLog(@"logout sinaweibo sucess...");
}

- (void)engineAuthorizeExpired:(WBEngine *)engine{
    if ([self.delegate respondsToSelector:@selector(authExpired:)]) {
        [self.delegate authExpired];
    }
    NSLog(@"sina weibo authrisize expried..");
}

- (void)engine:(WBEngine*)engine requestDidSucceedWithResult:(id)result{
    if ([self.delegate respondsToSelector:@selector(sendMsgSucess:)]) {
        [self.delegate sendMsgSucess:result];
    }
    NSLog(@"share message to sina weibo successful..");
}

- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(sendMsgFailure:)]) {
        [self.delegate sendMsgFailure];
    }
    NSLog(@"share message to sina weibo failed..");

}
@end
