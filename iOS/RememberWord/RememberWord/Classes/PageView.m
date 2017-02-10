//
//  PageView.m
//  RememberWord
//
//  Created by zhangkai on 08/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "PageView.h"

@interface PageView ()

@end

@implementation PageView

- (instancetype)initWithWords:(NSArray *)words selectIndex:(int)index {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _words = words;
        _selectIndex = index;
        
        _labelPage = [[UILabel alloc] init];
        _labelPage.textColor = UIColorFromRGB(0x888888);
        _labelPage.font = [UIFont systemFontOfSize:13];
        _labelPage.text = @"";
        [self addSubview:_labelPage];
        [_labelPage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-10);
        }];
        
        UIView *lastView = nil;
        for (int i = 0; i < words.count; i++) {
            WordView *view = [[WordView alloc] init];
            view.word = _words[i];
            view.isSelected = (i == _selectIndex);
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.top.mas_equalTo(10);
                } else if (i == words.count - 1) {
                    make.top.equalTo(lastView.mas_bottom);
                    
                    int offsetBottom = -60;
                    if (WinSize.height == 568) { // iPhone 5, iPhoen SE
                        offsetBottom = -40;
                    } else if (WinSize.height == 480) { // iPhone 4
                        
                    }
                    make.bottom.equalTo(self).offset(offsetBottom);
                } else {
                    make.top.equalTo(lastView.mas_bottom);
                }
                
                make.left.equalTo(self).offset(5);
                make.right.equalTo(self).offset(-5);
            }];
            
            if (i == words.count - 1) {
                lastView = nil;
            } else {
                UIView *spacer = [[UIView alloc] init];
                spacer.hidden = YES;
                [self addSubview:spacer];
                [spacer mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(view.mas_bottom);
                    make.centerX.equalTo(self.mas_centerX);
                    make.width.mas_equalTo(10);
                    if (lastView) {
                        make.height.equalTo(lastView);
                    }
                }];
                lastView = spacer;
            }
        }
    }
    
    return self;
}

@end
