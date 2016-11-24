//
//  NSString+Helper.h
//  buy-sell
//
//  Created by zhangkai on 3/7/16.
//  Copyright © 2016 Kai Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

- (NSString *)MD5;
- (BOOL)isValidMobileNumber;
- (BOOL)isValidPassword;
- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size;

@end
