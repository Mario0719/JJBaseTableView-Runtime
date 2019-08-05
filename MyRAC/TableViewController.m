//
//  TableViewController.m
//  MyRAC
//
//  Created by Mario on 2019/8/5.
//  Copyright © 2019 MS. All rights reserved.
//

#import "TableViewController.h"
#import "JJTableView/JJBaseTableView.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JJBaseTableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setTitle:@"table"];
    
    _dataSource = @[@"1",@"2"];
    _tableView = [[JJBaseTableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.autoNetworkNotice = YES;
    _tableView.backgroundColor = [UIColor grayColor];

    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"1"];
    
    _tableView.enableRefresh = YES;
//    _tableView.endingLoadMore  NO;
    
    __weak typeof(self) weakSelf = self;
    _tableView.tableViewHeaderRefresh = ^{
        // 随机函数，模拟空数据情况
        int x = arc4random() % 2;
        if (x == 0) {
            weakSelf.dataSource = @[];
        }else{
            weakSelf.dataSource = @[@"1",@"2",@"3"];
        }
        [weakSelf.tableView reloadData];
    };
    
    // 点击占位符 回调
    _tableView.tableViewPlaceholderBlock = ^{
        [weakSelf.tableView beginRefresh];
        weakSelf.tableView.tableViewHeaderRefresh();
    };
    
    
    UIButton *networkButton = [UIButton new];
    networkButton.frame = CGRectMake(0, 0, 44, 44);
    [networkButton setTitle:@"断网" forState:0];
    [networkButton setTitle:@"恢复" forState:UIControlStateSelected];
    [networkButton addTarget:self action:@selector(networkChange:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:networkButton];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)networkChange:(UIButton *)sender{
    sender.selected = !sender.selected;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetworkChange" object:@(!sender.selected)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
@end
