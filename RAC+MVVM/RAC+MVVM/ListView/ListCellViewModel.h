//
//  ListCellViewModel.h
//  RAC+MVVM
//
//  Created by bisheen on 2023/4/7.
//

#import "BaseViewModel.h"

@interface ListCellViewModel : BaseViewModel

@property (nonatomic, copy) NSString *avatarStr;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *articleNum;
@property (nonatomic, copy) NSString *peopleNum;
@property (nonatomic, copy) NSString *topicNum;
@property (nonatomic, copy) NSString *content;
@end
