# XWCalendar

## Example
具体使用详情，参见Demo。
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XWCalendar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "XWCalendar" :git=>'https://github.com/shnuzxw/XWCalendar.git'
```


## 具体使用方法
能见到的内容基本都可以进行有效设置。
### 使用XWCalendarView

```
@interface XWViewController () <XWCalendarViewDelegate, XWCalendarViewDataSource, XWCalendarViewControllerDelegate>

@property (nonatomic, strong) XWCalendarViewConfig *config; // 日历配置信息

@property (nonatomic, strong) NSArray *weekdaySymbols; // 星期标题数组

@property (nonatomic, strong) UICollectionViewFlowLayout *weekdaysFlowLayout; // 星期UI设置

@property (nonatomic, strong) UICollectionViewFlowLayout *daysFlowLayout; // 日期UI设置

@property (nonatomic, strong) XWCalendarTransition <UIViewControllerTransitioningDelegate> *transition;

@property (nonatomic, strong) XWCalendarView *calendar;

@end

@implementation XWViewController

- (void)viewDidLoad {
[super viewDidLoad];
// Do any additional setup after loading the view, typically from a nib.

_calendar = [[XWCalendarView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 500)
config:self.config
dataSourece:self
delegate:self];

[self.view addSubview:_calendar];

self.title = @"XWCalendarViewDemo";

self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"日历1" style:UIBarButtonItemStylePlain target:self action:@selector(pushXWCalendarViewController1)];

self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"日历2" style:UIBarButtonItemStylePlain target:self action:@selector(pushXWCalendarViewController2)];
}

#pragma mark - Prevate Functions
- (void)pushXWCalendarViewController1 {

// 隐藏有当前视图控制器日历
self.calendar.alpha = 0;

XWCalendarViewController *controller = [[XWCalendarViewController alloc] initWithConfig:self.config
type:XWCalendarViewControllerVerTicalTypeCenter
delegate:self];
controller.delegate = self;
controller.modalPresentationStyle = UIModalPresentationCustom;
_transition = [[XWCalendarTransition alloc] initWithType:XWCalendarTransitionTypeZoom];
controller.transitioningDelegate = _transition;
[self presentViewController:controller animated:YES completion:^{

}];
}

- (void)pushXWCalendarViewController2 {

// 隐藏有当前视图控制器日历
self.calendar.alpha = 0;

XWCalendarViewController *controller = [[XWCalendarViewController alloc] initWithConfig:self.config
type:XWCalendarViewControllerVerTicalTypeBottom
delegate:self];
controller.delegate = self;
controller.modalPresentationStyle = UIModalPresentationCustom;
_transition = [[XWCalendarTransition alloc] initWithType:XWCalendarTransitionTypePresent];
controller.transitioningDelegate = _transition;
[self presentViewController:controller animated:YES completion:^{

}];
}

#pragma mark - Getter
- (NSArray *)weekdaySymbols {
if (!_weekdaySymbols) {
_weekdaySymbols = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
}
return _weekdaySymbols;
}

- (XWCalendarViewConfig *)config {
if (!_config) {

XWCalendarViewConfig *config = [[XWCalendarViewConfig alloc] init];

config.date = [NSDate dateWithTimeIntervalSinceNow:60*60*24*7];
config.toolBarHeight = 44.0f;
config.controlViewHeight = 44.0f;

config.toolBarBackgroundColor = [UIColor redColor];
config.toolBarTintColor = [UIColor whiteColor];
config.toolBarBarTintColor = [UIColor darkGrayColor];

config.controlBarBackgroundColor = [UIColor cyanColor];
config.controlBarTintColor = [UIColor darkGrayColor];
config.controlBarBarTintColor = [UIColor whiteColor];

config.weekdaysViewBackgroundColor = [UIColor whiteColor];
config.daysViewBackgroundColor = [UIColor blueColor];
config.showToolBar = YES;
config.showToday = NO;
config.allowNullDate = YES;
config.executionDelegateWhenSelected = NO;
config.executionDelegateWhenUnSelected = NO;

config.weekdaysFlowLayout = self.weekdaysFlowLayout;
config.daysFlowLayout = self.daysFlowLayout;
config.weekdaySymbols = self.weekdaySymbols;

_config = config;
}
return _config;
}

