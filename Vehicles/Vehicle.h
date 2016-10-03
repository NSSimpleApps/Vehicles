//
//  Vehicle.h
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Vehicle : NSObject <NSCopying>

@property (copy) NSString *manufacturer;
@property (copy) NSString *model;
@property (copy) NSArray<NSString *> *images;
@property (assign) NSInteger horsePower;

- (instancetype)initWithManufacturer:(NSString *)manufacturer
                               model:(NSString *)model
                          horsePower:(NSInteger)horsePower
                              images:(NSArray<NSString *> *)images NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
