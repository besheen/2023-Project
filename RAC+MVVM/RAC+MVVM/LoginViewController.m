//
//  LoginViewController.m
//  RAC+MVVM
//
//  Created by bisheen on 2023/3/28.
//

#import "LoginViewController.h"
#import "LoginInputView.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) LoginInputView *mInputView;
@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) LoginViewModel *viewModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor systemGray6Color];
    self.navigationItem.title = @"登录";
    
    [self p_setupNavigationItem];
    [self p_setupSubviews];
    [self p_bindVideModel];
}

#pragma mark - Private method
- (void)p_setupNavigationItem {
    @weakify(self)
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"填充" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self)
        self.mInputView.phoneTextField.text = @"18120926088";
        self.mInputView.verifyTextField.text = @"5858";
        return [RACSignal empty];
    }];
}

- (void)p_setupSubviews {
    [self.view addSubview:self.avatarImageView];
    [self.view addSubview:self.mInputView];
    [self.view addSubview:self.loginButton];
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.equalTo(self.view).offset(164);
        make.centerX.equalTo(self.view);
    }];
    [_mInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(44.0f);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30 * 2, 50));
        make.top.equalTo(self.mInputView.mas_bottom).offset(44.0f);
        make.centerX.equalTo(self.view);
    }];
}

- (void)p_bindVideModel {
    @weakify(self)
    [RACObserve(self.viewModel, avatarUrlStr) subscribeNext:^(NSString *avatarUrlStr) {
        @strongify(self)
        // 设置头像
//        self.avatarImageView setImage:<#(UIImage * _Nullable)#>
    }];
    RAC(self.viewModel, mobilePhone) = [RACSignal merge:@[RACObserve(self.mInputView.phoneTextField, text), self.mInputView.phoneTextField.rac_textSignal]];
    RAC(self.viewModel, verifyCode) = [RACSignal merge:@[RACObserve(self.mInputView.verifyTextField, text), self.mInputView.verifyTextField.rac_textSignal]];
    
    RAC(self.loginButton, enabled) = self.viewModel.validLoginSignal;
    [[[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(__kindof UIControl * _Nullable x) {
        
    }] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.viewModel.loginCommand execute:nil];
    }];
    
    // 请求成功
    [self.viewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
            
    }];
    // 请求失败
    [self.viewModel.loginCommand.errors subscribeNext:^(NSError * _Nullable x) {
            
    }];
}

#pragma mark - Getters
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder_icon"]];
        _avatarImageView.layer.cornerRadius = 80 / 2.0f;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}

- (LoginInputView *)mInputView {
    if (!_mInputView) {
        _mInputView = [[LoginInputView alloc] init];
        _mInputView.backgroundColor = [UIColor whiteColor];
    }
    return _mInputView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor systemRedColor];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];
        [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = 3;
        _loginButton.layer.masksToBounds = YES;
    }
    return _loginButton;
}

- (LoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc] init];
    }
    return _viewModel;
}
@end
