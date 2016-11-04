//
//  LeadInfoCell.h
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeadInfoCell : UITableViewCell

@property (strong, readonly) UILabel *label;

@property (nullable, strong, nonatomic) UIView *rightView;

@end

NS_ASSUME_NONNULL_END
