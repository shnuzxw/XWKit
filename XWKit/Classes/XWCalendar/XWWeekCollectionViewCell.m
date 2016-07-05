//
//  XWWeekDayCollectionViewCell.m
//  XWCalendar
//
//  Created by smile.zhang on 16/5/26.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "XWWeekCollectionViewCell.h"

@implementation XWWeekCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self makeConstraints];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    _titleLabel.text = @"";
}

- (void)makeConstraints {
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *consTop = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1
                                                                   constant:0];
    NSLayoutConstraint *consLeft = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1
                                                                 constant:0];
    NSLayoutConstraint *consBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1
                                                                   constant:0];
    NSLayoutConstraint *consRight = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1
                                                                  constant:0];
    [self.contentView addConstraints:@[consTop, consLeft, consBottom, consRight]];
}

#pragma mark - Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//        label.backgroundColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
