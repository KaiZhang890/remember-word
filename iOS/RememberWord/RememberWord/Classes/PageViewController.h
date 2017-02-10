//
//  PageViewController.h
//  RememberWord
//
//  Created by zhangkai on 10/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "BaseViewController.h"

@interface PageViewController : BaseViewController

@property (nonatomic, assign) int number;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) int selectIndex;
@property (nonatomic, copy) NSArray *words;

@end
