//
//  XWCalendarView.m
//  XWCalendar
//
//  Created by smile.zhang on 16/5/26.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "XWCalendarView.h"
#import "XWCalendarUnit.h"

#define NumberOfColumn 7

@implementation XWCalendarViewConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _date = [NSDate date];
        _align = YES;

        _toolBarHeight = 44.0f;
        _controlViewHeight = 44.0f;
        _showToolBar = NO;

        _toolBarBackgroundColor = [UIColor whiteColor];
        _controlBarBackgroundColor = [UIColor whiteColor];
        _weekdaysViewBackgroundColor = [UIColor whiteColor];
        _daysViewBackgroundColor = [UIColor whiteColor];

        _weekdaySymbols = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return self;
}

#pragma mark - Getter
- (CGFloat)toolBarHeight {
    if (_showToolBar) {
        return _toolBarHeight;
    } else {
        return 0.0f;
    }
}

@end

@interface XWCalendarView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    
}

@property (nonatomic, weak) id<XWCalendarViewDelegate>   delegate;
@property (nonatomic, weak) id<XWCalendarViewDataSource> dataSource;
@property (nonatomic, strong) UIToolbar                  *toolBar;// 工具栏
@property (nonatomic, strong) UIView                     *contentView;// 内容视图（包含下面所有视图）
@property (nonatomic, strong) UIToolbar                  *controlBar;// 控件视图（年月切换等）
@property (nonatomic, strong) UICollectionView           *weekdaysView;// 星期视图 （周一、周二等）
@property (nonatomic, strong) UICollectionViewFlowLayout *weekdaysLayout;
@property (nonatomic, strong) UICollectionView           *daysView;// 日期视图
@property (nonatomic, strong) UICollectionViewFlowLayout *daysLayout;

@property (nonatomic, strong) UIBarButtonItem *leftItem;// 向左
@property (nonatomic, strong) UIBarButtonItem *rightItem;// 向右
@property (nonatomic, strong) UIBarButtonItem *upItem;// 向上
@property (nonatomic, strong) UIBarButtonItem *downItem;// 向下
@property (nonatomic, strong) UIBarButtonItem *titleItem;
@property (nonatomic, strong) UILabel         *controlViewTitleLabel;// 当前年月
@property (nonatomic, strong) UIBarButtonItem *okButtonItem;// 确定
@property (nonatomic, strong) UIBarButtonItem *cancelButtonItem;// 取消
@property (nonatomic, strong) UIBarButtonItem *todayButtonItem;// 今天
@property (nonatomic, strong) UIBarButtonItem *spaceButtonItem;

@property (nonatomic, strong) XWCalendarUnit *unit;
@property (nonatomic, strong) XWCalendarViewConfig *config;

@property (nonatomic, strong) NSDateComponents *selectedDateComponents;
@property (nonatomic, strong) NSMutableArray *selectedDateComponentsArray;
@end


@implementation XWCalendarView

