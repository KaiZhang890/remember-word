//
//  WordView.m
//  RememberWord
//
//  Created by zhangkai on 08/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "WordView.h"

@interface WordView () {
    UILabel *_labelWord;
    UILabel *_labelPhonetic;
    UILabel *_labelTranslation;
}

@end

@implementation WordView

- (id)init {
    if (self = [super init]) {
        _labelWord = [[UILabel alloc] init];
        _labelWord.textColor = UIColorFromRGB(0x333333);
        _labelWord.numberOfLines = 0;
        _labelWord.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labelWord];
        [_labelWord mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.3);
        }];
        
        _labelPhonetic = [[UILabel alloc] init];
        _labelPhonetic.textColor = UIColorFromRGB(0x333333);
        _labelPhonetic.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_labelPhonetic];
        [_labelPhonetic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labelWord.mas_top);
            make.width.equalTo(self).multipliedBy(0.6);
            make.right.equalTo(self);
        }];
        
        _labelTranslation = [[UILabel alloc] init];
        _labelTranslation.textColor = UIColorFromRGB(0x333333);
        _labelTranslation.numberOfLines = 0;
        [self addSubview:_labelTranslation];
        [_labelTranslation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labelPhonetic.mas_bottom);
            make.width.equalTo(self).multipliedBy(0.6);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    
    return self;
}

#pragma mark - Accessor methods

- (void)setWord:(WordInfo *)word {
    _word = word;
    
    _labelWord.text = _word.word;
    _labelPhonetic.text = _word.phoneticSymbol;
    _labelTranslation.text = _word.translation;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    UIFont *font = nil;
    if (WinSize.height == 568) {
        if (_isSelected) {
            font = [UIFont boldSystemFontOfSize:14];
        } else {
            font = [UIFont systemFontOfSize:14];
        }
    } else {
        if (_isSelected) {
            font = [UIFont boldSystemFontOfSize:15];
        } else {
            font = [UIFont systemFontOfSize:15];
        }
    }
    
    _labelWord.font = font;
    _labelPhonetic.font = font;
    _labelTranslation.font = font;
}

@end
