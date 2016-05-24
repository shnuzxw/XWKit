//
//  NSArray+XWCategory.h
//  BookingClient
//
//  Created by smile.zhang on 16/5/18.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XWCategory)

/**
 *  是否有效
 *
 *  @return BOOL:YES有效,NO无效.
 */
- (BOOL)xw_isValid;

+ (BOOL)xw_isValidWithArray:(NSArray *)array;

@end
