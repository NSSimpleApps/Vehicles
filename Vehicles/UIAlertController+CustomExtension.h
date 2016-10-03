//
//  UIAlertController+CustomExtension.h
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (CustomExtension)

+ (instancetype)alertControllerWithMessage:(nullable NSString *)message
                               cancelTitle:(NSString *)cancelTitle
                               cancelBlock:(void(^__nullable)(void))cancelBlock;


+ (instancetype)alertControllerWithMessage:(nullable NSString *)message
                              confirmTitle:(NSString *)confirmTitle
                              confirmBlock:(void(^__nullable)(void))confirmBlock;


@end

NS_ASSUME_NONNULL_END
