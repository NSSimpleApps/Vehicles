//
//  PropertyInfo.m
//  Vehicles
//
//  Created by NSSimpleApps on 11.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "PropertyInfo.h"

@interface PropertyInfo ()

@property (copy, readwrite) NSString *key;

@property (strong, readwrite) UIView *view;

@end

@implementation PropertyInfo
    
- (instancetype)init {
    
    return [self initWithKey:@"" view:[[UIView alloc] initWithFrame:CGRectZero]];
}
    
- (instancetype)initWithKey:(NSString *)key view:(UIView *)view {
    
    self = [super init];
    
    if (self) {
        
        self.key = key;
        self.view = view;
    }
    
    return self;
}

@end
