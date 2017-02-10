//
//  WordView.h
//  RememberWord
//
//  Created by zhangkai on 08/02/2017.
//  Copyright © 2017 Calle Zhang. All rights reserved.
//

#import "BaseView.h"
#import "WordInfo.h"

@interface WordView : BaseView

@property (nonatomic, strong) WordInfo *word;
@property (nonatomic, assign) BOOL isSelected;

@end