- (UICollectionViewFlowLayout *)weekdaysFlowLayout {
if (!_weekdaysFlowLayout) {
UICollectionViewFlowLayout *weekdaysFlowLayout = [[UICollectionViewFlowLayout alloc] init];
weekdaysFlowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
weekdaysFlowLayout.minimumInteritemSpacing = 2;
weekdaysFlowLayout.minimumLineSpacing = 0;
weekdaysFlowLayout.itemSize = CGSizeMake(0, 35);
_weekdaysFlowLayout = weekdaysFlowLayout;
}
return _weekdaysFlowLayout;
}

- (UICollectionViewFlowLayout *)daysFlowLayout {
if (!_daysFlowLayout) {
UICollectionViewFlowLayout *daysFlowLayout = [[UICollectionViewFlowLayout alloc] init];
daysFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
daysFlowLayout.minimumInteritemSpacing = 2;
daysFlowLayout.minimumLineSpacing = 2;
daysFlowLayout.itemSize = CGSizeMake(0, 43);
_daysFlowLayout = daysFlowLayout;
}
return _daysFlowLayout;
}

end
```

### 实现代理方法

```
- (void)xwCalendarView:(XWCalendarView *)calendarView normalHeight:(CGFloat)normalHeight {

[UIView animateWithDuration:0.05 animations:^{
CGRect frame = calendarView.frame;
calendarView.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), normalHeight);
}];
}

- (void)xwCalendarView:(XWCalendarView *)calendarView didSelectedDateComponents:(NSArray<NSDateComponents *> *)dateComponents {

NSLog(@"已选择日期：%@",[dateComponents firstObject].date);
}

- (void)xwCalendarView:(XWCalendarView *)calendarView didDeselectedDateComponents:(NSArray<NSDateComponents *> *)dateComponents {

NSLog(@"已取消");
}

#pragma mark - XWCalendarViewDelegate
- (NSString *)xwCalendarView:(XWCalendarView *)calendarView titleForBarButtonItemType:(XWCalendarViewBarButtonItemType)type {

if (type == XWCalendarViewBarButtonItemTypeOK) {
return @"确定";
} else if (type == XWCalendarViewBarButtonItemTypeCancel) {
return @"取消";
} else if (type == XWCalendarViewBarButtonItemTypeToday) {
return @"今日";
} else if (type == XWCalendarViewBarButtonItemTypeRight) {
return @"下月";
} else if (type == XWCalendarViewBarButtonItemTypeLeft) {
return @"上月";
} else if (type == XWCalendarViewBarButtonItemTypeUp) {
return @"上年";
} else if (type == XWCalendarViewBarButtonItemTypeDown) {
return @"下年";
} else {
return @"Title";
}
}

- (UIImage *)xwCalendarView:(XWCalendarView *)calendarView imageForBarButtonItemType:(XWCalendarViewBarButtonItemType)type {

if (type == XWCalendarViewBarButtonItemTypeOK) {

} else if (type == XWCalendarViewBarButtonItemTypeCancel) {

} else if (type == XWCalendarViewBarButtonItemTypeToday) {

} else if (type == XWCalendarViewBarButtonItemTypeRight) {

return [UIImage imageNamed:@"right"];

} else if (type == XWCalendarViewBarButtonItemTypeLeft) {

return [UIImage imageNamed:@"left"];

} else if (type == XWCalendarViewBarButtonItemTypeUp) {

return [UIImage imageNamed:@"up"];

} else if (type == XWCalendarViewBarButtonItemTypeDown) {

return [UIImage imageNamed:@"down"];

}

return nil;
}

- (BOOL)xwCalendarView:(XWCalendarView *)calendarView canSelectForDateComponents:(NSDateComponents *)dateComponents {
return YES;
}

- (BOOL)xwCalendarView:(XWCalendarView *)calendarView isHolidayForDateComponents:(NSDateComponents *)dateComponents {

if (dateComponents.yearForWeekOfYear == 2016 && dateComponents.month == 6 && dateComponents.day == 24) {
return YES;
}
return NO;
}

