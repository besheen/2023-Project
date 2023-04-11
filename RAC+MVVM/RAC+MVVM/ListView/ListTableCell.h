//
//  ListTableCell.h
//  RAC+MVVM
//
//  Created by bisheen on 2023/4/7.
//

#import <UIKit/UIKit.h>

@class ListCellViewModel;
@interface ListTableCell : UITableViewCell

- (void)configCellWithViewModel:(ListCellViewModel *)viewModel;
@end
