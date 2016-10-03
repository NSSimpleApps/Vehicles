//
//  AbstractDataProvider.h
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AbstractDataProvider : NSObject

- (void)jsonWithURL:(NSURL *)URL
              completion:(void(^)(NSURL *baseURL, NSDictionary<NSString *, id> *json))completionBlock
                   error:(nullable void(^)(NSError *error))errorBlock;

@end

NS_ASSUME_NONNULL_END