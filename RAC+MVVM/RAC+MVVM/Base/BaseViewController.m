//
//  BaseViewController.m
//  RAC+MVVM
//
//  Created by bisheen on 2023/3/17.
//

#import "BaseViewController.h"

@import ReactiveObjC;

@interface BaseViewController ()

@end

@implementation BaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(viewController);
        [viewController addSubviews];
        [viewController bindViewModel];
        [viewController setupNavigation];
        [viewController getNewData];
    }];
    return viewController;
}

- (instancetype)initWithViewModel:(id<ViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setupNavigation {
    
}

- (void)addSubviews {
    
}

- (void)bindViewModel {
    
}

- (void)getNewData {
    
}
@end
