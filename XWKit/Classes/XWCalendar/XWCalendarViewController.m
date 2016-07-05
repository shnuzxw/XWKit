//
//  XWCalendarViewController.m
//  XWCalendar
//
//  Created by smile.zhang on 16/5/26.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "XWCalendarViewController.h"

@interface XWCalendarViewController () <XWCalendarViewDelegate>

@property (nonatomic, assign) XWCalendarViewControllerVerticalType type;

@end

@implementation XWCalendarViewController
- (instancetype)initWithConfig:(XWCalendarViewConfig *)config
                          type:(XWCalendarViewControllerVerticalType)type
                      delegate:(id<XWCalendarViewDataSource>)delegate {

    if (self = [super init]) {

        _type = type;

        if (_type == XWCalendarViewControllerVerTicalTypeCenter) {
            self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
        } else {
            self.view.backgroundColor = [UIColor clearColor];
        }

        CGRect frame = CGRectMake(0, [self calculateYWithHeight:400], self.view.bounds.size.width, 300);

        _calendarView = [[XWCalendarView alloc] initWithFrame:frame
                                                       config:config
                                                     dataSourece:delegate delegate:self];
        CGFloat height = [_calendarView height];

        _calendarView.frame = CGRectMake(0, [self calculateYWithHeight:height], self.view.bounds.size.width, height);

        [self.view addSubview:_calendarView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Overwrite
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (_delegate && [_delegate respondsToSelector:@selector(xwCalendarViewController:didDeselectedDateComponents:)]) {

        [_delegate xwCalendarViewController:self didDeselectedDateComponents:nil];
    }
}

#pragma mark - Private Functions
- (CGFloat)calculateYWithHeight:(CGFloat)height {
    CGFloat y = 0;
    if (_type == XWCalendarViewControllerVerTicalTypeBottom) {
        y = self.view.bounds.size.height - height;
    } else if (_type == XWCalendarViewControllerVerTicalTypeCenter) {
        y = (self.view.bounds.size.height - height) / 2;
    } else if (_type == XWCalendarViewControllerVerTicalTypeTop) {
        y = 0;
    }
    return y;
}

#pragma mark - XWCalendarViewReLayoutDelegate
- (void)xwCalendarView:(XWCalendarView *)calendarView normalHeight:(CGFloat)normalHeight {

    CGFloat y = [self calculateYWithHeight:normalHeight];
    [UIView animateWithDuration:0.25 animations:^{
        self.calendarView.frame = CGRectMake(0, y, calendarView.frame.size.width, normalHeight);
    }];
}

- (void)xwCalendarView:(XWCalendarView *)calendarView didSelectedDateComponents:(NSArray<NSDateComponents *> *)dateComponents {

    if (_delegate && [_delegate respondsToSelector:@selector(xwCalendarViewController:didSelectedDateComponents:)]) {

        [_delegate xwCalendarViewController:self didSelectedDateComponents:dateComponents];
    }
}

- (void)xwCalendarView:(XWCalendarView *)calendarView didDeselectedDateComponents:(NSArray<NSDateComponents *> *)dateComponents {

    if (_delegate && [_delegate respondsToSelector:@selector(xwCalendarViewController:didDeselectedDateComponents:)]) {

        [_delegate xwCalendarViewController:self didDeselectedDateComponents:dateComponents];
    }
}

@end
