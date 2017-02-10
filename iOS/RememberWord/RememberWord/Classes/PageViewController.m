//
//  PageViewController.m
//  RememberWord
//
//  Created by zhangkai on 10/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "PageViewController.h"
#import "WordView.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    UILabel *labelPage = [[UILabel alloc] init];
    labelPage.textColor = UIColorFromRGB(0x888888);
    labelPage.font = [UIFont systemFontOfSize:13];
    labelPage.text = [NSString stringWithFormat:@"Page %d of %d", _number, _count];;
    [contentView addSubview:labelPage];
    [labelPage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.bottom.equalTo(contentView).offset(-10);
    }];
    
    UIView *lastView = nil;
    for (int i = 0; i < _words.count; i++) {
        WordView *view = [[WordView alloc] init];
        view.word = _words[i];
        view.isSelected = (i == _selectIndex);
        [contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.mas_equalTo(10);
            } else if (i == _words.count - 1) {
                make.top.equalTo(lastView.mas_bottom);
                
                int offsetBottom = -60;
                if (WinSize.height == 568) { // iPhone 5, iPhoen SE
                    offsetBottom = -40;
                } else if (WinSize.height == 480) { // iPhone 4
                    
                }
                make.bottom.equalTo(contentView).offset(offsetBottom);
            } else {
                make.top.equalTo(lastView.mas_bottom);
            }
            
            make.left.equalTo(contentView).offset(5);
            make.right.equalTo(contentView).offset(-5);
        }];
        
        if (i == _words.count - 1) {
            lastView = nil;
        } else {
            UIView *spacer = [[UIView alloc] init];
            spacer.hidden = YES;
            [contentView addSubview:spacer];
            [spacer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(view.mas_bottom);
                make.left.mas_equalTo(0);
                make.width.mas_equalTo(10);
                if (lastView) {
                    make.height.equalTo(lastView);
                }
            }];
            lastView = spacer;
        }
    }
}

@end
