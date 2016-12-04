//
//  NSString+XWRegular.h
//  ShareCar
//
//  Created by smile.zhang on 2016/11/4.
//  Copyright © 2016年 Zhang Xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XWRegular)


//邮箱
- (BOOL)validateEmail;


//车牌号验证
- (BOOL)validateCarNo;


//车型
- (BOOL)validateCarType;


//用户名
- (BOOL)validateUserName;

// 密码
- (BOOL)validatePasswordFor0_9_AND_A_Z; // 正则匹配用户密码6-18位数字和字母组合
- (BOOL)validatePasswordFor0_9_OR_A_Z;


//身份证号
- (BOOL)validateIdentityCard;


//手机号码验证
- (BOOL)validateMobile;
- (BOOL)validatePhoneForSimple;
- (BOOL)validatePhoneForStrict;

@end
