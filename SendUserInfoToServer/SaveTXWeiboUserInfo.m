//
//  SaveTXWeiboUserInfo.m
//  SharePlatform
//
//  Created by weiy on 12-8-18.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "SaveTXWeiboUserInfo.h"
#import "QWeiboRequest.h"
#import "CommonDefine.h"
#import "QOauthKey.h"
#import "NSDictionary+BSJSONAdditions.h"


@implementation SaveTXWeiboUserInfo

- (id)initWithTokenKey:(NSString *)tokenKeyParam AndTokenSecret:(NSString *)tokenSecretParam{
    if (self = [super init]) {
        tokenKey = tokenKeyParam;
        tokenSecret = tokenSecretParam;
        resultData = [[NSMutableData alloc] init];
    }
    return self;
}

- (void)dealloc{
    [super dealloc];
    [resultData release];
}

- (void)saveUserInfo{
    NSString *url = @"http://open.t.qq.com/api/user/info";
	
	QOauthKey *oauthKey = [[QOauthKey alloc] init];
	oauthKey.consumerKey = kQWBSDKAppKey;
	oauthKey.consumerSecret = kQWBSDKAppSecret;
	oauthKey.tokenKey = tokenKey;
	oauthKey.tokenSecret= tokenSecret;
	
	NSString *format = @"json";

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	[parameters setObject:format forKey:@"format"];
	
	QWeiboRequest *request = [[QWeiboRequest alloc] init];
	[request asyncRequestWithUrl:url httpMethod:@"GET" oauthKey:oauthKey parameters:parameters files:nil delegate:self];
	
	[request release];
	[oauthKey release];
}

#pragma mark -
#pragma mark NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [resultData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //resultData = [NSMutableData data] ;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *strResponse = [[[NSString alloc] initWithData:resultData
                                                   encoding:NSUTF8StringEncoding] autorelease];
   // NSLog(@"response string is:%@",strResponse);
    NSRange range = [strResponse rangeOfString:@"\"msg\":\"ok\""];
    if (range.location == NSNotFound) {
        NSLog(@"get tencent weibo user information failed...");
    }
    else{
        NSLog(@"get tencent weibo user information success...");
        NSDictionary *retDic = [NSDictionary dictionaryWithJSONString:strResponse];
       // NSLog(@"user info:%@",retDic);
        NSMutableDictionary *userInfo = [retDic objectForKey:@"data"];
        //NSLog(@"user info:%@",userInfo);
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:[userInfo objectForKey:@"name"] forKey:@"user_name"];
        [params setValue:[userInfo objectForKey:@"nick"] forKey:@"screen_name"];
        [params setValue:[userInfo objectForKey:@"sex"] forKey:@"gender"];
        [params setValue:[NSString stringWithFormat:@"token_key=%@,token_secret=%@",tokenKey,tokenSecret] forKey:@"access_token"];
        [params setValue:[userInfo objectForKey:@"head"] forKey:@"avatar_large"];
        [params setValue:[userInfo objectForKey:@"openid"] forKey:@"weibo_id"];
        
        [self startRequestMethod:@"user/register"
                          params:params
                    onCompletion:nil
                         onError:nil];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"get tencent weibo user information failed:%@",error);
}

@end