- (instancetype)initWithFrame:(CGRect)frame
                       config:(XWCalendarViewConfig *)config
                     dataSourece:(id<XWCalendarViewDataSource>)dataSource
                     delegate:(id<XWCalendarViewDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        if (!config) {
            config = [[XWCalendarViewConfig alloc] init];
        }
        _config = config;
        if (_config.allowsMultipleSelection) {
            _selectedDateComponentsArray = @[].mutableCopy;
        }
        _unit = [[XWCalendarUnit alloc] initWithDate:self.config.date isAlign:self.config.align];
        _delegate = delegate;
        _dataSource = dataSource;

        [self makeConstraints];
        [self recalculateFrame];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)makeConstraints {

    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.controlBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.weekdaysView.translatesAutoresizingMaskIntoConstraints = NO;
    self.daysView.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *consTop, *consLeft, *consHeight, *consRight, *consBottom;
    if (_config.showToolBar) {
        consTop = [NSLayoutConstraint constraintWithItem:self.toolBar
                                               attribute:NSLayoutAttributeTop
                                               relatedBy:NSLayoutRelationEqual
                                                  toItem:self
                                               attribute:NSLayoutAttributeTop
                                              multiplier:1.0
                                                constant:0];
        consLeft = [NSLayoutConstraint constraintWithItem:self.toolBar
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:self
                                                attribute:NSLayoutAttributeLeft
                                               multiplier:1.0
                                                 constant:0];
        consHeight = [NSLayoutConstraint constraintWithItem:self.toolBar
                                                  attribute:NSLayoutAttributeHeight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                 multiplier:1
                                                   constant:self.config.toolBarHeight];
        consRight = [NSLayoutConstraint constraintWithItem:self.toolBar
                                                 attribute:NSLayoutAttributeRight
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:self
                                                 attribute:NSLayoutAttributeRight
                                                multiplier:1.0
                                                  constant:0];
        [self addConstraints:@[consTop, consLeft, consHeight, consRight]];
    }

    consTop = [NSLayoutConstraint constraintWithItem:self.contentView
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:_config.showToolBar ? self.toolBar : self
                                           attribute:_config.showToolBar ? NSLayoutAttributeBottom : NSLayoutAttributeTop
                                          multiplier:1.0
                                            constant:0];
    consLeft = [NSLayoutConstraint constraintWithItem:self.contentView
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1.0
                                             constant:0];
    consBottom = [NSLayoutConstraint constraintWithItem:self.contentView
                                              attribute:NSLayoutAttributeBottom
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self
                                              attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                               constant:0];
    consRight = [NSLayoutConstraint constraintWithItem:self.contentView
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self
                                             attribute:NSLayoutAttributeRight
                                            multiplier:1.0
                                              constant:0];
    [self addConstraints:@[consTop, consLeft, consBottom, consRight]];

    consTop = [NSLayoutConstraint constraintWithItem:self.controlBar
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:self.contentView
                                           attribute:NSLayoutAttributeTop
                                          multiplier:1.0
                                            constant:0];
    consLeft = [NSLayoutConstraint constraintWithItem:self.controlBar
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.contentView
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1.0
                                             constant:0];
    consHeight = [NSLayoutConstraint constraintWithItem:self.controlBar
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                             multiplier:1
                                               constant:self.config.controlViewHeight];
    consRight = [NSLayoutConstraint constraintWithItem:self.controlBar
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self.contentView
                                             attribute:NSLayoutAttributeRight
                                            multiplier:1.0
                                              constant:0];
    [self.contentView addConstraints:@[consTop, consLeft, consHeight, consRight]];

    consTop = [NSLayoutConstraint constraintWithItem:self.weekdaysView
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:self.controlBar
                                           attribute:NSLayoutAttributeBottom
                                          multiplier:1.0
                                            constant:0];
    consLeft = [NSLayoutConstraint constraintWithItem:self.weekdaysView
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.contentView
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1.0
                                             constant:0];
    consHeight = [NSLayoutConstraint constraintWithItem:self.weekdaysView
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.contentView
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:0
                                               constant:[self weekdaysViewHeight]];
    consRight = [NSLayoutConstraint constraintWithItem:self.weekdaysView
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self.contentView
                                             attribute:NSLayoutAttributeRight
                                            multiplier:1.0
                                              constant:0];
    [self.contentView addConstraints:@[consTop, consLeft, consHeight, consRight]];

    consTop = [NSLayoutConstraint constraintWithItem:self.daysView
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:self.weekdaysView
                                           attribute:NSLayoutAttributeBottom
                                          multiplier:1.0
                                            constant:0];
    consLeft = [NSLayoutConstraint constraintWithItem:self.daysView
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.contentView
                                            attribute:NSLayoutAttributeLeft
                                           multiplier:1.0
                                             constant:0];
    consBottom = [NSLayoutConstraint constraintWithItem:self.daysView
                                              attribute:NSLayoutAttributeBottom
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.contentView
                                              attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                               constant:0];
    consRight = [NSLayoutConstraint constraintWithItem:self.daysView
                                             attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self.contentView
                                             attribute:NSLayoutAttributeRight
                                            multiplier:1.0
                                              constant:0];
    [self.contentView addConstraints:@[consTop, consLeft, consBottom, consRight]];

}

