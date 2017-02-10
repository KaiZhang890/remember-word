//
//  WordView.m
//  RememberWord
//
//  Created by zhangkai on 08/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "WordView.h"

@implementation WordView

- (instancetype)initWithWord:(WordInfo *)word {
    if (self = [super init]) {
        UIFont *font = [UIFont systemFontOfSize:15];
        if (WinSize.height == 568) { // iPhone 5, iPhoen SE
            font = [UIFont systemFontOfSize:14];
        }
        CGFloat offsetLeft = 110;
        
        _labelWord = [[UILabel alloc] init];
        _labelWord.text = word.word;
        _labelWord.textColor = UIColorFromRGB(0x333333);
        _labelWord.font = font;
        _labelWord.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_labelWord];
        [_labelWord mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.width.mas_lessThanOrEqualTo(offsetLeft);
        }];
        
        _labelPhonetic = [[UILabel alloc] init];
        _labelPhonetic.text = word.phoneticSymbol;
        _labelPhonetic.textColor = UIColorFromRGB(0x333333);
        _labelPhonetic.font = font;
        _labelPhonetic.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_labelPhonetic];
        [_labelPhonetic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labelWord.mas_top);
            make.left.equalTo(self).offset(offsetLeft);
            make.right.lessThanOrEqualTo(self);
        }];
        
        _labelTranslation = [[UILabel alloc] init];
        _labelTranslation.text = word.translation;
        _labelTranslation.textColor = UIColorFromRGB(0x333333);
        _labelTranslation.font = font;
        _labelTranslation.numberOfLines = 0;
        //_labelTranslation.preferredMaxLayoutWidth = WinSize.width - 30 - offsetLeft;
        [self addSubview:_labelTranslation];
        [_labelTranslation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labelPhonetic.mas_bottom);
            make.left.equalTo(self).offset(offsetLeft);
            make.right.lessThanOrEqualTo(self);
            make.bottom.equalTo(self);
        }];
    }
    
    return self;
}

@end
