//
//  ImageLoader.h
//  Vehicles
//
//  Created by NSSimpleApps on 15.08.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

@interface ImageLoader : NSObject

+ (ImageLoader*)shared;

- (void)loadImageWithPath:(NSString *)path
               completion:(void(^)(UIImage * _Nullable image))completion;

@end

NS_ASSUME_NONNULL_END
