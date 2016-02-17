//
//  UIImage+Color.h
//  XWCarCost
//
//  Created by smile.zhang on 15/12/22.
//  Copyright © 2015年 Zhang Xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
//图片用color展示
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect;
@end
