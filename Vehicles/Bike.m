//
//  Bike.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "Bike.h"
#import <UIKit/UISegmentedControl.h>
#import "LocalizeManager.h"

@implementation Bike

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.bikeType = BikeTypeSport;
    }
    
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    
    typeof(self) copy =
    [[[self class] allocWithZone:zone] initWithManufacturer:self.manufacturer
                                                      model:self.model horsePower:self.horsePower
                                                     images:self.images];
    copy.bikeType = self.bikeType;
    
    return copy;
}

@end
