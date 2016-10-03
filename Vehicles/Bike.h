//
//  Bike.h
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "Vehicle.h"

typedef NS_ENUM(NSInteger, BikeType) {
    BikeTypeSport,
    BikeTypeChopper,
    BikeTypeMoped
};

@interface Bike : Vehicle

@property (assign) BikeType bikeType;

@end
