//
//  NSKMapper.m
//  Vehicles
//
//  Created by NSSimpleApps on 03.10.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "NSKMapper.h"

@interface NSKMapper()

@property (copy) id (^jsonObject)(NSDictionary<NSString *, id> *dictionary);

@property (strong) NSMutableDictionary<NSString *, NSKNullRule> *nullRules;
@property (strong) NSMutableDictionary<NSString *, NSKBoolRule> *boolRules;
@property (strong) NSMutableDictionary<NSString *, NSKNumberRule> *numberRules;
@property (strong) NSMutableDictionary<NSString *, NSKStringRule> *stringRules;
@property (strong) NSMutableDictionary<NSString *, NSKArrayRule> *arrayRules;
@property (strong) NSMutableDictionary<NSString *, NSKDictionaryRule> *dictionaryRules;

@end

@implementation NSKMapper

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.nullRules = [NSMutableDictionary dictionary];
        self.boolRules = [NSMutableDictionary dictionary];
        self.numberRules = [NSMutableDictionary dictionary];
        self.stringRules = [NSMutableDictionary dictionary];
        self.arrayRules = [NSMutableDictionary dictionary];
        self.dictionaryRules = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)objectForDictionary:(id  _Nullable (^)(NSKDictionary * _Nonnull))object {
    
    self.jsonObject = object;
}

- (void)setNullRule:(NSKNullRule)nullRule forKey:(NSString *)key {
    
    self.nullRules[key] = [nullRule copy];
}

- (void)setBoolRule:(NSKBoolRule)boolRule forKey:(NSString *)key {
    
    self.boolRules[key] = [boolRule copy];
}

- (void)setNumberRule:(NSKNumberRule)numberRule forKey:(NSString *)key {
    
    self.numberRules[key] = [numberRule copy];
}

- (void)setStringRule:(NSKStringRule)stringRule forKey:(NSString *)key {
    
    self.stringRules[key] = [stringRule copy];
}

- (void)setArrayRule:(NSKArrayRule)arrayRule forKey:(NSString *)key {
    
    self.arrayRules[key] = [arrayRule copy];
}

- (void)setDictionaryRule:(NSKDictionaryRule)dictionaryRule forKey:(NSString *)key {
    
    self.dictionaryRules[key] = [dictionaryRule copy];
}

- (nullable id)buildObjectFromDictionary:(NSKDictionary *)dictionary error:(NSError **)error {
    
    id object = self.jsonObject(dictionary);
    
    if (object) {
        
        [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
                
            if ([value isKindOfClass:[NSNull class]]) {
                
                NSKNullRule nullRule = self.nullRules[key];
                
                if (nullRule) {
                    
                    nullRule(object, value);
                }
                return;
                
            } else if ([value isKindOfClass:[@YES class]]) {
                
                NSKBoolRule boolRule = self.boolRules[key];
                
                if (boolRule) {
                    
                    boolRule(object, [value boolValue]);
                }
                return;
                
            } else if ([value isKindOfClass:[NSNumber class]]) {
                
                NSKNumberRule numberRule = self.numberRules[key];
                
                if (numberRule) {
                    
                    numberRule(object, value);
                }
                return;
                
            } else if ([value isKindOfClass:[NSString class]]) {
                
                NSKStringRule stringRule = self.stringRules[key];
                
                if (stringRule) {
                    
                    stringRule(object, value);
                }
                return;
                
            } else if ([value isKindOfClass:[NSArray class]]) {
                
                NSKArrayRule arrayRule = self.arrayRules[key];
                
                if (arrayRule) {
                    
                    arrayRule(object, value);
                }
                return;
                
            } else if ([value isKindOfClass:[NSDictionary class]]) {
                
                NSKDictionaryRule dictionaryRule = self.dictionaryRules[key];
                
                if (dictionaryRule) {
                    
                    dictionaryRule(object, value);
                }
                return;
            }
        }];
        
        return object;
        
    } else {
        
        if (error) {
            
            *error = [NSError errorWithDomain:@"DOMAIN"
                                         code:0
                                     userInfo:@{NSLocalizedDescriptionKey: @"Could not build object"}];
        }
        
        return nil;
    }
}

@end

