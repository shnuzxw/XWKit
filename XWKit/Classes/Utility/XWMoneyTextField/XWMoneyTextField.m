//
//  XWMoneyTextField.m
//  XWMoneyTextField
//
//  Created by smile.zhang on 16/3/10.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "XWMoneyTextField.h"
#import "XWMoneyTextFieldLimit.h"

@interface XWMoneyTextField ()
@property (nonatomic, strong) XWMoneyTextFieldLimit *limit;
@end

@implementation XWMoneyTextField

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self.limit;
        [self addTarget:self.limit
                 action:@selector(valueChanged:)
       forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

// 禁止 粘贴、剪切、选择、选择全部
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{

//禁止粘贴
if (action == @selector(paste:)){
return NO;
}
if (action == @selector(cut:)) {
return NO;
}
    if (action == @selector(copy:)) {
        return NO;
    }
    if (action == @selector(select:)) {
        return NO;
    }
    if (action == @selector(selectAll:)) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - Getter
- (XWMoneyTextFieldLimit *)limit{
    if (!_limit) {
        _limit = [[XWMoneyTextFieldLimit alloc] init];
    }
    return _limit;
}

@end
