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
- (instancetype)initWithViewModel:(id<ViewModelProtocol>)viewModel;

- (void)bindViewModel;
- (void)setupViews;
- (void)addReturnKeyboard;
@end
