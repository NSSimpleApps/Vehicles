//
//  VehicleContainer.m
//  Vehicles
//
//  Created by NSSimpleApps on 11.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "VehicleContainer.h"

@implementation VehicleContainer

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.title = @"";
        self.vehicles = [NSMutableArray array];
    }
    return self;
}

@end
