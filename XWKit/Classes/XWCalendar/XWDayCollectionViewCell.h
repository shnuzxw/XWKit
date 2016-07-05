//
//  XWDayCollectionViewCell.h
//  XWCalendar
//
//  Created by smile.zhang on 16/5/26.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kXWDayCellIdentifier = @"kXWDayCellIdentifier";

@interface XWDayCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *detailLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end
