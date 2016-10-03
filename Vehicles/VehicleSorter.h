//
//  VehicleSorter.h
//  Vehicles
//
//  Created by NSSimpleApps on 13.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VehicleContainer, Vehicle;

@interface VehicleSorter : NSObject

+ (NSMutableArray<VehicleContainer *> *)containersWithVehicles:(NSArray<Vehicle *> *)vehicles;

@end

NS_ASSUME_NONNULL_END