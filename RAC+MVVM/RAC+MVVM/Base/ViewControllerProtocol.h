//
//  ViewControllerProtocol.h
//  RAC+MVVM
//
//  Created by bisheen on 2023/3/17.
//

#import <Foundation/Foundation.h>

@protocol ViewModelProtocol;
@protocol ViewControllerProtocol <NSObject>

@optional
 /// 使用 vm 配置初始化 vc
/// - Parameter viewModel: 遵循协议的 viewModel
- (instancetype)initWithViewModel:(id<ViewModelProtocol>)viewModel;

/// 设置导航栏
- (void)setupNavigation;

/// 添加控件
- (void)addSubviews;

/// 绑定viewModel
- (void)bindViewModel;

/// 获取数据
- (void)getNewData;
@end
