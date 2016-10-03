//
//  Automobile.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "Automobile.h"
#import <UIKit/UITextField.h>
#import <UIKit/UISegmentedControl.h>
#import "LocalizeManager.h"


@implementation Automobile

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.handDrive = AutomobileHandDriveLeft;
        self.seatsCount = 0;
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
    
    return copy;
}

@end
