//
//  NSString+CaculateShareTextLength.m
//  SharePlatform
//
//  Created by weiy on 12-8-13.
//  Copyright (c) 2012年 weiy. All rights reserved.
//

#import "NSString+CaculateShareTextLength.h"

@implementation NSString (CaculateShareTextLength)

- (int)getRealiableTextLength
{
    float number = 0.0;
    for (int index = 0; index < [self length]; index++)
    {
        NSString *character = [self substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number++;
        }
        else
        {
            number = number + 0.5;
        }
    }
    return ceil(number);
}

@end
