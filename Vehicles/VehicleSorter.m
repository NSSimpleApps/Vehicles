//
//  VehicleSorter.m
//  Vehicles
//
//  Created by NSSimpleApps on 13.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "VehicleSorter.h"
#import "VehicleContainer.h"
#import "LocalizeManager.h"
#import "Car.h"
#import "Truck.h"
#import "Bike.h"

@implementation VehicleSorter

+ (NSMutableArray<VehicleContainer *> *)containersWithVehicles:(NSArray<Vehicle *> *)vehicles {
    
    NSMutableArray<VehicleContainer *> *containers =
    [NSMutableArray array];
    
    NSArray<NSString *> *classes =
    [vehicles valueForKeyPath:@"@distinctUnionOfObjects.class.description"];
    
    for (NSString *cl in classes) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self isKindOfClass: %@", NSClassFromString(cl)];
        
        VehicleContainer *vehicleContainer = [VehicleContainer new];
        vehicleContainer.vehicleClass = cl;
        vehicleContainer.vehicles =
        [NSMutableArray arrayWithArray:[vehicles filteredArrayUsingPredicate:predicate]];
        
        if ([cl isEqualToString:NSStringFromClass([Car class])]) {
            
            vehicleContainer.title = LocalizeManager.Cars;
            
        } else if ([cl isEqualToString:NSStringFromClass([Truck class])]) {
            
            vehicleContainer.title = LocalizeManager.Trucks;
            
        } else if ([cl isEqualToString:NSStringFromClass([Bike class])]) {
            
            vehicleContainer.title = LocalizeManager.Bikes;
        }
        
        [containers addObject:vehicleContainer];
    }
    
    [containers sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]];
    
    return containers;
}

@end
