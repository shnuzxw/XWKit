//
//  OFFemptyFactory.m
//  51offer
//
//  Created by XcodeYang on 12/3/15.
//  Copyright © 2015 51offer. All rights reserved.
//

#import "EmptyViewFactory.h"

@implementation EmptyViewFactory

#pragma mark - blockConfig
+ (void)emptyMainView:(UIScrollView *)scrollView
        configerBlock:(void (^)(FOREmptyAssistantConfiger *configer))configerBlock
             btnTitle:(NSString *)btnTitle
             btnBlock:(void(^)())btnBlock{
    [FORScrollViewEmptyAssistant emptyWithContentView:scrollView
                                        configerBlock:configerBlock
                                        emptyBtnTitle:btnTitle
                                  emptyBtnActionBlock:btnBlock];
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        [(UITableView *)scrollView reloadData];
    }
}
@end
