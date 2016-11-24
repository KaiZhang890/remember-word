//
//  AppUtil.h
//  buy-sell
//
//  Created by zhangkai on 4/18/16.
//  Copyright © 2016 Kai Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppUtil : NSObject

/**
 * 获取app版本信息
 */
+ (NSString *)appVersion;
+ (NSString *)appBuild;

/**
 * 手机号是否有效
 */
+ (BOOL)isValidMobileNumber:(NSString *)phone;

/**
 * save image to NSDocumentDirectory, YYYYMMdd_HHmmss_flag.jpg
 */
+ (NSString *)saveImage:(UIImage *)image withFlag:(NSString *)flag;

/**
 * 是否越狱
 */
+ (BOOL)isJailbroken;

@end
