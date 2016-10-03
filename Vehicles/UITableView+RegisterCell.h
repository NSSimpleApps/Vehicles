//
//  UITableView+RegisterCell.h
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (RegisterCell)

- (void)registerNibWithClass:(Class)cellClass;

- (void)registerCellWithClass:(Class)cellClass;

@end
