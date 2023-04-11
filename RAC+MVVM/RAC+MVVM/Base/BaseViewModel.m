//
//  BaseViewModel.m
//  RAC+MVVM
//
//  Created by bisheen on 2023/3/17.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel initialBind];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)initialBind {
    
}
@end