//系统协议
#pragma mark - System Delegate
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.weekdaysView) {
        return 7;
    } else if (collectionView == self.daysView) {
        return self.unit.dateComponentsOfMonth.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (collectionView == self.weekdaysView) {
        XWWeekCollectionViewCell *weekCell = [collectionView dequeueReusableCellWithReuseIdentifier:kXWweekCellIdentifier
                                                                                       forIndexPath:indexPath];
        if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:weekdayCell:forWeekday:)]) {
            [_dataSource xwCalendarView:self weekdayCell:weekCell forWeekday:indexPath.row];
        } else {
            [self configWeekCell:weekCell indexPath:indexPath];
        }
        return weekCell;
    } else if (collectionView == self.daysView) {
        XWDayCollectionViewCell *dayCell = [collectionView dequeueReusableCellWithReuseIdentifier:kXWDayCellIdentifier
                                                                                     forIndexPath:indexPath];
        [self configDayCell:dayCell indexPath:indexPath];
        return dayCell;
    }

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.daysView && [cell isKindOfClass:[XWDayCollectionViewCell class]]) {
        NSDateComponents *dateComp = self.unit.dateComponentsOfMonth[indexPath.row];
        NSUInteger weekdayOfMonth = dateComp.weekOfMonth;
        if (dateComp.year < self.unit.firstDateComponents.year) {
            weekdayOfMonth = self.unit.firstDateComponents.weekOfMonth;
        } else if (dateComp.year > self.unit.lastDateComponents.year) {
            weekdayOfMonth = self.unit.lastDateComponents.weekOfMonth;
        } else {
            if (dateComp.month < self.unit.firstDateComponents.month) {
                weekdayOfMonth = self.unit.firstDateComponents.weekOfMonth;
            } else if (dateComp.month > self.unit.lastDateComponents.month) {
                weekdayOfMonth = self.unit.lastDateComponents.weekOfMonth;
            }
        }
        CGFloat centerX = self.daysLayout.sectionInset.left + (self.daysLayout.itemSize.width + self.daysLayout.minimumInteritemSpacing) * (dateComp.weekday - 1) + (self.daysLayout.itemSize.width)/2;
        CGFloat centerY = self.daysLayout.sectionInset.top + (self.daysLayout.itemSize.height + self.daysLayout.minimumLineSpacing) * (weekdayOfMonth - 1) + (self.daysLayout.itemSize.height)/2;
        cell.center = CGPointMake(centerX, centerY);
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSDateComponents *dateComp = self.unit.dateComponentsOfMonth[indexPath.row];
    if (_config.allowsMultipleSelection) {
        [self.selectedDateComponentsArray addObject:dateComp];
    } else {
        _selectedDateComponents = dateComp;
    }

    if (self.config.executionDelegateWhenSelected && _delegate && [_delegate respondsToSelector:@selector(xwCalendarView:didSelectedDateComponents:)]) {
        NSArray *array = _config.allowsMultipleSelection ? _selectedDateComponentsArray : @[_selectedDateComponents];
        [_delegate xwCalendarView:self didSelectedDateComponents:array];
    }

    XWDayCollectionViewCell *daycell = (XWDayCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self configHolWeekendTodYesTomUIForDayCell:daycell indexPath:indexPath];

    if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:dayCell:type:)]) {
        [_dataSource xwCalendarView:self dayCell:daycell type:XWCalendarViewDayCellUITypeSelected];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSDateComponents *dateComp = self.unit.dateComponentsOfMonth[indexPath.row];
    if (_config.allowsMultipleSelection) {
        [self.selectedDateComponentsArray removeObject:dateComp];
    }

    if (self.config.allowNullDate && self.config.executionDelegateWhenUnSelected && _delegate && [_delegate respondsToSelector:@selector(xwCalendarView:didDeselectedDateComponents:)]) {
        NSArray *array = _config.allowsMultipleSelection ? _selectedDateComponentsArray : @[_selectedDateComponents];
        [_delegate xwCalendarView:self didDeselectedDateComponents:array];
    }

    XWDayCollectionViewCell *daycell = (XWDayCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:dayCell:type:)]) {
        [_dataSource xwCalendarView:self dayCell:daycell type:XWCalendarViewDayCellUITypeNormal];
    }

    [self configHolWeekendTodYesTomUIForDayCell:daycell indexPath:indexPath];
}

