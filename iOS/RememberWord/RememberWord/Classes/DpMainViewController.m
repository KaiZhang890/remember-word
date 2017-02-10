//
//  MainViewController.m
//  RememberWord
//
//  Created by zhangkai on 24/11/2016.
//  Copyright © 2016 Calle Zhang. All rights reserved.
//

#import "DpMainViewController.h"
#import "WordInfo.h"
#import <AVFoundation/AVFoundation.h>

@interface DpMainViewController () <UIScrollViewDelegate> {
    UIScrollView *_contentScrollView;
    UILabel *_labelProgress;
    NSMutableArray *_words;
    int _index;
    AVSpeechSynthesizer *_synthesizer;
    UISwitch *_switchAuto;
}

@end

@implementation DpMainViewController

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
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-50);
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
    
    UIButton *buttonSpeech = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonSpeech setTitle:@"朗读" forState:UIControlStateNormal];
    buttonSpeech.titleLabel.font = [UIFont systemFontOfSize:15];
    [buttonSpeech setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [buttonSpeech setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [buttonSpeech addTarget:self action:@selector(buttonSpeechClicked:) forControlEvents:UIControlEventTouchUpInside];
    [buttonSpeech addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [buttonSpeech addTarget:self action:@selector(buttonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    buttonSpeech.layer.borderWidth = 1;
    buttonSpeech.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
    buttonSpeech.layer.cornerRadius = 22;
    [self.view addSubview:buttonSpeech];
    [buttonSpeech mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentScrollView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *buttonInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonInfo setTitle:@"使用说明" forState:UIControlStateNormal];
    buttonInfo.titleLabel.font = [UIFont systemFontOfSize:15];
    [buttonInfo setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [buttonInfo setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [buttonInfo addTarget:self action:@selector(buttonSpeechClicked:) forControlEvents:UIControlEventTouchUpInside];
    [buttonInfo addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [buttonInfo addTarget:self action:@selector(buttonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    buttonInfo.layer.borderWidth = 1;
    buttonInfo.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
    buttonInfo.layer.cornerRadius = 22;
    [self.view addSubview:buttonInfo];
    [buttonInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
    _switchAuto = [[UISwitch alloc] init];
    _switchAuto.on = NO;
    [_switchAuto addTarget:self action:@selector(switchAutoValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_switchAuto];
    [_switchAuto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
    }];
    
    UILabel *labelAuto = [[UILabel alloc] init];
    labelAuto.textColor = UIColorFromRGB(0x333333);
    labelAuto.font = [UIFont systemFontOfSize:15];
    labelAuto.text = @"自动朗读:";
    [self.view addSubview:labelAuto];
    [labelAuto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(_switchAuto.mas_leading).offset(-5);
        make.centerY.equalTo(_switchAuto.mas_centerY);
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _words = [NSMutableArray array];
    _synthesizer = [[AVSpeechSynthesizer alloc] init];
    
    [self loadWords];
    [self showWords];
    
//    for (AVSpeechSynthesisVoice *voice in [AVSpeechSynthesisVoice speechVoices]) {
//        DLOG(@"%@ %@", voice.language, voice.identifier);
//    }
}

#pragma mark - Private methods

- (void)switchAutoValueChanged {
    if (_switchAuto.isOn) {
        [self buttonSpeechClicked:nil];
    }
}

- (void)buttonInfoClicked:(UIButton *)button {
    button.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
}

- (void)buttonSpeechClicked:(UIButton *)button {
    button.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
    
    [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
    WordInfo *wInfo = [_words objectAtIndex:_index-1];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:wInfo.word];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    [_synthesizer speakUtterance:utterance];
}

- (void)buttonTouchDown:(UIButton *)button {
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)buttonTouchUpOutside:(UIButton *)button {
    button.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
}

- (void)showWords {
    UIView *lastContentView = nil;
    for (int i = 0; i < _words.count; i++) {
        WordInfo *wInfo = [_words objectAtIndex:i];
        
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
            if (i == _words.count - 1) {
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
    _labelProgress.text = [NSString stringWithFormat:@"%d/%d", _index, (int)_words.count];
}

- (void)loadWords {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Words01" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    for (int i = 0; i < 20; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        WordInfo *wInfo = [[WordInfo alloc] init];
        wInfo.word = [dict objectForKey:@"word"];
        wInfo.phoneticSymbol = [dict objectForKey:@"phoneticSymbol"];
        NSString *oldString = [dict objectForKey:@"translation"];
        NSString *newString = [oldString stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        wInfo.translation = newString;
        
        [_words addObject:wInfo];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)resetShowIndex:(UIScrollView *)scrollView {
    // circular and infinite UIScrollView: 3-1-2-3-1
    if (scrollView == _contentScrollView) {
        _index = 1 + roundf(_contentScrollView.contentOffset.x / (_contentScrollView.frame.size.width));
        _labelProgress.text = [NSString stringWithFormat:@"%d/%d", _index, (int)_words.count];
        
        if (_switchAuto.isOn) {
            [self buttonSpeechClicked:nil];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self resetShowIndex:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self resetShowIndex:scrollView];
}

@end
