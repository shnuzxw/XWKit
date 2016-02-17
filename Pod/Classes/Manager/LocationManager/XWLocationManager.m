//
//  XWLocationManager.m
//  ShareCar
//
//  Created by smile.zhang on 15/9/12.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//


#import "XWLocationManager.h"
#import <UIKit/UIKit.h>

@interface XWLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) NSMutableArray *requestBlocks;
@property (nonatomic, strong) NSMutableArray *subscribeBlocks;
@end


@implementation XWLocationManager

SingletonImplementation(XWLocationManager);

- (void)addRequestLocationUpdateSuccessBlock:(LocationSuccessBlock)block{
    [self.requestBlocks addObject:block];
}

- (void)addSubScribeLocationUpdateSuccessBlock:(LocationSuccessBlock)block{
    [self.subscribeBlocks addObject:block];
}

- (BOOL)locationServicesEnabled{
    return [CLLocationManager locationServicesEnabled];
}

- (BOOL)requestWhenInUseAuthorization{
    if ([self locationServicesEnabled] && [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)requestAlwaysAuthorization{
    if ([self locationServicesEnabled] && [self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
        return YES;
    }else{
        return NO;
    }
}

- (void)startUpdatingLocation{
    [self.locationManager startUpdatingLocation];
}

- (void)requestLocationWithBlock:(LocationSuccessBlock)block{
    if (block) {
        [self addRequestLocationUpdateSuccessBlock:block];
    }
    [self startUpdatingLocation];
}

- (void)subscribeLocationUpdatesWithBlock:(LocationSuccessBlock)block{
    if (block) {
        [self.subscribeBlocks addObject:block];
    }
    [self startUpdatingLocation];
}

- (void)stopUpdatingLocation{
    [self.locationManager stopUpdatingLocation];
}

// 根据地名确定地理坐标
-(void)getCoordinateByAddress:(NSString *)address
            completionHandler:(CLGeocodeCompletionHandler)completionHandler{
    //地理编码
    [self.geoCoder geocodeAddressString:address
                      completionHandler:^(NSArray *placemarks, NSError *error) {
                          if (completionHandler) {
                              completionHandler(placemarks, error);
                          }
                      }];
}

// 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude
                  longitude:(CLLocationDegrees)longitude
          completionHandler:(CLGeocodeCompletionHandler)completionHandler{
    //反地理编码
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [self.geoCoder reverseGeocodeLocation:location
                        completionHandler:^(NSArray *placemarks, NSError *error) {
                            if (completionHandler) {
                                completionHandler(placemarks, error);
                            }
                        }];
}

- (void)getAddressByLocation:(CLLocation *)location
           completionHandler:(CLGeocodeCompletionHandler)completionHandler{
    [self.geoCoder reverseGeocodeLocation:location
                        completionHandler:^(NSArray * placemarks, NSError * error) {
                            if (completionHandler) {
                                completionHandler(placemarks, error);
                            }
                        }];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    _location = location;
    [self handleLocationBlocksWithIsSuccess:YES];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [self handleLocationBlocksWithIsSuccess:NO];
    [manager stopUpdatingLocation];
}

- (void)handleLocationBlocksWithIsSuccess:(BOOL)isSuccess{
    if (self.requestBlocks.count) {
        for (LocationSuccessBlock requestBlock in self.requestBlocks) {
            requestBlock(_location, isSuccess, [CLLocationManager authorizationStatus]);
        }
        [self.requestBlocks removeAllObjects];
    }
    
    if (self.subscribeBlocks.count) {
        for (LocationSuccessBlock subscribeBlock in self.subscribeBlocks) {
            subscribeBlock(_location, isSuccess, [CLLocationManager authorizationStatus]);
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        {
            [self handleLocationBlocksWithIsSuccess:NO];
            if ([self requestWhenInUseAuthorization]) {
                NSLog(@"开启定位成功");
            }else{
                NSLog(@"开启定位失败");
            }
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            [self startUpdatingLocation];
        }
            
        default:
            break;
    }
}

#pragma mark - Getter
- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10.0f;
    }
    return _locationManager;
}

- (CLGeocoder *)geoCoder{
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

- (CLLocation *)location{
    return _location;
}

- (NSMutableArray *)requestBlocks{
    if (!_requestBlocks) {
        _requestBlocks = [NSMutableArray array];
    }
    return _requestBlocks;
}

- (NSMutableArray *)subscribeBlocks{
    if (!_subscribeBlocks) {
        _subscribeBlocks = [NSMutableArray array];
    }
    return _subscribeBlocks;
}
@end
