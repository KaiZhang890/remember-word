//
//  ShowPageViewController.m
//  RememberWord
//
//  Created by zhangkai on 08/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "ShowPageViewController.h"
#import "PageView.h"

@interface ShowPageViewController ()

@end

@implementation ShowPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CGFloat offsetLeft = 20;
    
    UILabel *labelDays = [[UILabel alloc] init];
    labelDays.text = @"已练习 0 天";
    labelDays.textColor = UIColorFromRGB(0x333333);
    labelDays.font = font;
    [self.view addSubview:labelDays];
    [labelDays mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.left.equalTo(self.view).offset(offsetLeft);
    }];
    
    UILabel *labelRemain = [[UILabel alloc] init];
    labelRemain.text = @"今日剩余 10 次练习机会";
    labelRemain.textColor = UIColorFromRGB(0x333333);
    labelRemain.font = font;
    [self.view addSubview:labelRemain];
    [labelRemain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelDays.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(offsetLeft);
    }];
    
    UILabel *labelDuration = [[UILabel alloc] init];
    labelDuration.text = @"要在 400 秒内翻完 200 页";
    labelDuration.textColor = UIColorFromRGB(0x333333);
    labelDuration.font = font;
    [self.view addSubview:labelDuration];
    [labelDuration mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelRemain.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(offsetLeft);
    }];
    
    UILabel *labelIndex = [[UILabel alloc] init];
    labelIndex.text = @"只看每页第 1 个单词";
    labelIndex.textColor = UIColorFromRGB(0x333333);
    labelIndex.font = font;
    [self.view addSubview:labelIndex];
    [labelIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelDuration.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(offsetLeft);
    }];
    
    UILabel *labelSound = [[UILabel alloc] init];
    labelSound.text = @"发音：";
    labelSound.textColor = UIColorFromRGB(0x333333);
    labelSound.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:labelSound];
    [labelSound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelIndex.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(offsetLeft);
    }];
    
    UISwitch *switchSound = [[UISwitch alloc] init];
    switchSound.on = YES;
    [self.view addSubview:switchSound];
    [switchSound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labelSound.mas_right);
        make.centerY.equalTo(labelSound.mas_centerY);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelSound.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
    UIView *pagesView = [[UIView alloc] init];
    [scrollView addSubview:pagesView];
    [pagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.centerY.equalTo(scrollView);
    }];
    
    PageView *lastView = nil;
    for (int i = 0; i < 20; i++) {
        NSArray *words = [self loadWordsWithOffset:i * 5 count:5];
        PageView *pView = [[PageView alloc] initWithWords:words selectIndex:0];
        pView.labelPage.text = [NSString stringWithFormat:@"Page %d of %d", i+1, 20];
        [pagesView addSubview:pView];
        [pView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(pagesView);
            if (lastView) {
                make.left.equalTo(lastView.mas_right).offset(20);
            } else {
                make.left.equalTo(pagesView).offset(10);
            }
            make.width.equalTo(self.view).offset(-20);
        }];
        
        lastView = pView;
    }
    
    [pagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right).offset(10);
    }];
}

#pragma mark - Private methods

- (NSArray *)loadWordsWithOffset:(int)offset count:(int)count {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Words01" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *words = [NSMutableArray array];
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
    
    return words;
}

@end
