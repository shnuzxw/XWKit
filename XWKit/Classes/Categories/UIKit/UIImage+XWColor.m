//
//  UIImage+XWColor.m
//  XWCarCost
//
//  Created by smile.zhang on 15/12/22.
//  Copyright © 2015年 Zhang Xiaowei. All rights reserved.
//

#import "UIImage+XWColor.h"

@implementation UIImage (XWColor)
+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    return [self imageWithColor:color rect:rect];
}

+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
