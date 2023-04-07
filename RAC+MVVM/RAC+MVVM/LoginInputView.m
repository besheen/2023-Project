//
//  LoginInputView.m
//  RAC+MVVM
//
//  Created by bisheen on 2023/4/3.
//

#import "LoginInputView.h"

@implementation LoginInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *phoneLabel = [self p_setupLabelWithTitle:@"手机号"];
        [self addSubview:phoneLabel];
        UILabel *verifyLabel = [self p_setupLabelWithTitle:@"验证码"];
        [self addSubview:verifyLabel];
        _phoneTextField = [self p_setupTextFieldWithPlaceholder:@"请输入手机号码"];
        [self addSubview:_phoneTextField];
        _verifyTextField = [self p_setupTextFieldWithPlaceholder:@"请输入验证码"];
        [self addSubview:_verifyTextField];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(20);
            make.height.mas_equalTo(50);
        }];
        [verifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneLabel);
            make.bottom.equalTo(self);
            make.height.equalTo(phoneLabel);
        }];
        [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(phoneLabel.mas_right).offset(20);
            make.right.equalTo(self).offset(-20);
            make.centerY.equalTo(phoneLabel);
            make.height.equalTo(phoneLabel);
        }];
        [_verifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.phoneTextField);
            make.height.equalTo(self.phoneTextField);
            make.centerY.equalTo(verifyLabel);
        }];
        // 抗拉伸
        [phoneLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_phoneTextField setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
//        // 抗压缩
//        phoneLabel setContentCompressionResistancePriority:<#(UILayoutPriority)#> forAxis:<#(UILayoutConstraintAxis)#>
        
        UIView *separateView = [[UIView alloc] init];
        separateView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        [self addSubview:separateView];
        [separateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20 * 2, 0.5));
        }];
    }
    return self;
}

#pragma mark - Private method
- (UILabel *)p_setupLabelWithTitle:(NSString *)title {
    UILabel *tempLabel = [[UILabel alloc] init];
    tempLabel.font = [UIFont systemFontOfSize:14];
    tempLabel.textColor = [UIColor blackColor];
    tempLabel.text = title;
    return tempLabel;
}

- (UITextField *)p_setupTextFieldWithPlaceholder:(NSString *)placeholder {
    UITextField *tempTextField = [[UITextField alloc] init];
    tempTextField.font = [UIFont systemFontOfSize:14];
    tempTextField.placeholder = placeholder;
    return tempTextField;
}
@end