#pragma mark - Private Functions
- (CGFloat)calculateCellWidthWithInsets:(UIEdgeInsets)insets intervalHorizontal:(CGFloat)intervalHorizontal {
    return (CGRectGetWidth(self.contentView.bounds)
            - (insets.left + insets.right)
            - (NumberOfColumn - 1) * intervalHorizontal) / NumberOfColumn;
}

- (void)configDayCell:(XWDayCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {

    NSDateComponents *dateComp = self.unit.dateComponentsOfMonth[indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)dateComp.day];

    BOOL canSelect = YES;
    if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:canSelectForDateComponents:)]) {
        canSelect = [_dataSource xwCalendarView:self canSelectForDateComponents:dateComp];
    }
    cell.userInteractionEnabled = canSelect;

    if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:dayCell:type:)]) {
        if (canSelect) {
            [_dataSource xwCalendarView:self dayCell:cell type:XWCalendarViewDayCellUITypeAllowSelection];
        } else {
            [_dataSource xwCalendarView:self dayCell:cell type:XWCalendarViewDayCellUITypeNotAllowSelection];
        }
    }

    [self configHolWeekendTodYesTomUIForDayCell:cell indexPath:indexPath];
}

- (void)configWeekCell:(XWWeekCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSString *title = @"";
    if (self.config.weekdaySymbols && self.config.weekdaySymbols.count == 7) {
        title = self.config.weekdaySymbols[indexPath.row];
    } else {
        title = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    cell.titleLabel.text = title;
}

/** HolidayOrWeekendOrTodayOrYesterdayOrTommorowUIConfig 配置假期、周末、今天、昨天、明天的UI*/
- (void)configHolWeekendTodYesTomUIForDayCell:(XWDayCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {

    NSDateComponents *dateComp = self.unit.dateComponentsOfMonth[indexPath.row];
    BOOL isHoliday = NO;
    if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:isHolidayForDateComponents:)]) {
        isHoliday = [_dataSource xwCalendarView:self isHolidayForDateComponents:dateComp];
    }

    if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:dayCell:type:)]) {

        [_dataSource xwCalendarView:self dayCell:cell type:XWCalendarViewDayCellUITypeNormal];
        
        if (isHoliday) {
            [_dataSource xwCalendarView:self dayCell:cell type:XWCalendarViewDayCellUITypeHoliday];
        }

        if ([self.unit.calendar isDateInWeekend:dateComp.date]) {
            [_dataSource xwCalendarView:self dayCell:cell type:XWCalendarViewDayCellUITypeWeekend];
        }

        if ([self.unit.calendar isDateInToday:dateComp.date]) {
            [_dataSource xwCalendarView:self dayCell:cell type:XWCalendarViewDayCellUITypeToday];
        }
        if ([self.unit.calendar isDateInYesterday:dateComp.date]) {
            [_dataSource xwCalendarView:self dayCell:cell type:XWCalendarViewDayCellUITypeYesterday];
        }
        if ([self.unit.calendar isDateInTomorrow:dateComp.date]) {
            [_dataSource xwCalendarView:self dayCell:cell type:XWCalendarViewDayCellUITypeTomorrow];
        }
    }
}

- (NSArray *)fetchSelectedDateComponents {
    NSArray *array;
    if (_config.allowsMultipleSelection) {
        array = _selectedDateComponentsArray;
    } else {
        if (_selectedDateComponents) {
            array = @[_selectedDateComponents];
        }
    }
    return array;
}

- (void)recalculateFrame {
    if (_delegate) {
        [_delegate xwCalendarView:self normalHeight:[self height]];
    }
}

- (CGFloat)height {
    CGFloat h = self.config.toolBarHeight;
    h += self.config.controlViewHeight;
    h += [self weekdaysViewHeight];
    h += [self daysViewHeight];
    return h;
}

- (CGFloat)weekdaysViewHeight {
    return (self.weekdaysLayout.sectionInset.top + self.weekdaysLayout.itemSize.height + self.weekdaysLayout.minimumLineSpacing + self.weekdaysLayout.sectionInset.bottom);
}

