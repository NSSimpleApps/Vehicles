//
//  Car.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "Car.h"
#import <UIKit/UITextField.h>

@implementation Car

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.doors = 0;
    }
    
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    
    typeof(self) copy =
    [[[self class] allocWithZone:zone] initWithManufacturer:self.manufacturer
                                                      model:self.model horsePower:self.horsePower
                                                     images:self.images];
    
    copy.handDrive = self.handDrive;
    copy.seatsCount = self.seatsCount;
    copy.doors = self.doors;
    
    return copy;
}

@end
