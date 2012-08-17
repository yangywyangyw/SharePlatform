//
//  TecentShare.h
//  SharePlatform
//
//  Created by weiy on 12-8-9.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDefine.h"
#import "ShareSDKAbstract.h"
#import "WBAuthorizeWebView.h"

@class ManageAppKey;

@interface TecentShare : ShareSDKAbstract<ShareDelegate,NSURLConnectionDataDelegate,UIWebViewDelegate,WBAuthorizeWebViewDelegate>{
    
    ManageAppKey *manageAppKey;
    NSURLConnection *connection;
    NSMutableData *resultData;
    id <ShareDelegate> delegate;
    WBAuthorizeWebView *authView;
    UIViewController *rootView_;
    
}
@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) NSURLConnection *connection;
@property (nonatomic,retain) NSMutableData *resultData;

- (void)loginByOAuth;
- (void)loginOutByOAuth;
- (bool)shareWithText:(NSString*)text AndPicture:(UIImage*)image;
- (bool)isLogin;
- (id)initWithRootVC:(UIViewController*)rootView;

@end
