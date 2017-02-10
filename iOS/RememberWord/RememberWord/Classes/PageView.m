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
        
        NSAssert(words.count == 5, @"Only supprt layout 5 words");
        WordView *view0 = [[WordView alloc] initWithWord:_words[0]];
        [self addSubview:view0];
        [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-5);
        }];
        
        int offsetBottom = -60;
        if (WinSize.height == 568) { // iPhone 5, iPhoen SE
            offsetBottom = -40;
        } else if (WinSize.height == 480) { // iPhone 4
            
        }
        WordView *view4 = [[WordView alloc] initWithWord:_words[4]];
        [self addSubview:view4];
        [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(offsetBottom);
            make.left.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-5);
        }];
        
        WordView *view2 = [[WordView alloc] initWithWord:_words[2]];
        [self addSubview:view2];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(offsetBottom * 0.5);
            make.left.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-5);
        }];
        
        UIView *containerView = [[UIView alloc] init];
        [self addSubview:containerView];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view0.mas_bottom);
            make.left.right.equalTo(self);
            make.bottom.equalTo(view2.mas_top);
        }];
        
        WordView *view1 = [[WordView alloc] initWithWord:_words[1]];
        [containerView addSubview:view1];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(containerView.mas_centerY);
            make.left.equalTo(containerView).offset(5);
            make.right.equalTo(containerView).offset(-5);
        }];
        
        containerView = [[UIView alloc] init];
        [self addSubview:containerView];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view2.mas_bottom);
            make.left.right.equalTo(self);
            make.bottom.equalTo(view4.mas_top);
        }];
        
        WordView *view3 = [[WordView alloc] initWithWord:_words[3]];
        [containerView addSubview:view3];
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(containerView.mas_centerY);
            make.left.equalTo(containerView).offset(5);
            make.right.equalTo(containerView).offset(-5);
        }];
        
        if (_selectIndex >= 0 && _selectIndex < words.count) {
            UIFont *font = [UIFont boldSystemFontOfSize:15];
            WordView *selectView = nil;
            switch (_selectIndex) {
                case 1:
                    selectView = view1;
                    break;
                case 2:
                    selectView = view2;
                    break;
                case 3:
                    selectView = view3;
                    break;
                case 4:
                    selectView = view4;
                    break;
                default:
                    selectView = view0;
                    break;
            }
            
            selectView.labelWord.font = font;
            selectView.labelPhonetic.font = font;
            selectView.labelTranslation.font = font;
        }
    }
    
    return self;
}

@end
