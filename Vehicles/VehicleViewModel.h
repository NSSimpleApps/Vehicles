//
//  VehicleViewModel.h
//  Vehicles
//
//  Created by NSSimpleApps on 11.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Vehicle, PropertyInfo, UITextField;

@interface VehicleViewModel : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithVehicle:(Vehicle *)vehicle NS_DESIGNATED_INITIALIZER;

@property (assign) BOOL editing;

@property (strong, nonatomic) Vehicle *vehicle;

@property (strong, readonly) NSArray<PropertyInfo *> *propertiesInfo;

@property (NS_NONATOMIC_IOSONLY, readonly, strong) UITextField * _Nonnull viewForVehicleModel;

@end

NS_ASSUME_NONNULL_END
