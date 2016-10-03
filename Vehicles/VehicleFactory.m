//
//  VehicleFactory.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "VehicleFactory.h"
#import "Vehicle.h"
#import "Car.h"
#import "Truck.h"
#import "Bike.h"
#import "NSKMapper.h"

static NSString *const kType = @"type";

static NSString *const kManufacturer = @"manufacturer";
static NSString *const kModel = @"model";

static NSString *const kImages = @"images";
static NSString *const kHorsePower = @"horsePower";

static NSString *const kHandDrive = @"handDrive";
static NSString *const kSeatsCount = @"seatsCount";

static NSString *const kDoors = @"doors";

static NSString *const kCarryingCapacityKg = @"carryingCapacityKg";

static NSString *const kBikeType = @"bikeType";

@implementation VehicleFactory

+ (NSKMapper *)mapper {
    
    NSSet<NSString *> *vehicleKeys =
    [NSSet setWithObjects:kType, kManufacturer, kModel,
     kHorsePower, kImages, nil];
    
    NSSet<NSString *> *automobileKeys =
    [vehicleKeys setByAddingObjectsFromArray:@[kHandDrive, kSeatsCount]];
    
    NSSet<NSString *> *carKeys =
    [automobileKeys setByAddingObject:kDoors];
    
    NSSet<NSString *> *truckKeys =
    [automobileKeys setByAddingObject:kCarryingCapacityKg];
    
    NSSet<NSString *> *bikeKeys =
    [vehicleKeys setByAddingObject:kBikeType];
    
    NSKMapper *mapper = [NSKMapper new];
    [mapper objectForDictionary:^id _Nullable(NSKDictionary * _Nonnull dictionary) {
        
        NSSet<NSString *> *keys = [NSSet setWithArray:dictionary.allKeys];
        
        if ([vehicleKeys isSubsetOfSet:keys]) {
            
            NSString *type = dictionary[kType];
            
            if ([keys isEqualToSet:bikeKeys] && [type isEqualToString:@"bike"]) {
                
                return [Bike new];
                
            } else if ([keys isEqualToSet:truckKeys] && [type isEqualToString:@"truck"]) {
                
                return [Truck new];
                
            } else if ([keys isEqualToSet:carKeys] && [type isEqualToString:@"car"]) {
                
                return [Car new];
            }
        }
        return nil;
    }];
    
    [mapper setStringRule:^(Vehicle  * _Nonnull vehicle, NSString * _Nonnull manufacturer) {
        
        vehicle.manufacturer = manufacturer;
        
    } forKey:kManufacturer];
    
    [mapper setStringRule:^(Vehicle  * _Nonnull vehicle, NSString * _Nonnull model) {
        
        vehicle.model = model;
        
    } forKey:kModel];
    
    [mapper setNumberRule:^(Vehicle  * _Nonnull vehicle, NSNumber * _Nonnull horsePower) {
        
        vehicle.horsePower = horsePower.integerValue;
        
    } forKey:kHorsePower];
    
    [mapper setArrayRule:^(Vehicle  * _Nonnull vehicle, NSArray * _Nonnull images) {
        
        vehicle.images = images;
        
    } forKey:kImages];
    
    [mapper setStringRule:^(Automobile  * _Nonnull automobile, NSString * _Nonnull handDrive) {
        
        if ([handDrive isEqualToString:@"left"]) {
            
            automobile.handDrive = AutomobileHandDriveLeft;
            
        } else if ([handDrive isEqualToString:@"right"]) {
            
            automobile.handDrive = AutomobileHandDriveRight;
        }
        
    } forKey:kHandDrive];
    
    [mapper setNumberRule:^(Automobile  * _Nonnull automobile, NSNumber * _Nonnull seatsCount) {
        
        automobile.seatsCount = seatsCount.integerValue;
        
    } forKey:kSeatsCount];
    
    [mapper setNumberRule:^(Car  * _Nonnull car, NSNumber * _Nonnull doors) {
        
        car.doors = doors.integerValue;
        
    } forKey:kDoors];
    
    [mapper setNumberRule:^(Truck  * _Nonnull truck, NSNumber * _Nonnull carryingCapacityKg) {
        
        truck.carryingCapacityKg = carryingCapacityKg.integerValue;
        
    } forKey:kCarryingCapacityKg];
    
    [mapper setStringRule:^(Bike  * _Nonnull bike, NSString * _Nonnull bikeType) {
        
        if ([bikeType isEqualToString:@"scooter"]) {
            
            bike.bikeType = BikeTypeChopper;
            
        } else if ([bikeType isEqualToString:@"sport"]) {
            
            bike.bikeType = BikeTypeSport;
            
        } else if ([bikeType isEqualToString:@"chopper"]) {
            
            bike.bikeType = BikeTypeChopper;
        }
        
    } forKey:kBikeType];
    
    return mapper;
}

+ (nullable NSArray<__kindof Vehicle *> *)vehiclesWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                                                         baseURL:(NSURL *)baseURL {
    
    id value = dictionary[@"vehicles"];
    
    if (value && [value isKindOfClass:[NSArray class]]) {
        
        NSArray<NSDictionary *> *array = value;
        
        NSMutableArray<__kindof Vehicle *> *vehicles = [NSMutableArray arrayWithCapacity:array.count];
        
        NSKMapper *mapper = self.mapper;
        
        for (NSDictionary<NSString *, id> *d in array) {
            
            NSError *error;
            
            Vehicle *vehicle = [mapper buildObjectFromDictionary:d error:&error];
            
            if (vehicle) {
                
                NSMutableArray<NSString *> *images = [NSMutableArray arrayWithCapacity:vehicle.images.count];
                
                [vehicle.images enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    [images addObject:[baseURL.absoluteString stringByAppendingPathComponent:obj]];
                }];
                
                vehicle.images = images;
                
                [vehicles addObject:vehicle];
                
            } else {
                
                NSLog(@"error = %@ in dictionary = %@", error, d);
            }
        }
        
        return [NSArray arrayWithArray:vehicles];
        
    } else {
        
        NSLog(@"Dictionary does not contain any proper value with key: vehicles");
        
        return nil;
    }
}

@end
