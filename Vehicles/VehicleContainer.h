//
//  VehicleContainer.h
//  Vehicles
//
//  Created by NSSimpleApps on 11.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Vehicle;

@interface VehicleContainer : NSObject

@property (copy) NSString *title;

@property (strong) NSMutableArray<Vehicle *> *vehicles;

@property (copy) NSString *vehicleClass;

@end

NS_ASSUME_NONNULL_END