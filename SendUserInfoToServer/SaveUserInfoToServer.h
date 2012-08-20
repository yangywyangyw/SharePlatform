//
//  SaveUserInfoToServer.h
//  SharePlatform
//
//  Created by weiy on 12-8-17.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FunMatchEngineRequestCompletion)(id result);
typedef void (^FunMatchEngineRequestError)(NSError *error);

@class ASIFormDataRequest;

@interface SaveUserInfoToServer : NSObject{
    ASIFormDataRequest *_currentRequest;
}


@property (nonatomic, retain) NSMutableArray *requestList;

- (void)saveUserInfo;
- (void)startRequestMethod:(NSString *)method
                    params:(NSDictionary *)params
              onCompletion:(FunMatchEngineRequestCompletion)onCompletion
                   onError:(FunMatchEngineRequestError)onError;

@end
