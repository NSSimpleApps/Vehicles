//
//  VehicleViewModel.m
//  Vehicles
//
//  Created by NSSimpleApps on 11.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "VehicleViewModel.h"
#import "PropertyInfo.h"
#import "LocalizeManager.h"
#import "Vehicle.h"
#import "Automobile.h"
#import "Car.h"
#import "Truck.h"
#import "Bike.h"

@interface VehicleViewModel () <UITextFieldDelegate>

@property (strong, readwrite) NSArray<PropertyInfo *> *propertiesInfo;

@end

@implementation VehicleViewModel

- (instancetype)init {
    
    return [self initWithVehicle:nil];
}
    
- (instancetype)initWithVehicle:(Vehicle *)vehicle {
    
    self = [super init];
    
    if (self) {
        
        self.vehicle = vehicle;
    }
    
    return self;
}

- (void)setVehicle:(Vehicle *)vehicle {
    
    _vehicle = vehicle;
    
    if (vehicle == nil) {
        
        self.propertiesInfo = nil;
        
        return;
    }
    
    PropertyInfo *manufacturerInfo =
    [self manufacturerInfoWithText:vehicle.manufacturer];
    
    PropertyInfo *horsePowerInfo =
    [self horsePowerInfoWithValue:vehicle.horsePower];
    
    NSMutableArray<PropertyInfo *> *info = [NSMutableArray arrayWithObjects:manufacturerInfo, horsePowerInfo, nil];
    
    if ([vehicle isKindOfClass:[Automobile class]]) {
        
        Automobile *automobile = (Automobile *)vehicle;
        
        PropertyInfo *handDriveInfo =
        [self handDriveInfoWithValue:automobile.handDrive];
        
        PropertyInfo *seatsCountInfo =
        [self seatsCountInfoWithValue:automobile.seatsCount];
        
        [info addObject:handDriveInfo];
        [info addObject:seatsCountInfo];
        
    } else if ([vehicle isKindOfClass:[Car class]]) {
        
        Car *car = (Car *)vehicle;
        
        PropertyInfo *doorsInfo =
        [self doorsInfoWithValue:car.doors];
        
        [info addObject:doorsInfo];
        
    } else if ([vehicle isKindOfClass:[Truck class]]) {
        
        Truck *truck = (Truck *)vehicle;
        
        PropertyInfo *carryingCapacityInfo =
        [self carryingCapacityInfoWithValue:truck.carryingCapacityKg];
        
        [info addObject:carryingCapacityInfo];
        
    } else if ([vehicle isKindOfClass:[Bike class]]) {
        
        Bike *bike = (Bike *)vehicle;
        
        PropertyInfo *bikeTypeInfo =
        [self bikeTypeInfoWithValue:bike.bikeType];
        
        [info addObject:bikeTypeInfo];
    }
    
    self.propertiesInfo = [NSArray arrayWithArray:info];
}

- (UITextField *)viewForVehicleModel {
    
    UITextField *modelTextField =
    [self commonTextFieldWithText:self.vehicle.model
                      placeholder:LocalizeManager.Model];
    modelTextField.textAlignment = NSTextAlignmentCenter;
    [modelTextField addTarget:self
                       action:@selector(modelDidChange:)
             forControlEvents:UIControlEventEditingChanged];
    
    return modelTextField;
}

- (UITextField *)commonTextFieldWithText:(NSString *)text
                             placeholder:(NSString *)placeholder {
    
    UITextField *textField =
    [[UITextField alloc] initWithFrame:CGRectZero];
    textField.text = text;
    textField.placeholder = placeholder;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.delegate = self;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    return textField;
}

- (UISegmentedControl *)segmentedControlWithItems:(NSArray<NSString *> *)items {
    
    UISegmentedControl *sc =
    [[UISegmentedControl alloc] initWithFrame:CGRectZero];
    
    [items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [sc insertSegmentWithTitle:obj
                           atIndex:idx
                          animated:NO];
    }];
    
    return sc;
}

- (PropertyInfo *)manufacturerInfoWithText:(NSString *)text {
    
    UITextField *manufacturerTextField =
    [self commonTextFieldWithText:text
                      placeholder:LocalizeManager.Manufacturer];
    [manufacturerTextField addTarget:self
                              action:@selector(manufacturerDidChange:)
                    forControlEvents:UIControlEventEditingChanged];
    
    PropertyInfo *manufacturerInfo =
    [[PropertyInfo alloc] initWithKey:LocalizeManager.Manufacturer
                                 view:manufacturerTextField];
    
    return manufacturerInfo;
}

- (PropertyInfo *)horsePowerInfoWithValue:(NSInteger)value {
    
    UITextField *horsePowerTextField =
    [self commonTextFieldWithText:@(value).stringValue
                      placeholder:LocalizeManager.Model];
    horsePowerTextField.keyboardType = UIKeyboardTypeNumberPad;
    [horsePowerTextField addTarget:self
                            action:@selector(horsePowerDidChange:)
                  forControlEvents:UIControlEventEditingChanged];
    
    PropertyInfo *horsePowerInfo =
    [[PropertyInfo alloc] initWithKey:LocalizeManager.HorsePower
                                 view:horsePowerTextField];
    
    return horsePowerInfo;
}

