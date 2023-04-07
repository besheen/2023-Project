//
//  ViewModelProtocol.h
//  RAC+MVVM
//
//  Created by bisheen on 2023/3/17.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, LoadDataType) {
    LoadDataTypeError,
};

@protocol ViewModelProtocol <NSObject>

@optional
- (instancetype)initWithModel:(id)model;
/// 初始化
- (void)mInitialize;
@end
