//
//  ListHeaderViewModel.h
//  RAC+MVVM
//
//  Created by bisheen on 2023/4/7.
//

#import "BaseViewModel.h"

@interface ListHeaderViewModel : BaseViewModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, strong) RACSubject *refreshUISubject;
@property (nonatomic, strong) RACSubject *cellSelectSubject;
@end
