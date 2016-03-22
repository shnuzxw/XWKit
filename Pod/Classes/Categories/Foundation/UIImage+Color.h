//
//  UIImage+Color.h
//  XWCarCost
//
//  Created by smile.zhang on 15/12/22.
//  Copyright © 2015年 Zhang Xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *  根据指定UIColor生产UIImage
 *
 *  @param color UIColor
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据指定UIColor与CGRect生产UIImage
 *
 *  @param color UIColor
 *  @param rect  CGRect
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect;
@end
