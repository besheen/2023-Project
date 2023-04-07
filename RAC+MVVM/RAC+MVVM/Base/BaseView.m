//
//  BaseView.m
//  RAC+MVVM
//
//  Created by bisheen on 2023/3/17.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<ViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}

- (void)setupViews {
    
}

- (void)bindViewModel {
    
}

- (void)addReturnKeyboard {
    // 设置点击空白回收键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        [[UIApplication sharedApplication].delegate.window endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}
@end