- (CGFloat)daysViewHeight {
    return (self.daysLayout.sectionInset.top + self.unit.weeksOfMonth * (self.daysLayout.itemSize.height + self.daysLayout.minimumLineSpacing) - self.daysLayout.minimumLineSpacing + self.daysLayout.sectionInset.bottom);
}

- (void)canfigControlViewTitleLabel {
    self.controlViewTitleLabel.text = [NSString stringWithFormat:@"%ld年%ld月",(long)self.unit.dateComponents.year,(long)self.unit.dateComponents.month];
}

- (void)addMonths:(NSInteger)months {
    [self.unit addMonths:months];
    [self.daysView reloadData];
    [self canfigControlViewTitleLabel];
    [self recalculateFrame];
}

#pragma mark - Actions
- (void)doneClicked:(id)sender {

    if (_delegate && [_delegate respondsToSelector:@selector(xwCalendarView:didSelectedDateComponents:)]) {

        [_delegate xwCalendarView:self didSelectedDateComponents:[self fetchSelectedDateComponents]];
    }
}

- (void)cancelClicked:(id)sender {

    if (_delegate && [_delegate respondsToSelector:@selector(xwCalendarView:didDeselectedDateComponents:)]) {

        [_delegate xwCalendarView:self didDeselectedDateComponents:[self fetchSelectedDateComponents]];
    }
}

- (void)todayClicked:(id)sender {
    [self.unit updateWithDate:[NSDate date]];
    [self.daysView reloadData];
    [self canfigControlViewTitleLabel];
    [self recalculateFrame];
}

- (void)upClicked:(id)sender {
    [self addMonths:-12];
}

- (void)downClicked:(id)sender {
    [self addMonths:12];
}

- (void)leftClicked:(id)sender {
    [self addMonths:-1];
}

- (void)rightClicked:(id)sender {
    [self addMonths:1];
}

#pragma mark - Getter
- (UIToolbar *)toolBar {
    if (!_toolBar) {
        // 这里的Frame是随便给的，后面会再进行适配
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];

        if (self.config.toolBarBackgroundColor) {
            _toolBar.backgroundColor = self.config.toolBarBackgroundColor;
        }

        if (self.config.toolBarTintColor) {
            _toolBar.tintColor = self.config.toolBarTintColor;
        }

        if (self.config.toolBarBarTintColor) {
            _toolBar.barTintColor = self.config.toolBarBarTintColor;
        }


        if (self.config.showToday) {
            _toolBar.items = @[self.cancelButtonItem,
                               self.spaceButtonItem,
                               self.todayButtonItem,
                               self.spaceButtonItem,
                               self.okButtonItem];
        } else {
            _toolBar.items = @[self.cancelButtonItem,
                               self.spaceButtonItem,
                               self.okButtonItem];
        }
        [self addSubview:_toolBar];
    }
    return _toolBar;
}

- (UIBarButtonItem *)okButtonItem {
    if (!_okButtonItem) {
        UIImage *image;
        NSString *title = @"";
        if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:imageForBarButtonItemType:)]) {
            image = [_dataSource xwCalendarView:self imageForBarButtonItemType:XWCalendarViewBarButtonItemTypeOK];
        } else {
            if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:titleForBarButtonItemType:)]) {
                title = [_dataSource xwCalendarView:self titleForBarButtonItemType:XWCalendarViewBarButtonItemTypeOK];
            }
        }
        if (image) {
            _okButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(doneClicked:)];
        } else {
            if (title && title.length > 0) {
                _okButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(doneClicked:)];

            } else {
                _okButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(doneClicked:)];
            }
        }
    }
    return _okButtonItem;
}

- (UIBarButtonItem *)cancelButtonItem {
    if (!_cancelButtonItem) {
        UIImage *image;
        NSString *title = @"";
        if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:imageForBarButtonItemType:)]) {
            image = [_dataSource xwCalendarView:self imageForBarButtonItemType:XWCalendarViewBarButtonItemTypeCancel];
        } else {
            if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:titleForBarButtonItemType:)]) {
                title = [_dataSource xwCalendarView:self titleForBarButtonItemType:XWCalendarViewBarButtonItemTypeCancel];
            }
        }
        if (image) {
            _cancelButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(cancelClicked:)];
        } else {
            if (title && title.length > 0) {
                _cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(cancelClicked:)];
            } else {
                _cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(cancelClicked:)];
            }
        }
    }
    return _cancelButtonItem;
}

