//
//  LoginViewModel.h
//  RAC+MVVM
//
//  Created by bisheen on 2023/3/27.
//

#import <Foundation/Foundation.h>

/// 实践 MVVM 的关键点在于，我们要能够分析清楚 viewModel 需要暴露给 view 的数据和命令
@interface LoginViewModel : NSObject

/// 手机号
@property (nonatomic, copy) NSString *mobilePhone;
/// 验证码
@property (nonatomic, copy) NSString *verifyCode;
/// 用户头像
@property (nonatomic, copy, readonly) NSString *avatarUrlStr;
/// 按钮能否点击
@property (nonatomic, strong, readonly) RACSignal *validLoginSignal;
/// 登录按钮点击执行的命令
@property (nonatomic, strong, readonly) RACCommand *loginCommand;
@end
