//
//  ShareSDKAbstract.h
//  SharePlatform
//
//  Created by weiy on 12-8-10.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+CaculateShareTextLength.h"

@protocol ShareDelegate<NSObject>

@optional

- (void)loginSuccess;
- (void)loginFailure;

- (void)sendMsgSucess:(id)result;
- (void)sendMsgFailure;

- (void)getUserInfoSuccess:(id)userInfo;
- (void)getUserInfoFailure;
@end



@interface ShareSDKAbstract : NSObject

- (void)loginByOAuth;
- (void)loginOutByOAuth;

@end
