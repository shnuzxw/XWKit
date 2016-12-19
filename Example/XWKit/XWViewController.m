//
//  XWViewController.m
//  XWKit
//
//  Created by 张校玮 on 06/12/2016.
//  Copyright (c) 2016 张校玮. All rights reserved.
//

#import "XWViewController.h"
//#import "XWCalendarExampleController.h"

NSString * const kCellIdentifier = @"Cell";

@implementation SectionModel

- (instancetype)initWithTitle:(NSString *)title dataSource:(NSArray *)dataSource {
    if (self = [super init]) {
        _title = title;
        _dataSource = dataSource;
    }
    return self;
}

+ (instancetype)modelWithTitle:(NSString *)title dataSource:(NSArray *)dataSource {
    return [[[self class] alloc] initWithTitle:title dataSource:dataSource];
}

@end

@interface XWViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourece;
@end

@implementation XWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"XWKit";
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 复写方法
#pragma mark - Overwrite Methods
#pragma mark -
#pragma mark Life Cycle

#pragma mark  SuperClass Methods

//系统协议
#pragma mark - System Delegate
#pragma mark -
#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self modelWithSection:section].dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

    cell.textLabel.text = [self titleWithIndexPath:indexPath];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self modelWithSection:section].title;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourece.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {

        } else if (row == 1) {

        }
    }
}

//自定义协议
#pragma mark - Custom Delegate
#pragma mark -

#pragma mark - Public Methods
#pragma mark -

//自定义方法
#pragma mark - Private Methods
#pragma mark -
- (SectionModel *)modelWithSection:(NSUInteger)section {
    return [self.dataSourece objectAtIndex:section];
}

- (NSString *)titleWithIndexPath:(NSIndexPath *)indexPath {
    return [[self modelWithSection:indexPath.section].dataSource objectAtIndex:indexPath.row];
}

/* UI */
#pragma mark - ----- UI -----
#pragma mark -

//UI配置
#pragma mark ConfigureUI

// 更新UI
#pragma mark UpdateUI

// 适配UI
#pragma mark MakeConstraints

/* 数据 */
#pragma mark - ----- Data -----
#pragma mark -

//数据请求
#pragma mark Request Data

// 处理数据
#pragma mark Handle Data

/* 事件 */
#pragma mark - ----- Events -----
#pragma mark -

//按钮事件
#pragma mark Event Response

// Push Present视图控制器
#pragma mark Push Present

// Get方法
#pragma mark - Getter
#pragma mark -
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
        [self.view addSubview:_tableView];
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

- (NSMutableArray *)dataSourece {
    if (!_dataSourece) {
        _dataSourece = @[
                         [SectionModel modelWithTitle:@"XWCalendar" dataSource:@[@"XWCalendarView"]],
                         ].mutableCopy;
    }
    return _dataSourece;
}

// Set方法
#pragma mark - Setter
#pragma mark -

@end
