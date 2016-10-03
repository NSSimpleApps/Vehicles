//
//  Automobile.h
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "Vehicle.h"

typedef NS_ENUM(NSInteger, AutomobileHandDrive) {
    AutomobileHandDriveLeft,
    AutomobileHandDriveRight
};

@interface Automobile : Vehicle

@property (assign) AutomobileHandDrive handDrive;
@property (assign) NSInteger seatsCount;

@end