- (UIBarButtonItem *)todayButtonItem {
    if (!_todayButtonItem) {
        UIImage *image;
        NSString *title = @"今天";
        if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:imageForBarButtonItemType:)]) {
            image = [_dataSource xwCalendarView:self imageForBarButtonItemType:XWCalendarViewBarButtonItemTypeToday];
        } else {
            if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:titleForBarButtonItemType:)]) {
                title = [_dataSource xwCalendarView:self titleForBarButtonItemType:XWCalendarViewBarButtonItemTypeToday];
            }
        }
        if (image) {
            _todayButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(todayClicked:)];
        } else {
            _todayButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(todayClicked:)];
        }

    }
    return _todayButtonItem;
}

- (UIBarButtonItem *)spaceButtonItem {
    if (!_spaceButtonItem) {
        _spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                         target:self
                                                                         action:nil];
    }
    return _spaceButtonItem;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIToolbar *)controlBar {
    if (!_controlBar) {
        _controlBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];

        if (self.config.controlBarBackgroundColor) {
            _controlBar.backgroundColor = self.config.controlBarBackgroundColor;
        }

        if (self.config.controlBarTintColor) {
            _controlBar.tintColor = self.config.controlBarTintColor;
        }

        if (self.config.controlBarBarTintColor) {
            _controlBar.barTintColor = self.config.controlBarBarTintColor;
        }

        _controlBar.items = @[self.upItem,
                              self.spaceButtonItem,
                              self.leftItem,
                              self.spaceButtonItem,
                              self.titleItem,
                              self.spaceButtonItem,
                              self.rightItem,
                              self.spaceButtonItem,
                              self.downItem,];
        [self.contentView addSubview:_controlBar];
    }
    return _controlBar;
}

- (UIBarButtonItem *)upItem {
    if (!_upItem) {
        UIImage *image;
        NSString *title = @"上一年";
        if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:imageForBarButtonItemType:)]) {
            image = [_dataSource xwCalendarView:self imageForBarButtonItemType:XWCalendarViewBarButtonItemTypeUp];
        } else {
            if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:titleForBarButtonItemType:)]) {
                title = [_dataSource xwCalendarView:self titleForBarButtonItemType:XWCalendarViewBarButtonItemTypeUp];
            }
        }
        if (image) {
            _upItem = [[UIBarButtonItem alloc] initWithImage:image
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(upClicked:)];
        } else {
            _upItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(upClicked:)];
        }
    }
    return _upItem;
}

- (UIBarButtonItem *)downItem {
    if (!_downItem) {
        UIImage *image;
        NSString *title = @"下一年";
        if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:imageForBarButtonItemType:)]) {
            image = [_dataSource xwCalendarView:self imageForBarButtonItemType:XWCalendarViewBarButtonItemTypeDown];
        } else {
            if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:titleForBarButtonItemType:)]) {
                title = [_dataSource xwCalendarView:self titleForBarButtonItemType:XWCalendarViewBarButtonItemTypeDown];
            }
        }
        if (image) {
            _downItem = [[UIBarButtonItem alloc] initWithImage:image
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(downClicked:)];
        } else {
            _downItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(downClicked:)];
        }
    }
    return _downItem;
}

- (UIBarButtonItem *)leftItem {
    if (!_leftItem) {
        UIImage *image;
        NSString *title = @"上个月";
        if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:imageForBarButtonItemType:)]) {
            image = [_dataSource xwCalendarView:self imageForBarButtonItemType:XWCalendarViewBarButtonItemTypeLeft];
        } else {
            if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:titleForBarButtonItemType:)]) {
                title = [_dataSource xwCalendarView:self titleForBarButtonItemType:XWCalendarViewBarButtonItemTypeLeft];
            }
        }
        if (image) {
            _leftItem = [[UIBarButtonItem alloc] initWithImage:image
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(leftClicked:)];
        } else {
            _leftItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(leftClicked:)];
        }
    }
    return _leftItem;
}