- (PropertyInfo *)handDriveInfoWithValue:(AutomobileHandDrive)value {
    
    UISegmentedControl *sc =
    [self segmentedControlWithItems:@[LocalizeManager.Left, LocalizeManager.Right]];
    sc.selectedSegmentIndex = value;
    [sc addTarget:self
           action:@selector(handDriveDidChange:)
 forControlEvents:UIControlEventValueChanged];
    
    PropertyInfo *handDriveInfo =
    [[PropertyInfo alloc] initWithKey:LocalizeManager.HandDrive
                                 view:sc];
    
    return handDriveInfo;
}

- (PropertyInfo *)seatsCountInfoWithValue:(NSInteger)value {
    
    UITextField *seatsCountTextField =
    [self commonTextFieldWithText:@(value).stringValue
                      placeholder:LocalizeManager.SeatsCount];
    seatsCountTextField.keyboardType = UIKeyboardTypeNumberPad;
    [seatsCountTextField addTarget:self
                            action:@selector(seatsCountDidChange:)
                  forControlEvents:UIControlEventEditingChanged];
    
    PropertyInfo *horsePowerInfo =
    [[PropertyInfo alloc] initWithKey:LocalizeManager.SeatsCount
                                 view:seatsCountTextField];
    
    return horsePowerInfo;
}

- (PropertyInfo *)doorsInfoWithValue:(NSInteger)value {
    
    UITextField *doorsTextField =
    [self commonTextFieldWithText:@(value).stringValue
                      placeholder:LocalizeManager.Doors];
    doorsTextField.keyboardType = UIKeyboardTypeNumberPad;
    [doorsTextField addTarget:self
                       action:@selector(doorsDidChange:)
             forControlEvents:UIControlEventEditingChanged];
    
    PropertyInfo *doorsInfo =
    [[PropertyInfo alloc] initWithKey:LocalizeManager.Doors
                                 view:doorsTextField];
    
    return doorsInfo;
}

- (PropertyInfo *)carryingCapacityInfoWithValue:(NSInteger)value {
    
    UITextField *carryingCapacityTextField =
    [self commonTextFieldWithText:@(value).stringValue
                      placeholder:LocalizeManager.CarryingCapacityKg];
    carryingCapacityTextField.keyboardType = UIKeyboardTypeNumberPad;
    [carryingCapacityTextField addTarget:self
                                  action:@selector(carryingCapacityDidChange:)
                        forControlEvents:UIControlEventEditingChanged];
    
    PropertyInfo *carryingCapacityInfo =
    [[PropertyInfo alloc] initWithKey:LocalizeManager.CarryingCapacityKg
                                 view:carryingCapacityTextField];
    
    return carryingCapacityInfo;
}

- (PropertyInfo *)bikeTypeInfoWithValue:(BikeType)value {
    
    UISegmentedControl *sc =
    [self segmentedControlWithItems:@[LocalizeManager.Sport,
                                      LocalizeManager.Chopper,
                                      LocalizeManager.Moped]];
    sc.selectedSegmentIndex = value;
    [sc addTarget:self
           action:@selector(bikeTypeDidChange:)
 forControlEvents:UIControlEventValueChanged];
    
    PropertyInfo *bikeTypeInfo =
    [[PropertyInfo alloc] initWithKey:LocalizeManager.BikeType
                                 view:sc];
    
    return bikeTypeInfo;
}

- (void)manufacturerDidChange:(UITextField *)sender {
    
    self.vehicle.manufacturer = sender.text;
}

- (void)modelDidChange:(UITextField *)sender {
    
    self.vehicle.model = sender.text;
}

- (void)horsePowerDidChange:(UITextField *)sender {
    
    self.vehicle.horsePower = sender.text.integerValue;
}

- (void)handDriveDidChange:(UISegmentedControl *)sender {
    
    Automobile *automobile = (Automobile *)self.vehicle;
    automobile.handDrive = sender.selectedSegmentIndex;
}

- (void)seatsCountDidChange:(UITextField *)sender {
    
    Automobile *automobile = (Automobile *)self.vehicle;
    automobile.seatsCount = sender.text.integerValue;
}

- (void)doorsDidChange:(UITextField *)sender {
    
    Car *car = (Car *)self.vehicle;
    car.doors = sender.text.integerValue;
}

- (void)carryingCapacityDidChange:(UITextField *)sender {
    
    Truck *truck = (Truck *)self.vehicle;
    truck.carryingCapacityKg = sender.text.integerValue;
}

- (void)bikeTypeDidChange:(UISegmentedControl *)sender {
    
    Bike *bike = (Bike *)self.vehicle;
    bike.bikeType = sender.selectedSegmentIndex;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return self.editing;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
