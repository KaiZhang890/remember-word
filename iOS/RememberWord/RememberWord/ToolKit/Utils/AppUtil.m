//
//  AppUtil.m
//  buy-sell
//
//  Created by zhangkai on 4/18/16.
//  Copyright © 2016 Kai Zhang. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuild {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (BOOL)isValidMobileNumber:(NSString *)phone {
    NSString *pattern = @"^1[3|4|5|7|8][0-9]{9}$";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange = NSMakeRange(0, phone.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:phone options:NSMatchingReportCompletion range:textRange];
    
    if (matchRange.location == NSNotFound) {
        return NO;
    }
    
    return YES;
}

+ (NSString *)saveImage:(UIImage *)image withFlag:(NSString *)flag {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMdd_HHmmss"];
    NSString *datetime = [formatter stringFromDate:[NSDate date]];
    NSString *filename = nil;
    if (flag) {
        filename = [NSString stringWithFormat:@"%@_%@.jpg", datetime, flag];
    } else {
        filename = [NSString stringWithFormat:@"%@.jpg", datetime];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths firstObject] stringByAppendingPathComponent:filename];
    [UIImageJPEGRepresentation(image, .1) writeToFile:filePath atomically:YES];
    
    return filePath;
}

+ (BOOL)isJailbroken {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return YES;
    }
    return NO;
}

@end
