//
//  NSString+Helper.m
//  buy-sell
//
//  Created by zhangkai on 3/7/16.
//  Copyright © 2016 Kai Zhang. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Helper)

- (NSString *)MD5 {
    // 用UTF16LittleEndian编码将字符串解码为字节数组，然后对该字节数组进行MD5编码，编码后返回16进制字符串。
//    NSData *data = [self dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned int outputLength = CC_MD5_DIGEST_LENGTH;
    unsigned char output[outputLength];
    CC_MD5(data.bytes, (unsigned int) data.length, output);
    
    NSMutableString* hash = [NSMutableString stringWithCapacity:outputLength * 2];
    for (unsigned int i = 0; i < outputLength; i++) {
        [hash appendFormat:@"%02x", output[i]];
        output[i] = 0;
    }
    return hash;
}

- (BOOL)isValidMobileNumber {
    NSString *pattern = @"^1[3|4|5|7|8][0-9]{9}$";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange = NSMakeRange(0, self.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:self options:NSMatchingReportCompletion range:textRange];
    
    if (matchRange.location == NSNotFound) {
        return NO;
    }
    
    return YES;
}

- (BOOL)isValidPassword {
    NSString *regExp = @"^.{6,20}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExp];
    
    return [predicate evaluateWithObject:self];
}

- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self attributes:attrs];
    CGRect rect = [attributedText boundingRectWithSize:size
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return CGSizeMake(ceilf(rect.size.width), ceilf(rect.size.height));
}

@end
