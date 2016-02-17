//
//  XWLocationManager.h
//  ShareCar
//
//  Created by smile.zhang on 15/9/12.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Single.h"

typedef void(^LocationSuccessBlock)(CLLocation *newLocation, BOOL isSuccess, CLAuthorizationStatus status);

@interface XWLocationManager : NSObject

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geoCoder;
@property (nonatomic, strong, getter=location) CLLocation *location;

SingletonInterface(XWLocationManager);

- (BOOL)locationServicesEnabled;
- (BOOL)requestWhenInUseAuthorization; // 8.0及其以上
- (BOOL)requestAlwaysAuthorization; // 8.0及其以上

- (void)startUpdatingLocation;
- (void)requestLocationWithBlock:(LocationSuccessBlock)block; // 请求地理位置，仅一次
- (void)subscribeLocationUpdatesWithBlock:(LocationSuccessBlock)block; // 监控地址位置的变更
- (void)stopUpdatingLocation;

- (void)addRequestLocationUpdateSuccessBlock:(LocationSuccessBlock)block; // 添加只请求一次的Block
- (void)addSubScribeLocationUpdateSuccessBlock:(LocationSuccessBlock)block; // 添加监控位置的Block，重复执行

-(void)getCoordinateByAddress:(NSString *)address
            completionHandler:(CLGeocodeCompletionHandler)completionHandler;
- (void)getAddressByLocation:(CLLocation *)location
           completionHandler:(CLGeocodeCompletionHandler)completionHandler;
-(void)getAddressByLatitude:(CLLocationDegrees)latitude
                  longitude:(CLLocationDegrees)longitude
          completionHandler:(CLGeocodeCompletionHandler)completionHandler;
@end
