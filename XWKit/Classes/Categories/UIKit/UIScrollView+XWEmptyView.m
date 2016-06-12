//
//  UIScrollView+XWEmptyView.m
//  BookingClient
//
//  Created by smile.zhang on 16/4/27.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "UIScrollView+XWEmptyView.h"
#import "Macro.h"

@implementation UIScrollView (XWEmptyView)

- (void)showEmptyViewWithImage:(UIImage *)image {
    [self showEmptyViewWithImage:image title:@""];
}

- (void)showEmptyViewWithTitle:(NSString *)title {
    [self showEmptyViewWithImage:nil title:title];
}

- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title {
    [self showEmptyViewWithImage:image title:title subTitle:@""];
}

- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title subTitle:(NSString *)subTitle {
    kdispatch_main_async_safe(^{
        FOREmptyAssistantConfiger *configer = [FOREmptyAssistantConfiger new];
        configer.emptyCenterOffset = CGPointMake(0, -40);
        configer.emptySpaceHeight = 20.0;
        configer.emptyImage = image;
        configer.emptyTitle = title;
        configer.emptyTitleFont = [UIFont systemFontOfSize:14.0f];
        configer.emptyTitleColor = [UIColor colorWithRed:0.424 green:0.424 blue:0.424 alpha:1.00];
        configer.emptySubtitle = subTitle;
        configer.emptySubtitleFont = [UIFont systemFontOfSize:12.0f];
        configer.emptySubtitleColor = [UIColor colorWithRed:0.784 green:0.784 blue:0.784 alpha:1.00];
        [FORScrollViewEmptyAssistant emptyWithContentView:self emptyConfiger:configer];

        if ([self isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)self;
            [tableView reloadData];
        }
        if ([self isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)self;
            [collectionView reloadData];
        }
    });
}

@end
