//
//  CLLocation+Distance.h
//  XWCarCost
//
//  Created by smile.zhang on 15/12/22.
//  Copyright © 2015年 Zhang Xiaowei. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface CLLocation (Distance)
+ (CGFloat)distanceFromLocation2D:(CLLocationCoordinate2D *)fromLocation2D toLocation2D:(CLLocationCoordinate2D *)toLocation2D;
+ (CGFloat)distanceFromLocation:(CLLocation *)fromLocation toLocation:(CLLocation *)toLocation; // 单位：米
@end
