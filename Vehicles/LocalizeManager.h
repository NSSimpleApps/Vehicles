//
//  LocalizeManager.h
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalizeManager : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (NSString *)FunctionIsNotImplemented;


+ (NSString *)FileNameIsWrong;
+ (NSString *)ResourceIsUnavailable;
+ (NSString *)Cancel;
+ (NSString *)Close;
+ (NSString *)Vehicles;

+ (NSString *)Cars;
+ (NSString *)Trucks;
+ (NSString *)Bikes;

+ (NSString *)New;

+ (NSString *)Images;


+ (NSString *)Left;
+ (NSString *)Right;

+ (NSString *)Sport;
+ (NSString *)Chopper;
+ (NSString *)Moped;

+ (NSString *)Manufacturer;
+ (NSString *)Model;
+ (NSString *)HorsePower;
+ (NSString *)HandDrive;
+ (NSString *)SeatsCount;
+ (NSString *)Doors;
+ (NSString *)CarryingCapacityKg;
+ (NSString *)BikeType;

@end

NS_ASSUME_NONNULL_END
