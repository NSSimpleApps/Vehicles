//
//  UITableView+RegisterCell.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "UITableView+RegisterCell.h"

@implementation UITableView (RegisterCell)

- (void)registerNibWithClass:(Class)cellClass {
    
    NSString *reuseIdentifier = NSStringFromClass(cellClass);
    
    UINib *nib = [UINib nibWithNibName:reuseIdentifier bundle:nil];
    
    [self registerNib:nib forCellReuseIdentifier:reuseIdentifier];
}

- (void)registerCellWithClass:(Class)cellClass {
    
    NSString *reuseIdentifier = NSStringFromClass(cellClass);
    
    [self registerClass:cellClass forCellReuseIdentifier:reuseIdentifier];
}

@end
