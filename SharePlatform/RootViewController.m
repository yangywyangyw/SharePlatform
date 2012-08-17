//
//  RootViewController.m
//  SharePlatform
//
//  Created by weiy on 12-8-9.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "RootViewController.h"
#import "SinaShare.h"
#import "TecentShare.h"
#import "TBAuthManeger.h"
#import "QQShare.h"

@implementation RootViewController

@synthesize loginSinaWeibo;
@synthesize loginTB;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

- (void)dealloc{
    [super dealloc];
    [self.sinaShare release];
    [self.tecentShare release];
    [self.taoBaoManager release];
    [self.qqShare release];
}

- (void)viewDidLoad{
    
    UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//新建视图
    
    contentView.backgroundColor = [UIColor whiteColor];
    
    self.view = contentView;
    [contentView release];
    
    self.loginSinaWeibo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.loginSinaWeibo.frame = CGRectMake(110.0f, 200.0f, 200.0f, 107.0f);
    [self.loginSinaWeibo setTitle:@"sina weibo" forState:UIControlStateNormal];
    [self.loginSinaWeibo addTarget:self
                           action:@selector(loginSinaIsPressed:)
                 forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.loginSinaWeibo];
    
    self.shareToSinaWeibo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.shareToSinaWeibo.frame = CGRectMake(310.0f, 200.0f, 200.0f, 107.0f);
    [self.shareToSinaWeibo setTitle:@"share to sina" forState:UIControlStateNormal];
    [self.shareToSinaWeibo addTarget:self
                            action:@selector(shareToSina:)
                  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.shareToSinaWeibo];
    
    
    self.loginTecentWeibo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.loginTecentWeibo.frame = CGRectMake(110.0f, 350.0f, 200.0f, 107.0f);
    [self.loginTecentWeibo setTitle:@"tecent weibo" forState:UIControlStateNormal];
    [self.loginTecentWeibo addTarget:self
                              action:@selector(loginTecentIsPressed:)
                    forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.loginTecentWeibo];

    self.shareToTecentWeibo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.shareToTecentWeibo.frame = CGRectMake(310.0f, 350.0f, 200.0f, 107.0f);
    [self.shareToTecentWeibo setTitle:@"share to tecent" forState:UIControlStateNormal];
    [self.shareToTecentWeibo addTarget:self
                                action:@selector(shareToTecent:)
                      forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.shareToTecentWeibo];
    
    self.loginTB = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.loginTB.frame = CGRectMake(110.0f, 500.0f, 200.0f, 107.0f);
    [self.loginTB setTitle:@"login taobao" forState:UIControlStateNormal];
    [self.loginTB addTarget:self action:@selector(loginTBFunc:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.loginTB];
    
    self.loginQQ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.loginQQ.frame = CGRectMake(110.0f, 650, 200.0f, 107.0f);
    [self.loginQQ setTitle:@"login qq" forState:UIControlStateNormal];
    [self.loginQQ addTarget:self action:@selector(loginQQFunc:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.loginQQ];
    
    self.shareText = [[UITextView alloc] initWithFrame:self.view.frame];
    self.shareText.frame = CGRectMake(0,0, 357, 252);
    self.shareText.backgroundColor = [UIColor clearColor];
    self.shareText.font = [UIFont systemFontOfSize:16.f];
    self.shareText.delegate = self;
    self.shareText.text = @"测试例子，看看就行，工作呢现在。。。";
    [self.view addSubview:self.shareText];
    [self.shareText release];

    
    self.sinaShare = [[SinaShare alloc] initWithRootController:self];
    self.tecentShare = [[TecentShare alloc] init];
    self.taoBaoManager = [[TBAuthManeger alloc] init];
    self.qqShare = [[QQShare alloc] init];
    ((QQShare*)(self.qqShare)).delegate = self;
}

- (void)loginQQFunc:(id)sender{
    [self.qqShare loginByOAuth];
}

- (void)loginTBFunc:(id)sender{
    [self.taoBaoManager loginByOAuth];
}


- (void)textViewDidChange:(UITextView *)textView
{
    //int maxLength = 140;
    int shareTextLength = [self.shareText.text getRealiableTextLength];
 /*   if(shareTextLength >= maxLength){
        self.shareText.text = [self.shareText.text substringToIndex:maxLength];
    }*/
    
    NSInteger length = 140 - shareTextLength;
   // self.shareText.text = [NSString stringWithFormat:@"还可以输入%d字",length];
    NSLog(@"还可以输入%d",length);
}



- (void)shareToSina:(id)sender{
    [self.sinaShare shareWithText:self.shareText.text AndPicture:[UIImage imageNamed:@"info_bkg.png"]];
}

- (void)shareToTecent:(id)sender{
    [self.tecentShare shareWithText:self.shareText.text AndPicture:[UIImage imageNamed:@"info_bkg.png"]];
}

- (void)loginSinaIsPressed:(id)sender{
    if ([self.sinaShare sinaEngine] != nil) {
        [self.sinaShare loginByOAuth];
    }
}

- (void)loginTecentIsPressed:(id)sender{
    if (self.tecentShare != nil) {
        [self.tecentShare loginByOAuth];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
