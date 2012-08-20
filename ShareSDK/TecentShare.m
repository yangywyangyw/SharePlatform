//
//  TecentShare.m
//  SharePlatform
//
//  Created by weiy on 12-8-9.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "TecentShare.h"
#import "QWeiboSyncApi.h"
#import "ManageAppKey.h"
#import "WBAuthorizeWebView.h"
#import "QWeiboAsyncApi.h"

#define VERIFY_URL @"http://open.t.qq.com/cgi-bin/authorize?oauth_token="


@implementation TecentShare

@synthesize connection = _connection;
@synthesize resultData;
@synthesize delegate;
@synthesize manageAppKey;

- (id)init{
    if (self = [super init]) {
        manageAppKey = [[ManageAppKey alloc] init];
        authView = [[WBAuthorizeWebView alloc] init];
        NSLog(@"when init:\n%@\n%@\n%@\n%@",manageAppKey.appKey,manageAppKey.appSecret,manageAppKey.tokenKey,manageAppKey.tokenSecret);
    }
    return self;
}

- (id)initWithRootVC:(UIViewController*)rootView{
    if (self = [self init]) {
        rootView_ = rootView;
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
    [manageAppKey release];
    manageAppKey = nil;
    [authView release];
    authView = nil;
}

- (void)loginByOAuth{
    
	
    QWeiboSyncApi *api = [[[QWeiboSyncApi alloc] init] autorelease];
    NSString *retString = [api getRequestTokenWithConsumerKey:kQWBSDKAppKey consumerSecret:kQWBSDKAppSecret];
    NSLog(@"Get requestToken:%@", retString);
    
    [manageAppKey parseTokenKeyWithResponse:retString];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", VERIFY_URL, manageAppKey.tokenKey];
	NSURL *requestUrl = [NSURL URLWithString:url];
	//NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    
    [authView setDelegate:self];
    [authView loadRequestWithURL:requestUrl];
    //[webView loadRequestWithURL:[NSURL URLWithString:urlString]];
    [authView show:YES];
    authView.webView.delegate = self;
   // [authView release];
    
}

- (NSString*) valueForKey:(NSString *)key ofQuery:(NSString*)query
{
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	for(NSString *aPair in pairs){
		NSArray *keyAndValue = [aPair componentsSeparatedByString:@"="];
		if([keyAndValue count] != 2) continue;
		if([[keyAndValue objectAtIndex:0] isEqualToString:key]){
			return [keyAndValue objectAtIndex:1];
		}
	}
	return nil;
}

- (void)loginOutByOAuth{
    manageAppKey.tokenSecret = nil;
    manageAppKey.tokenKey = nil;
    [manageAppKey saveDefaultKey];
}

- (bool)isLogin{
    if (manageAppKey.tokenKey && ![manageAppKey.tokenKey isEqualToString:@""]
        && manageAppKey.tokenSecret && ![manageAppKey.tokenSecret isEqualToString:@""]) {
        return true;
    }
    return false;
}

- (bool)shareWithText:(NSString *)text AndPicture:(UIImage *)image{
    
    NSLog(@"when share:\n%@\n%@\n%@\n%@",manageAppKey.appKey,manageAppKey.appSecret,manageAppKey.tokenKey,manageAppKey.tokenSecret);
	NSString *filePath = [NSTemporaryDirectory() stringByAppendingFormat:@"temp.png"];
	[UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
	
    
    QWeiboAsyncApi *api = [[[QWeiboAsyncApi alloc] init] autorelease];
	
	self.connection	= [api publishMsgWithConsumerKey:manageAppKey.appKey
									  consumerSecret:manageAppKey.appSecret
									  accessTokenKey:manageAppKey.tokenKey
								   accessTokenSecret:manageAppKey.tokenSecret
											 content:text
										   imageFile:filePath
										  resultType:RESULTTYPE_JSON
											delegate:self];
    
    return YES;
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *query = [[request URL] query];
    NSLog(@"query is :%@",query);
	NSString *verifier = [self valueForKey:@"oauth_verifier" ofQuery:query];
	NSLog(@"verifier is :%@",verifier);
	if (verifier && ![verifier isEqualToString:@""]) {
		
        
		QWeiboSyncApi *api = [[[QWeiboSyncApi alloc] init] autorelease];
		NSString *retString = [api getAccessTokenWithConsumerKey:manageAppKey.appKey
												  consumerSecret:manageAppKey.appSecret
												 requestTokenKey:manageAppKey.tokenKey
											  requestTokenSecret:manageAppKey.tokenSecret
														  verify:verifier];
        	NSLog(@"\nget access token:%@", retString);
		[manageAppKey parseTokenKeyWithResponse:retString];
		[manageAppKey saveDefaultKey];
        
        if ([[self delegate] respondsToSelector:@selector(loginSuccess:)]) {
            [delegate loginSuccess];
        }
    //    NSLog(@"after login:\n%@\n%@\n%@\n%@",manageAppKey.appKey,manageAppKey.appSecret,manageAppKey.tokenKey,manageAppKey.tokenSecret);
        [authView hide:NO];
        return NO;
	}
    return YES;
}


#pragma mark -
#pragma mark NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [resultData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.resultData = [NSMutableData data] ;
    //  NSLog(@"total = %d", [response expectedContentLength]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    self.connection = nil;
    NSString *strResponse = [[[NSString alloc] initWithData:self.resultData
                                                   encoding:NSUTF8StringEncoding] autorelease];
    NSRange range = [strResponse rangeOfString:@"\"msg\":\"ok\""];
    if (range.location == NSNotFound) {
        if ([[self delegate] respondsToSelector:@selector(sendMsgFailure:)]) {
            [delegate sendMsgFailure];
        }
        NSLog(@"share message to tecent weibo failed...");
    }
    else{
        if ([[self delegate] respondsToSelector:@selector(sendMsgSucess:)]) {
            [delegate sendMsgSucess:resultData];
        }
        NSLog(@"share message to tecent weibo success.....");
    }
    //    NSLog(@"%@",strResponse);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if ([[self delegate] respondsToSelector:@selector(sendMsgFailure:)]) {
        [delegate sendMsgFailure];
    }
    self.connection = nil;
    NSLog(@"share message to tecent weibo failure:%@",error);
}


@end
