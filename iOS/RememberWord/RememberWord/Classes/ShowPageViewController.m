//
//  ShowPageViewController.m
//  RememberWord
//
//  Created by zhangkai on 08/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "ShowPageViewController.h"
#import "PageView.h"
#import "PageViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ShowPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
    UIPageViewController *_pageController;
    UIScrollView *_scrollView;
    int _pageCount;
    int _currentPage;
    NSTimer *_timer;
    int _seconds;
    UILabel *_labelSeconds;
    AVSpeechSynthesizer *_synthesizer;
    UISwitch *_switchAuto;
}

@end

@implementation ShowPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonBack setTitle:@"结束练习" forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(buttonBackClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
    [buttonBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-30);
    }];
    
    _synthesizer = [[AVSpeechSynthesizer alloc] init];
    
    _switchAuto = [[UISwitch alloc] init];
    _switchAuto.on = NO;
    [self.view addSubview:_switchAuto];
    [_switchAuto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(buttonBack.mas_left).offset(-10);
        make.centerY.equalTo(buttonBack.mas_centerY);
    }];
    
    UILabel *labelSound = [[UILabel alloc] init];
    labelSound.text = @"发音：";
    labelSound.textColor = UIColorFromRGB(0x333333);
    labelSound.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:labelSound];
    [labelSound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_switchAuto.mas_left);
        make.centerY.equalTo(_switchAuto.mas_centerY);
    }];
    
    _seconds = 400;
    _labelSeconds = [[UILabel alloc] init];
    _labelSeconds.text = [NSString stringWithFormat:@"剩余 %d 秒", _seconds];
    _labelSeconds.textColor = UIColorFromRGB(0x333333);
    _labelSeconds.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_labelSeconds];
    [_labelSeconds mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.centerY.equalTo(buttonBack.mas_centerY);
    }];
    
    _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                      navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                    options:nil];
    _pageController.delegate = self;
    _pageController.dataSource = self;
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    [_pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    [_pageController didMoveToParentViewController:self];
    
    _pageCount = 200;
    PageViewController *page = [[PageViewController alloc] init];
    page.number = 1;
    page.count = _pageCount;
    page.words = [self loadWordsWithPage:page.number];
    page.selectIndex = 0;
    
    [_pageController setViewControllers:@[page]
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

#pragma mark - Private methods

- (void)buttonBackClicked {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)timerFire {
    _seconds--;
    _labelSeconds.text = [NSString stringWithFormat:@"剩余 %d 秒", _seconds];
    if (_seconds <= 0) {
        [self buttonBackClicked];
    }
}

- (NSArray *)loadWordsWithPage:(int)page {
    NSAssert(page >= 1, @"page is %d, should >= 1", page);
    int count = 5; // 5 words each page
    int offset = (page - 1) * count;
    NSMutableArray *words = [NSMutableArray array];
    // not consider cross plist files
    NSString *path = nil;
    if (offset < 100) {
        path = [[NSBundle mainBundle] pathForResource:@"Words01" ofType:@"plist"];
    } else if (offset < 200) {
        offset -= 100;
        path = [[NSBundle mainBundle] pathForResource:@"Words02" ofType:@"plist"];
    } else if (offset < 300) {
        offset -= 200;
        path = [[NSBundle mainBundle] pathForResource:@"Words03" ofType:@"plist"];
    } else if (offset < 400) {
        offset -= 300;
        path = [[NSBundle mainBundle] pathForResource:@"Words04" ofType:@"plist"];
    } else if (offset < 500) {
        offset -= 400;
        path = [[NSBundle mainBundle] pathForResource:@"Words05" ofType:@"plist"];
    } else if (offset < 600) {
        offset -= 500;
        path = [[NSBundle mainBundle] pathForResource:@"Words06" ofType:@"plist"];
    } else if (offset < 700) {
        offset -= 600;
        path = [[NSBundle mainBundle] pathForResource:@"Words07" ofType:@"plist"];
    } else if (offset < 800) {
        offset -= 700;
        path = [[NSBundle mainBundle] pathForResource:@"Words08" ofType:@"plist"];
    } else if (offset < 900) {
        offset -= 800;
        path = [[NSBundle mainBundle] pathForResource:@"Words09" ofType:@"plist"];
    } else if (offset < 1000) {
        offset -= 900;
        path = [[NSBundle mainBundle] pathForResource:@"Words10" ofType:@"plist"];
    }
    
    if (path) {
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        int limit = offset + count;
        for (int i = offset; i < limit; i++) {
            if (i < array.count) {
                NSDictionary *dict = [array objectAtIndex:i];
                WordInfo *wInfo = [[WordInfo alloc] init];
                wInfo.word = [dict objectForKey:@"word"];
                wInfo.phoneticSymbol = [dict objectForKey:@"phoneticSymbol"];
                NSString *oldString = [dict objectForKey:@"translation"];
                NSString *newString = [oldString stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
                wInfo.translation = newString;
                
                [words addObject:wInfo];
            }
        }
    }
    
    return words;
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    PageViewController *prePage = (PageViewController *)viewController;
    if (prePage.number > 1) {
        PageViewController *page = [[PageViewController alloc] init];
        page.number = prePage.number - 1;
        page.count = _pageCount;
        page.words = [self loadWordsWithPage:page.number];
        page.selectIndex = 0;
        
        return page;
    } else {
        return nil;
    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    PageViewController *prePage = (PageViewController *)viewController;
    if (prePage.number < _pageCount) {
        PageViewController *page = [[PageViewController alloc] init];
        page.number = prePage.number + 1;
        page.count = _pageCount;
        page.words = [self loadWordsWithPage:page.number];
        page.selectIndex = 0;
        
        return page;
    } else {
        return nil;
    }
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed && _switchAuto.on) {
        PageViewController *page = [pageViewController.viewControllers firstObject];
        [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        
        if (page.selectIndex < page.words.count) {
            WordInfo *wInfo = [page.words objectAtIndex:page.selectIndex];
            AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:wInfo.word];
            utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
            [_synthesizer speakUtterance:utterance];
        }
    }
}
@end
