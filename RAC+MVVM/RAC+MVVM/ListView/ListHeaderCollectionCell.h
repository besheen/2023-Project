//
//  ListHeaderCollectionCell.h
//  RAC+MVVM
//
//  Created by bisheen on 2023/4/11.
//

#import <UIKit/UIKit.h>
#import "ListCellViewModel.h"

@interface ListHeaderCollectionCell : UICollectionViewCell

- (void)configCellWithViewModel:(ListCellViewModel *)viewModel;
@end
