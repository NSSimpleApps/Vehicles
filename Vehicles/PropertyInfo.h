//
//  PropertyInfo.h
//  Vehicles
//
//  Created by NSSimpleApps on 11.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface PropertyInfo : NSObject
    
- (instancetype)initWithKey:(NSString *)key view:(UIView *)view NS_DESIGNATED_INITIALIZER;

@property (copy, readonly) NSString *key;

@property (strong, readonly) UIView *view;

@end

NS_ASSUME_NONNULL_END
