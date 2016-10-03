//
//  AbstractDataProvider.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "AbstractDataProvider.h"
#import "LocalizeManager.h"

@implementation AbstractDataProvider

- (void)jsonWithURL:(NSURL *)URL
         completion:(void(^)(NSURL *baseURL, NSDictionary<NSString *, id> *json))completionBlock
              error:(nullable void(^)(NSError *error))errorBlock {
    
    if (errorBlock) {
        
        NSError *error =
        [NSError errorWithDomain:@"DOMAIN"
                            code:1
                        userInfo:@{NSLocalizedDescriptionKey: LocalizeManager.FunctionIsNotImplemented}];
        
        errorBlock(error);
    }
}

@end
