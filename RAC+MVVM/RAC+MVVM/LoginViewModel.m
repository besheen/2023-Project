//
//  LoginViewModel.m
//  RAC+MVVM
//
//  Created by bisheen on 2023/3/27.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()

@property (nonatomic, copy, readwrite) NSString *avatarUrlStr;
@property (nonatomic, strong, readwrite) RACSignal *validLoginSignal;
@property (nonatomic, strong, readwrite) RACCommand *loginCommand;
@end

@implementation LoginViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self);
        // 数据绑定
        RAC(self, avatarUrlStr) = [[RACObserve(self, mobilePhone) map:^id _Nullable(id  _Nullable value) {
            // 模拟从数据库获取用户头像
            return value;
        }] distinctUntilChanged];
        
        // 按钮有效性
        self.validLoginSignal = [[RACSignal combineLatest:@[RACObserve(self, mobilePhone), RACObserve(self, verifyCode)] reduce:^(NSString *mobilePhone, NSString *verifyCode) {
            return @(mobilePhone.length > 0 && verifyCode.length > 0);
        }] distinctUntilChanged];
        
        // 登录命令
        self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            // 这里可以写验证手机号或验证码的逻辑
            if (![self isvalidMobile:self.mobilePhone]) {
                return [RACSignal error:[NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:nil]];
            }
            @weakify(self);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                // 发起网络请求
                
                return nil;
            }];
        }];
    }
    return self;
}


- (BOOL)isvalidMobile:(NSString *)mobilePhone {
    return YES;
}
@end
