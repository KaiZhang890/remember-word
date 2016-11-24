//
//  Macros.h
//  Template
//
//  Created by zhangkai on 9/3/14.
//  Copyright (c) 2014 Kai Zhang. All rights reserved.
//

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define WinSize CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define WinCenter CGPointMake(WinSize.width / 2, WinSize.height / 2)

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                alpha:1.0]

#define Alert(title,msg) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:NSLocalizedString(@"知道了", nil) otherButtonTitles:nil, nil] show]
#define TRIM_STRING(string) [(string) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS_VERSION_LESS_THAN(__VERSIONSTRING) ([[[UIDevice currentDevice] systemVersion] compare:__VERSIONSTRING options:NSNumericSearch] == NSOrderedAscending)

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * 0.01745329252f) // PI / 180
#define RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 57.29577951f) // PI * 180

/*
 * if DEBUG is not defined, or if it is 0 then
 * all DLOGXXX macros will be disabled
 *
 * if DEBUG==1 then:
 * DLOG() will be enabled
 * DLOGERROR() will be enabled
 * DLOGINFO()will be disabled
 *
 * if DEBUG==2 or higher then:
 * DLOG() will be enabled
 * DLOGERROR() will be enabled
 * DLOGINFO()will be enabled
 */
#if !defined(DEBUG) || DEBUG == 0
#define DLOG(format, ...) do {} while (0)
#define DLOGINFO(format, ...) do {} while (0)
#define DLOGERROR(format, ...) do {} while (0)

#elif DEBUG == 1
#define DLOG(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DLOGERROR(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DLOGINFO(format, ...) do {} while (0)

#elif DEBUG > 1
#define DLOG(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DLOGERROR(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DLOGINFO(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif
