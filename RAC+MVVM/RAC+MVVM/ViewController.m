//
//  ViewController.m
//  RAC+MVVM
//
//  Created by Wendell on 2023/2/8.
//

#import "ViewController.h"

@import ReactiveObjC;
@import Masonry;

@interface ViewController ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textField];
    [self.view addSubview:self.button];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view).offset(44);
        make.right.equalTo(self.view).offset(-44);
        make.height.mas_equalTo(64);
    }];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).offset(100);
        make.left.equalTo(self.view).offset(44);
        make.right.equalTo(self.view).offset(-44);
        make.height.mas_equalTo(54);
    }];
    
    RACSignal *validEmailSignal = [self.textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([value rangeOfString:@"@"].location != NSNotFound);
    }];
    RAC(self.button, enabled) = validEmailSignal;
    RAC(self.textField, textColor) = [validEmailSignal map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? [UIColor greenColor] : [UIColor redColor];
    }];
}

- (void)commitAction:(UIButton *)sender {
    NSLog(@"commit action");
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.layer.cornerRadius = 4;
        _textField.layer.borderWidth = 0.5;
        _textField.layer.borderColor = [UIColor blackColor].CGColor;
        _textField.placeholder = @"请输入正确邮箱";
    }
    return _textField;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.titleLabel.font = [UIFont systemFontOfSize:16];
        _button.backgroundColor = [UIColor grayColor];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [_button setTitle:@"提交" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
@end
