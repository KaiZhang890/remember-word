//
//  UIImageView+Rotate.h
//  SiXiangYun
//
//  Created by zhangkai on 23/10/2016.
//  Copyright © 2016 Kai Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Rotate)

- (void)rotate360WithDuration:(CGFloat)duration repeatCount:(float)repeatCount;
- (void)pauseAnimations;
- (void)resumeAnimations;
- (void)stopAllAnimations;

@end
