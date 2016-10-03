//
//  NetDataProvider.m
//  Vehicles
//
//  Created by NSSimpleApps on 13.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "NetDataProvider.h"
#import "LocalizeManager.h"

@implementation NetDataProvider

- (void)jsonWithURL:(NSURL *)URL
         completion:(void(^)(NSURL *baseURL, NSDictionary<NSString *, id> *json))completionBlock
              error:(nullable void(^)(NSError *error))errorBlock {
    
    NSURLSessionConfiguration *configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{@"Content-Type": @"application/json"};
    
    NSURLSession *URLSession = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *URLSessionDataTask =
    [URLSession dataTaskWithURL:URL
              completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                  
                  if ((error != nil) && (errorBlock != nil)) {
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                          
                          errorBlock(error);
                      });
                      
                  } else {
                      
                      NSError *jsonError = nil;
                      
                      NSDictionary<NSString *, id> *json =
                      [NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments error:&jsonError];
                      
                      if ((jsonError != nil) && (errorBlock != nil)) {
                          
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              errorBlock(jsonError);
                          });
                          
                      } else {
                          
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              completionBlock((response.URL).URLByDeletingLastPathComponent, json);
                          });
                      }
                  }
                  
              }];
    
    [URLSessionDataTask resume];
}

@end
