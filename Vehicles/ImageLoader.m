//
//  ImageLoader.m
//  Vehicles
//
//  Created by NSSimpleApps on 15.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "ImageLoader.h"
#import <SDWebImage/SDWebImageManager.h>

@implementation ImageLoader

+ (ImageLoader*)shared {
    
    static ImageLoader *shared = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shared = [self new];
    });
    
    return shared;
}

- (void)loadImageWithPath:(NSString *)path
               completion:(void(^)(UIImage * _Nullable image))completion {
    if ([path hasPrefix:@"file"]) {
        NSURL *URL = [NSURL URLWithString:path];
        
        completion([UIImage imageWithContentsOfFile:URL.path]);
        
    } else if ([path hasPrefix:@"http"]) {
        NSURL *URL = [NSURL URLWithString:path];
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager loadImageWithURL:URL options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (finished) {
                completion(image);
            }
        }];
    }
}


@end
