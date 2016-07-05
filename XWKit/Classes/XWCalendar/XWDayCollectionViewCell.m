//
//  XWDayCollectionViewCell.m
//  XWCalendar
//
//  Created by smile.zhang on 16/5/26.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "XWDayCollectionViewCell.h"

@implementation XWDayCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self makeConstraints];
    }
    return self;
}

- (void)makeConstraints {

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *consTop = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1
                                                                constant:3];
    NSLayoutConstraint *consLeft = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1
                                                                 constant:0];
    NSLayoutConstraint *consHeight = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:0
                                                                   constant:20];
    NSLayoutConstraint *consRight = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1
                                                                  constant:0];
    [self.contentView addConstraints:@[consTop, consLeft, consHeight, consRight]];

    consTop = [NSLayoutConstraint constraintWithItem:self.detailLabel
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:self.titleLabel
                                           attribute:NSLayoutAttributeBottom
                                          multiplier:1
                                            constant:0];
    consLeft = [NSLayoutConstraint constraintWithItem:self.detailLabel
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.contentView
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1
                                             constant:0];
    consHeight = [NSLayoutConstraint constraintWithItem:self.detailLabel
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.contentView
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:0
                                               constant:10];
    consRight = [NSLayoutConstraint constraintWithItem:self.detailLabel
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self.contentView
                                             attribute:NSLayoutAttributeRight
                                            multiplier:1
                                              constant:0];
    [self.contentView addConstraints:@[consTop, consLeft, consHeight, consRight]];

    consTop = [NSLayoutConstraint constraintWithItem:self.imageView
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:self.detailLabel
                                           attribute:NSLayoutAttributeBottom
                                          multiplier:1
                                            constant:2];
    NSLayoutConstraint *consCenterX = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.contentView
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1
                                                                    constant:0];
    consHeight = [NSLayoutConstraint constraintWithItem:self.imageView
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.contentView
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:0
                                               constant:5];
    NSLayoutConstraint *consWidth = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:0
                                                                  constant:5];
    [self.contentView addConstraints:@[consTop, consCenterX, consHeight, consWidth]];
}

#pragma mark - Overwrite

- (void)prepareForReuse {
    [super prepareForReuse];
    _titleLabel.text = @"";
    _titleLabel.textColor = [UIColor blackColor];
    _detailLabel.text = @"";
    _detailLabel.textColor = [UIColor blackColor];
    _imageView.image = nil;
    _imageView.backgroundColor = [UIColor clearColor];
}

#pragma mark - Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        _detailLabel = label;
        [self.contentView addSubview:_detailLabel];

    }
    return _detailLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        _imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return _imageView;
}

@end
