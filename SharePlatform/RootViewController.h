//
//  RootViewController.h
//  SharePlatform
//
//  Created by weiy on 12-8-9.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveUserInfoToServer.h"
@class SinaShare;
@class ShareSDKAbstract;
@class TBAuthManeger;

@interface RootViewController : UIViewController<UITextViewDelegate>

@property (nonatomic,retain) UIButton *loginSinaWeibo;
@property (nonatomic,retain) UIButton *loginTecentWeibo;
@property (nonatomic,retain) UIButton *shareToSinaWeibo;
@property (nonatomic,retain) UIButton *shareToTecentWeibo;
@property (nonatomic,retain) UIButton *loginTB;
@property (nonatomic,retain) UIButton *loginQQ;
@property (nonatomic,retain) UITextView *shareText;
@property (nonatomic,retain) ShareSDKAbstract *sinaShare;
@property (nonatomic,retain) ShareSDKAbstract *tecentShare;
@property (nonatomic,retain) ShareSDKAbstract *qqShare;
@property (nonatomic,retain) TBAuthManeger *taoBaoManager;
@property (nonatomic,retain) SaveUserInfoToServer *saveSinaUserInfo;
@property (nonatomic,retain) SaveUserInfoToServer *saveTXUserInfo;

@end
