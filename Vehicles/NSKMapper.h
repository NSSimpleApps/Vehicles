//
//  NSKMapper.h
//  Vehicles
//
//  Created by NSSimpleApps on 03.10.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSDictionary<NSString *, id> NSKDictionary;

typedef void(^NSKNullRule)(id, NSNull *);
typedef void(^NSKBoolRule)(id, BOOL);
typedef void(^NSKNumberRule)(id, NSNumber *);
typedef void(^NSKStringRule)(id, NSString *);
typedef void(^NSKArrayRule)(id, NSArray *);
typedef void(^NSKDictionaryRule)(id, NSKDictionary *);

@interface NSKMapper : NSObject

- (void)objectForDictionary:(_Nullable id(^)(NSKDictionary *dictionary))object;

- (void)setNullRule:(NSKNullRule)nullRule forKey:(NSString *)key;

- (void)setBoolRule:(NSKBoolRule)boolRule forKey:(NSString *)key;

- (void)setNumberRule:(NSKNumberRule)numberRule forKey:(NSString *)key;

- (void)setStringRule:(NSKStringRule)stringRule forKey:(NSString *)key;

- (void)setArrayRule:(NSKArrayRule)arrayRule forKey:(NSString *)key;

- (void)setDictionaryRule:(NSKDictionaryRule)dictionaryRule forKey:(NSString *)key;



- (nullable id)buildObjectFromDictionary:(NSKDictionary *)dictionary error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
