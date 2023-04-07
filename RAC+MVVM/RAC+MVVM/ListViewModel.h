//
//  ListViewModel.h
//  RAC+MVVM
//
//  Created by bisheen on 2023/4/7.
//

#import "BaseViewModel.h"
#import "ListHeaderViewModel.h"

@interface ListViewModel : BaseViewModel

@property (nonatomic, strong) RACCommand *refreshCommand;
@property (nonatomic, strong) RACSubject *cellSelectSubject;

@property (nonatomic, strong) ListHeaderViewModel *headerViewModel;
@property (nonatomic, copy) NSArray *dataArray;
@end
