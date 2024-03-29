//
//  ListViewModel.m
//  RAC+MVVM
//
//  Created by bisheen on 2023/4/7.
//

#import "ListViewModel.h"
#import "ListCellViewModel.h"

@interface ListViewModel ()

@property (nonatomic, assign) NSUInteger currentPage;
@end

@implementation ListViewModel

- (void)initialBind {
    @weakify(self);
    
    // 监听刷新产生的数据
    [self.refreshCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *result) {
        // 处理返回数据，将数据转为VM，便于适配View，并通知界面刷新
        @strongify(self);
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i++) {
            ListCellViewModel *cellViewModel = [[ListCellViewModel alloc] init];
//            cellViewModel.avatarStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
            cellViewModel.avatarStr = @"placeholder_icon";
            cellViewModel.name = @"财税培训圈子";
            [tempArray addObject:cellViewModel];
        }
        self.headerViewModel.title = @"已加入的圈子";
        self.headerViewModel.dataArray = tempArray;
        
        tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            ListCellViewModel *cellViewModel = [[ListCellViewModel alloc] init];
            cellViewModel.avatarStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
            cellViewModel.name = @"iOS培训圈子";
            cellViewModel.articleNum = @"1568";
            cellViewModel.peopleNum = @"586";
            cellViewModel.topicNum = @"5748";
            cellViewModel.content = @"自己交保险是不是只能交养老和医疗，费用是多少?";
            [tempArray addObject:cellViewModel];
        }
        self.dataArray = tempArray;
        
        [self.headerViewModel.refreshUISubject sendNext:nil];
        [self.refreshEndSubject sendNext:@"刷新成功"];
    }];
    // 监听刷新状态
    [[self.refreshCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在刷新数据...");
        }
        else {
            NSLog(@"刷新成功");
        }
    }];
    
    [self.loadMoreCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
        for (int i = 0; i < 10; i++) {
            ListCellViewModel *cellViewModel = [[ListCellViewModel alloc] init];
            cellViewModel.avatarStr = @"http://mmbiz.qpic.cn/mmbiz/XxE4icZUMxeFjluqQcibibdvEfUyYBgrQ3k7kdSMEB3vRwvjGecrPUPpHW0qZS21NFdOASOajiawm6vfKEZoyFoUVQ/640?wx_fmt=jpeg&wxfrom=5";
            cellViewModel.name = @"iOS培训圈子";
            cellViewModel.articleNum = @"1568";
            cellViewModel.peopleNum = @"586";
            cellViewModel.topicNum = @"5748";
            cellViewModel.content = @"自己交保险是不是只能交养老和医疗，费用是多少?";
            [tempArray addObject:cellViewModel];
        }
        self.dataArray = tempArray;
        
        [self.refreshEndSubject sendNext:@"加载更多成功"];
    }];
}

#pragma mark - Getters
- (RACCommand *)refreshCommand {
    if (!_refreshCommand) {
        // 处理刷新业务逻辑
        @weakify(self);
        _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                self.currentPage = 1;
                // 进行数据请求
                // 模仿网络延迟
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    NSDictionary *dict = [responseString objectFromJSONString];
//                    [subscriber sendNext:dict];
                    [subscriber sendNext:@{}];
                    [subscriber sendCompleted];
                });
                return nil;
            }];
        }];
    }
    return _refreshCommand;
}

- (RACCommand *)loadMoreCommand {
    if (!_loadMoreCommand) {
        @weakify(self);
        _loadMoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                self.currentPage += 1;
                // 模仿网络延迟
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [subscriber sendNext:@{}];
                    [subscriber sendCompleted];
                });
                return nil;
            }];
        }];
    }
    return _loadMoreCommand;
}

- (RACSubject *)refreshUISubject {
    if (!_refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

- (RACSubject *)refreshEndSubject {
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}

- (RACSubject *)cellSelectSubject {
    if (!_cellSelectSubject) {
        _cellSelectSubject = [RACSubject subject];
    }
    return _cellSelectSubject;
}

- (ListHeaderViewModel *)headerViewModel {
    if (!_headerViewModel) {
        _headerViewModel = [[ListHeaderViewModel alloc] init];
        _headerViewModel.cellSelectSubject = self.cellSelectSubject;
    }
    return _headerViewModel;
}
@end
