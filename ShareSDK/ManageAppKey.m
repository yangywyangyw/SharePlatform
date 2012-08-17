//
//  ManageAppKey.m
//  SharePlatform
//
//  Created by weiy on 12-8-9.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "ManageAppKey.h"
#import "CommonDefine.h"

#define AppKey			@"appKey"
#define AppSecret		@"appSecret"
#define AppTokenKey		@"tokenKey"
#define AppTokenSecret	@"tokenSecret"

@implementation ManageAppKey


@synthesize appKey;
@synthesize appSecret;
@synthesize tokenKey;
@synthesize tokenSecret;
@synthesize verifier;
@synthesize response;


- (id)init{
    if (self = [super init]) {
        self.appKey = kQWBSDKAppKey;
        self.appSecret = kQWBSDKAppSecret;
        [self loadDefaultKey];
    }
    return self;
}

- (void)parseTokenKeyWithResponse:(NSString *)aResponse {
	
	NSDictionary *params = [NSURL parseURLQueryString:aResponse];
	self.tokenKey = [params objectForKey:@"oauth_token"];
	self.tokenSecret = [params objectForKey:@"oauth_token_secret"];
	
}

- (void)saveDefaultKey {
	
	[[NSUserDefaults standardUserDefaults] setValue:self.appKey forKey:AppKey];
	[[NSUserDefaults standardUserDefaults] setValue:self.appSecret forKey:AppSecret];
	[[NSUserDefaults standardUserDefaults] setValue:self.tokenKey forKey:AppTokenKey];
	[[NSUserDefaults standardUserDefaults] setValue:self.tokenSecret forKey:AppTokenSecret];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadDefaultKey {
	
	self.appKey = [[NSUserDefaults standardUserDefaults] valueForKey:AppKey];
	self.appSecret = [[NSUserDefaults standardUserDefaults] valueForKey:AppSecret];
	self.tokenKey = [[NSUserDefaults standardUserDefaults] valueForKey:AppTokenKey];
	self.tokenSecret = [[NSUserDefaults standardUserDefaults] valueForKey:AppTokenSecret];
}

@end
