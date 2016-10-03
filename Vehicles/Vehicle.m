//
//  Vehicle.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "Vehicle.h"
#import <UIKit/UITextField.h>

@implementation Vehicle

- (instancetype)init {
        
    return [self initWithManufacturer:@""
                                model:@""
                           horsePower:0
                               images:@[]];
}
    
- (instancetype)initWithManufacturer:(NSString *)manufacturer
                               model:(NSString *)model
                          horsePower:(NSInteger)horsePower
                              images:(NSArray<NSString *> *)images {
    
    self = [super init];
    
    if (self) {
        
        self.manufacturer = manufacturer;
        self.model = model;
        self.horsePower = horsePower;
        self.images = images;
    }
    
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    
    typeof(self) copy = [[[self class] allocWithZone:zone] init];
    
    copy.manufacturer = self.manufacturer;
    copy.model = self.model;
    copy.horsePower = self.horsePower;
    copy.images = self.images;
    
    return copy;
}


@end
