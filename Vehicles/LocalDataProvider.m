//
//  LocalDataProvider.m
//  Vehicles
//
//  Created by NSSimpleApps on 12.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "LocalDataProvider.h"
#import "LocalizeManager.h"

@implementation LocalDataProvider

- (void)jsonWithURL:(NSURL *)URL
         completion:(void(^)(NSURL *baseURL, NSDictionary<NSString *, id> *json))completionBlock
              error:(nullable void(^)(NSError *error))errorBlock {
    
    NSData *data = [NSData dataWithContentsOfURL:URL];
    
    if (data == nil) {
            
        if (errorBlock) {
            
            NSError *error =
            [NSError errorWithDomain:@"DOMAIN"
                                code:1
                            userInfo:@{NSLocalizedDescriptionKey: LocalizeManager.ResourceIsUnavailable}];
            errorBlock(error);
        }
        
    } else {
            
        NSError *error = nil;
        
        NSDictionary<NSString *, id> *json =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingMutableContainers error:&error];
            
        if (error != nil && errorBlock) {
                
            errorBlock(error);
                
        } else {
                
            completionBlock(URL.URLByDeletingLastPathComponent, json);
        }
    }
}

@end
