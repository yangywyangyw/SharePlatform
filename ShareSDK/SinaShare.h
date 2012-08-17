//
//  SinaShare.h
//  SharePlatform
//
//  Created by weiy on 12-8-9.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBEngine.h"
#import "CommonDefine.h"
#import "ShareSDKAbstract.h"


@interface SinaShare : ShareSDKAbstract<WBEngineDelegate>{
 
 @private
    WBEngine *_sinaEngine;
    id <ShareDelegate> _delegate;
}

@property (nonatomic,retain) WBEngine *sinaEngine;
@property (nonatomic,assign) id delegate;

- (id)initWithRootController:(UIViewController*)controller;
- (void)loginByOAuth;
- (void)loginOutByOAuth;
- (bool)shareWithText:(NSString*)text AndPicture:(UIImage*)image;

@end
