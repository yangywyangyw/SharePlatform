//
//  TBAuthManeger.h
//  SharePlatform
//
//  Created by weiy on 12-8-13.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"

@interface TBAuthManeger : NSObject

@property (copy,nonatomic) NSMutableArray * userIds;

- (void)loginByOAuth;
- (void)responseOutsideRequest:(NSURL*)url;

@end
