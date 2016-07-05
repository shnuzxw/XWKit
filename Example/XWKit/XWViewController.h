//
//  XWViewController.h
//  XWKit
//
//  Created by 张校玮 on 06/12/2016.
//  Copyright (c) 2016 张校玮. All rights reserved.
//

@import UIKit;


@interface SectionModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *dataSource;

- (instancetype)initWithTitle:(NSString *)title dataSource:(NSArray *)dataSource;
+ (instancetype)modelWithTitle:(NSString *)title dataSource:(NSArray *)dataSource;

@end


@interface XWViewController : UIViewController 

@end
