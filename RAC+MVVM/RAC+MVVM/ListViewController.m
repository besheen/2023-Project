//
//  ListViewController.m
//  RAC+MVVM
//
//  Created by bisheen on 2023/4/7.
//

#import "ListViewController.h"
#import "ListHeaderView.h"
#import "ListTableCell.h"

#import "ListViewModel.h"

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ListHeaderView *headerView;

@property (nonatomic, strong) ListViewModel *viewModel;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ListTableCell class]) forIndexPath:indexPath];
    [cell configCellWithViewModel:self.viewModel.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"推荐圈子";
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView).insets(UIEdgeInsetsMake(0, 20, 0, 0));
    }];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)setupNavigation {
    self.navigationItem.title = @"圈子列表";
}

- (void)addSubviews {
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)bindViewModel {
    
}

#pragma mark - Getters
- (UITableView *)tableView {
    if (!_tableView) {
        Class cellClass = [ListTableCell class];
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
    }
    return _tableView;
}

- (ListHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ListHeaderView alloc] initWithViewModel:self.viewModel.headerViewModel];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 160);
    }
    return _headerView;
}

- (ListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ListViewModel alloc] init];
    }
    return _viewModel;
}
@end
