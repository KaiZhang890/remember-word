//
//  MainViewController.m
//  RememberWord
//
//  Created by zhangkai on 24/11/2016.
//  Copyright © 2016 Calle Zhang. All rights reserved.
//

#import "MainViewController.h"
#import "WordInfo.h"

@interface MainViewController () <UIScrollViewDelegate> {
    UIScrollView *_contentScrollView;
    UILabel *_labelProgress;
    NSMutableArray *_wrods;
    int _index;
}

@end

@implementation MainViewController

- (void)loadView {
    [super loadView];
    
    _contentScrollView = [[UIScrollView alloc] init];
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.delegate = self;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.layer.borderWidth = 1;
    _contentScrollView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_contentScrollView];
    [_contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view.mas_width).offset(-40);
        make.height.equalTo(_contentScrollView.mas_width);
    }];
    
    _labelProgress = [[UILabel alloc] init];
    _labelProgress.textColor = [UIColor grayColor];
    _labelProgress.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:_labelProgress];
    [_labelProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_contentScrollView.mas_bottom).offset(-10);
        make.trailing.equalTo(_contentScrollView.mas_trailing).offset(-10);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _wrods = [NSMutableArray array];
    
    [self loadWords];
    [self showWords];
}

#pragma mark - Private methods

- (void)showWords {
    UIView *lastContentView = nil;
    for (int i = 0; i < _wrods.count; i++) {
        WordInfo *wInfo = [_wrods objectAtIndex:i];
        
        UIView *contentView = [[UIView alloc] init];
        [_contentScrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastContentView) {
                make.left.equalTo(lastContentView.mas_right);
            } else {
                make.left.mas_equalTo(0);
            }
            make.top.mas_equalTo(0);
            make.width.height.equalTo(_contentScrollView);
            if (i == _wrods.count - 1) {
                make.right.mas_equalTo(0);
            }
        }];
        
        lastContentView = contentView;
        
        UILabel *labelWord = [[UILabel alloc] init];
        labelWord.text = wInfo.word;
        labelWord.textColor = UIColorFromRGB(0x333333);
        labelWord.font = [UIFont boldSystemFontOfSize:50];
        labelWord.adjustsFontSizeToFitWidth = YES;
        [contentView addSubview:labelWord];
        [labelWord mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(20);
            make.right.mas_lessThanOrEqualTo(-20);
        }];
        
        UILabel *labelSymbol = [[UILabel alloc] init];
        labelSymbol.text = wInfo.phoneticSymbol;
        labelSymbol.textColor = UIColorFromRGB(0x333333);
        labelSymbol.font = [UIFont systemFontOfSize:20];
        labelSymbol.adjustsFontSizeToFitWidth = YES;
        [contentView addSubview:labelSymbol];
        [labelSymbol mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(labelWord.mas_bottom);
            make.left.equalTo(labelWord);
            make.right.mas_lessThanOrEqualTo(-20);
        }];
        
        UILabel *labelTranslation = [[UILabel alloc] init];
        labelTranslation.text = wInfo.translation;
        labelTranslation.textColor = UIColorFromRGB(0x333333);
        labelTranslation.font = [UIFont systemFontOfSize:20];
        labelTranslation.numberOfLines = 0;
        [contentView addSubview:labelTranslation];
        [labelTranslation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(labelSymbol.mas_bottom).offset(10);
            make.left.equalTo(labelWord);
            make.right.mas_lessThanOrEqualTo(-20);
        }];
    }
    
    _index = 1;
    _labelProgress.text = [NSString stringWithFormat:@"%d/%d", _index, (int)_wrods.count];
}

- (void)loadWords {
    WordInfo *wInfo = [[WordInfo alloc] init];
    wInfo.word = @"emperor";
    wInfo.phoneticSymbol = @"/'empərə/";
    wInfo.translation = @"n. 皇帝，君主";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"exact";
    wInfo.phoneticSymbol = @"/ɪg'zækt/";
    wInfo.translation = @"adj. 精确的；准确的";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"traditional";
    wInfo.phoneticSymbol = @"/trə'dɪʃənl/";
    wInfo.translation = @"adj. 传统的，惯例的；口传的，传说的";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"lack";
    wInfo.phoneticSymbol = @"/læk/";
    wInfo.translation = @"n./vi. 缺乏；不足；没有";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"pardon";
    wInfo.phoneticSymbol = @"/'pɑːdn/";
    wInfo.translation = @"excl. (用于请求别人重复某事)什么，请再说一遍 n./vt. 原谅；宽恕；赦免";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"regent";
    wInfo.phoneticSymbol = @"/'riːdʒnt/";
    wInfo.translation = @"n. 摄政者(代国王统治者)";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"burgeon";
    wInfo.phoneticSymbol = @"/'bɜːdʒən/";
    wInfo.translation = @"vi. 迅速成长；发展";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"argue";
    wInfo.phoneticSymbol = @"/'ɑːgjuː/";
    wInfo.translation = @"v. 争论；说服";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"barely";
    wInfo.phoneticSymbol = @"/'beəlɪ/";
    wInfo.translation = @"adv. 仅仅，几乎不；赤裸裸地，无遮蔽地";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"methane";
    wInfo.phoneticSymbol = @"/'miːθeɪn/";
    wInfo.translation = @"n. 甲烷；沼气";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"hierarchy";
    wInfo.phoneticSymbol = @"/'haɪərɑːkɪ/";
    wInfo.translation = @"n. 领导层；层次，等级";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"guidance";
    wInfo.phoneticSymbol = @"/'gaɪdns/";
    wInfo.translation = @"n. 指引；指导";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"easy-going";
    wInfo.phoneticSymbol = @"/'i:ziˌɡəuiŋ/";
    wInfo.translation = @"adj. 脾气随和的；温和的";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"electrical";
    wInfo.phoneticSymbol = @"/ɪ'lektrɪkl/";
    wInfo.translation = @"adj. 电的，电学的，有关电的";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"electronic";
    wInfo.phoneticSymbol = @"/ɪlek'trɒnɪk/";
    wInfo.translation = @"adj. 电子的";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"roll film";
    wInfo.phoneticSymbol = @"";
    wInfo.translation = @"胶卷";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"philosophy";
    wInfo.phoneticSymbol = @"/fi'lɔsəfi/";
    wInfo.translation = @"n. 哲学；哲理";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"chronic";
    wInfo.phoneticSymbol = @"/'krɒnɪk/";
    wInfo.translation = @"adj. (疾病)慢性的；积习难改的";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"desirable";
    wInfo.phoneticSymbol = @"/dɪ'zaɪərəbl/";
    wInfo.translation = @"adj. 可取的，值得拥有的，合意的";
    [_wrods addObject:wInfo];
    
    wInfo = [[WordInfo alloc] init];
    wInfo.word = @"consortium";
    wInfo.phoneticSymbol = @"/kən'sɔːtɪəm/";
    wInfo.translation = @"n. 集团；财团；社团；协会";
    [_wrods addObject:wInfo];
}


#pragma mark - UIScrollViewDelegate

- (void)resetShowIndex:(UIScrollView *)scrollView {
    // circular and infinite UIScrollView: 3-1-2-3-1
    if (scrollView == _contentScrollView) {
        _index = 1 + roundf(_contentScrollView.contentOffset.x / (_contentScrollView.frame.size.width));
        _labelProgress.text = [NSString stringWithFormat:@"%d/%d", _index, (int)_wrods.count];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self resetShowIndex:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self resetShowIndex:scrollView];
}

@end
