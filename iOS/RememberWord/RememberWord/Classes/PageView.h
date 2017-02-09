//
//  PageView.h
//  RememberWord
//
//  Created by zhangkai on 08/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "BaseView.h"
#import "WordView.h"

@interface PageView : BaseView

@property (nonatomic, readonly) NSArray *words;
@property (nonatomic, readonly) int selectIndex;
@property (nonatomic,readonly) UILabel *labelPage;

- (instancetype)initWithWords:(NSArray *)words selectIndex:(int)index;

@end
