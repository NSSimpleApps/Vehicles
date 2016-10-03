//
//  UIAlertController+CustomExtension.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "UIAlertController+CustomExtension.h"
#import "LocalizeManager.h"

@implementation UIAlertController (CustomExtension)

+ (instancetype)alertControllerWithMessage:(nullable NSString *)message
                               cancelTitle:(NSString *)cancelTitle
                               cancelBlock:(nullable void(^)(void))cancelBlock {
    
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (cancelBlock) {
            
            cancelBlock();
        }
    }];
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:nil
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    
    return alertController;
}

+ (instancetype)alertControllerWithMessage:(NSString *)message
                              confirmTitle:(NSString *)confirmTitle
                              confirmBlock:(void(^)(void))confirmBlock {

    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:LocalizeManager.Cancel style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:nil
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    
    if (confirmBlock) {
        
        UIAlertAction *confirmlAction =
        [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            confirmBlock();
        }];
        
        [alertController addAction:confirmlAction];
    }
    
    return alertController;
}


@end
