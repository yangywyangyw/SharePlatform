//
//  ManageAppKey.h
//  SharePlatform
//
//  Created by weiy on 12-8-9.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ManageAppKey;

@interface ManageAppKey : NSObject{

    NSString *appKey;
	NSString *appSecret;
	NSString *tokenKey;
	NSString *tokenSecret;
	NSString *verifier;
	NSString *response;
}

@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *tokenKey;
@property (nonatomic, copy) NSString *tokenSecret;
@property (nonatomic, copy) NSString *verifier;
@property (nonatomic, copy) NSString *response;

- (void)parseTokenKeyWithResponse:(NSString *)response;

- (void)saveDefaultKey;

@end