- (void)xwCalendarView:(XWCalendarView *)calendarView weekdayCell:(XWWeekCollectionViewCell *)cell forWeekday:(NSInteger)weekday {

NSDictionary *dict;

if (weekday == 6 || weekday == 0) {

dict = @{NSForegroundColorAttributeName: [UIColor darkGrayColor]};
} else {

dict = @{NSForegroundColorAttributeName: [UIColor blackColor]};
}

cell.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:_weekdaySymbols[weekday] attributes:dict];
}

- (void)xwCalendarView:(XWCalendarView *)calendarView dayCell:(XWDayCollectionViewCell *)cell type:(XWCalendarViewDayCellUIType)type {

if (type == XWCalendarViewDayCellUITypeNormal) {

//        cell.detailLabel.text = @"Normal";
cell.titleLabel.textColor = [UIColor blackColor];
cell.detailLabel.textColor = [UIColor blackColor];
cell.contentView.backgroundColor = [UIColor whiteColor];
cell.imageView.backgroundColor = [UIColor clearColor];

} else if (type == XWCalendarViewDayCellUITypeToday) {

cell.detailLabel.text = @"今天";
cell.imageView.backgroundColor = [UIColor redColor];

} else if (type == XWCalendarViewDayCellUITypeYesterday) {

cell.detailLabel.text = @"昨天";
cell.imageView.backgroundColor = [UIColor brownColor];

} else if (type == XWCalendarViewDayCellUITypeTomorrow) {

cell.detailLabel.text = @"明天";
cell.imageView.backgroundColor = [UIColor yellowColor];

} else if (type == XWCalendarViewDayCellUITypeSelected) {

cell.titleLabel.textColor = [UIColor whiteColor];
cell.detailLabel.textColor = [UIColor whiteColor];
cell.contentView.backgroundColor = [UIColor redColor];

} else if (type == XWCalendarViewDayCellUITypeAllowSelection) {

cell.detailLabel.textColor = [UIColor blackColor];
cell.contentView.backgroundColor = [UIColor whiteColor];

} else if (type == XWCalendarViewDayCellUITypeNotAllowSelection) {

cell.detailLabel.text = @"不可选";
cell.detailLabel.textColor = [UIColor darkGrayColor];
cell.contentView.backgroundColor = [UIColor darkGrayColor];

} else if (type == XWCalendarViewDayCellUITypeWeekend) {

cell.titleLabel.textColor = [UIColor darkGrayColor];
cell.detailLabel.textColor = [UIColor darkGrayColor];
cell.detailLabel.text = @"休";

} else if (type == XWCalendarViewDayCellUITypeHoliday) {
cell.titleLabel.textColor = [UIColor greenColor];
cell.detailLabel.textColor = [UIColor greenColor];
cell.imageView.backgroundColor = [UIColor greenColor];
cell.detailLabel.text = @"假";
}
}

#pragma mark - XWCalendarViewControllerDelegate
- (void)xwCalendarViewController:(XWCalendarViewController *)calendarViewController didSelectedDateComponents:(NSArray<NSDateComponents *> *)dateComponents {

[calendarViewController dismissViewControllerAnimated:YES completion:^{

}];

NSLog(@"已选择日期：%@",[dateComponents firstObject].date);
}

- (void)xwCalendarViewController:(XWCalendarViewController *)calendarViewController didDeselectedDateComponents:(NSArray<NSDateComponents *> *)dateComponents {

[calendarViewController dismissViewControllerAnimated:YES completion:^{

}];

NSLog(@"已取消");
}
```

### 使用XWCalendarViewController

```
XWCalendarViewController *controller = [[XWCalendarViewController alloc] initWithConfig:self.config
type:XWCalendarViewControllerVerTicalTypeBottom
delegate:self];
controller.delegate = self;
controller.modalPresentationStyle = UIModalPresentationCustom;
_transition = [[XWCalendarTransition alloc] initWithType:XWCalendarTransitionTypePresent];
controller.transitioningDelegate = _transition;
[self presentViewController:controller animated:YES completion:nil];
```

## Author

张校玮, weixiao08@qq.com

## License

XWCalendar is available under the MIT license. See the LICENSE file for more info.

