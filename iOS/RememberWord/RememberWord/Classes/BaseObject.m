//
//  BaseObject.m
//  DailyReport
//
//  Created by zhangkai on 07/11/2016.
//  Copyright © 2016 Calle Zhang. All rights reserved.
//

#import "BaseObject.h"
#import <objc/runtime.h>

@implementation BaseObject

#pragma mark - Override methods

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"%@, ", [super description]];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:propName];
        [description appendFormat:@"%@: %@, ", propertyName, [self valueForKey:propertyName]];
    }
    [description deleteCharactersInRange:NSMakeRange(description.length - 2, 2)];
    return description;
}

@end
