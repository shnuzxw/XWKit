//
//  CLLocation+Distance.m
//  XWCarCost
//
//  Created by smile.zhang on 15/12/22.
//  Copyright © 2015年 Zhang Xiaowei. All rights reserved.
//

#import "CLLocation+Distance.h"

@implementation CLLocation (Distance)
+ (CGFloat)distanceFromLocation2D:(CLLocationCoordinate2D *)fromLocation2D toLocation2D:(CLLocationCoordinate2D *)toLocation2D{
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:fromLocation2D->latitude longitude:fromLocation2D->longitude];
    CLLocation *dist=[[CLLocation alloc] initWithLatitude:toLocation2D->latitude longitude:toLocation2D->longitude];
    return [orig distanceFromLocation:dist];
}

+ (CGFloat)distanceFromLocation:(CLLocation *)fromLocation toLocation:(CLLocation *)toLocation{
    return [fromLocation distanceFromLocation:toLocation];
}
@end
