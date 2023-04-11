//
//  ViewProtocol.h
//  RAC+MVVM
//
//  Created by bisheen on 2023/3/17.
//

#import <Foundation/Foundation.h>

@protocol ViewModelProtocol;

@protocol ViewProtocol <NSObject>

@optional
/// viewModel 配置 view（因为每个 view 都会有对应的 viewModel，这样也更易复用）
- (instancetype)initWithViewModel:(id<ViewModelProtocol>)viewModel;

- (void)setupViews;
- (void)bindViewModel;
- (void)addReturnKeyboard;
@end
