//
//  VehicleFactory.h
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Vehicle;

@interface VehicleFactory : NSObject

+ (nullable NSArray<__kindof Vehicle *> *)vehiclesWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                                                         baseURL:(NSURL *)baseURL;

@end

NS_ASSUME_NONNULL_END