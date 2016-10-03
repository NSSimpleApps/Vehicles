//
//  UICollectionView+RegisterCell.m
//  Vehicles
//
//  Created by NSSimpleApps on 12.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "UICollectionView+RegisterCell.h"

@implementation UICollectionView (RegisterCell)

- (void)registerCellWithClass:(Class)cellClass {
    
    NSString *reuseIdentifier = NSStringFromClass(cellClass);
    
    UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
    
    [self registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
}

@end
