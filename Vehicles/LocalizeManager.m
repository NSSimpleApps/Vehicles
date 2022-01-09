//
//  LocalizeManager.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "LocalizeManager.h"

@implementation LocalizeManager

+ (NSString *)localizedStringForSelector:(SEL)selector {
    NSString *key = NSStringFromSelector(selector);
    
    return NSLocalizedString(key, @"");
}

+ (NSString *)FunctionIsNotImplemented {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)FileNameIsWrong {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)ResourceIsUnavailable {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Cancel {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Close {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Vehicles {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Cars {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Trucks {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Bikes {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)New {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Images {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Left {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Right {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Sport {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Chopper {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Moped {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Manufacturer {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Model {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)HorsePower {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)HandDrive {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)SeatsCount {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)Doors {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)CarryingCapacityKg {
    return [self localizedStringForSelector:_cmd];
}

+ (NSString *)BikeType {
    return [self localizedStringForSelector:_cmd];
}

@end
