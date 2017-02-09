//
//  BaseView.m
//  DailyReport
//
//  Created by zhangkai on 10/11/2016.
//  Copyright © 2016 Calle Zhang. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)init {
    if (self = [super init]) {
        DLOGINFO(@"%@", NSStringFromClass([self class]));
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        DLOGINFO(@"%@", NSStringFromClass([self class]));
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        DLOGINFO(@"%@", NSStringFromClass([self class]));
    }
    return self;
}

- (void)dealloc {
    DLOGINFO(@"%@", NSStringFromClass([self class]));
}

@end