- (UIBarButtonItem *)rightItem {
    if (!_rightItem) {
        UIImage *image;
        NSString *title = @"下个月";
        if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:imageForBarButtonItemType:)]) {
            image = [_dataSource xwCalendarView:self imageForBarButtonItemType:XWCalendarViewBarButtonItemTypeRight];
        } else {
            if (_dataSource && [_dataSource respondsToSelector:@selector(xwCalendarView:titleForBarButtonItemType:)]) {
                title = [_dataSource xwCalendarView:self titleForBarButtonItemType:XWCalendarViewBarButtonItemTypeRight];
            }
        }
        if (image) {
            _rightItem = [[UIBarButtonItem alloc] initWithImage:image
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(rightClicked:)];
        } else {
            _rightItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(rightClicked:)];

        }
    }
    return _rightItem;
}

- (UIBarButtonItem *)titleItem {
    if (!_titleItem) {
        _titleItem = [[UIBarButtonItem alloc] initWithCustomView:self.controlViewTitleLabel];
    }
    return _titleItem;
}

- (UILabel *)controlViewTitleLabel{
    if (!_controlViewTitleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        _controlViewTitleLabel = label;
        [self canfigControlViewTitleLabel];
    }
    return _controlViewTitleLabel;
}

- (UICollectionView *)weekdaysView {
    if (!_weekdaysView) {
        _weekdaysView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.weekdaysLayout];
        _weekdaysView.dataSource = self;
        _weekdaysView.delegate = self;
        _weekdaysView.backgroundColor = self.config.weekdaysViewBackgroundColor;
        _weekdaysView.allowsSelection = NO;
        [_weekdaysView registerClass:[XWWeekCollectionViewCell class] forCellWithReuseIdentifier:kXWweekCellIdentifier];
        [self.contentView addSubview:_weekdaysView];
    }
    return _weekdaysView;
}

- (UICollectionViewFlowLayout *)weekdaysLayout {
    if (!_weekdaysLayout) {
        _weekdaysLayout = _config.weekdaysFlowLayout;
        CGFloat width = [self calculateCellWidthWithInsets:_weekdaysLayout.sectionInset
                                        intervalHorizontal:_weekdaysLayout.minimumInteritemSpacing];
        if (!_weekdaysLayout) {
            _weekdaysLayout = [[UICollectionViewFlowLayout alloc] init];
            _weekdaysLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
            _weekdaysLayout.minimumInteritemSpacing = 0;
            _weekdaysLayout.minimumLineSpacing = 0;
            _weekdaysLayout.itemSize = CGSizeMake(width, 50);
        } else {
            _weekdaysLayout.itemSize = CGSizeMake(width, _weekdaysLayout.itemSize.height);
        }
    }
    return _weekdaysLayout;
}

- (UICollectionView *)daysView {
    if (!_daysView) {
        _daysView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.daysLayout];
        _daysView.dataSource = self;
        _daysView.delegate = self;
        _daysView.backgroundColor = self.config.daysViewBackgroundColor;
        _daysView.allowsMultipleSelection = self.config.allowsMultipleSelection;
        [_daysView registerClass:[XWDayCollectionViewCell class] forCellWithReuseIdentifier:kXWDayCellIdentifier];
        [self.contentView addSubview:_daysView];
    }
    return _daysView;
}

- (UICollectionViewFlowLayout *)daysLayout {
    if (!_daysLayout) {
        _daysLayout = _config.daysFlowLayout;
        CGFloat width = [self calculateCellWidthWithInsets:_daysLayout.sectionInset
                                        intervalHorizontal:_daysLayout.minimumInteritemSpacing];
        if (!_daysLayout) {
            _daysLayout = [[UICollectionViewFlowLayout alloc] init];
            _daysLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
            _daysLayout.minimumInteritemSpacing = 5;
            _daysLayout.minimumLineSpacing = 5;

            _daysLayout.itemSize = CGSizeMake(width, 50);
        } else {
            _daysLayout.itemSize = CGSizeMake(width, _daysLayout.itemSize.height);
        }
    }
    return _daysLayout;
}

@end
