//
//  WordInfo.h
//  RememberWord
//
//  Created by zhangkai on 24/11/2016.
//  Copyright © 2016 Calle Zhang. All rights reserved.
//

#import "BaseObject.h"

@interface WordInfo : BaseObject

@property (nonatomic, copy) NSString *word;
@property (nonatomic, copy) NSString *phoneticSymbol;
@property (nonatomic, copy) NSString *translation;

@end
