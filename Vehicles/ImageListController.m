//
//  ImageListController.m
//  Vehicles
//
//  Created by NSSimpleApps on 12.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "ImageListController.h"
#import "UICollectionView+RegisterCell.h"
#import "ImageCell.h"
#import "LocalizeManager.h"
#import "ImageLoader.h"

@interface ImageListController ()

@property (assign) NSInteger visibleItem;

@end

@implementation ImageListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"%@", self.imagePaths);
    
    [self.collectionView registerCellWithClass:[ImageCell class]];
        
    self.title = LocalizeManager.Images;
    
    UIBarButtonItem *dismissBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:LocalizeManager.Close
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(dismiss:)];
    
    self.navigationItem.rightBarButtonItem = dismissBarButtonItem;
}

- (void)dismiss:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.imagePaths.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageCell class])
                                                                forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return collectionView.bounds.size;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCell *imageCell = (ImageCell *)cell;
    imageCell.imageView.image = nil;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak ImageCell *wCell = (ImageCell *)cell;
    
    [[ImageLoader shared] loadImageWithPath:self.imagePaths[indexPath.item]
                                 completion:^(UIImage * _Nullable image) {
                                     
                                     __strong typeof(wCell) sCell = wCell;
                                     
                                     if (sCell) {
                                         
                                         sCell.imageView.image = image;
                                     }
                                 }];
}

- (IBAction)handleRightSwipe:(UISwipeGestureRecognizer *)sender {
    
    UICollectionView *collectionView = (UICollectionView *)sender.view;
    
    if (collectionView && (self.visibleItem > 0)) {
        
        self.visibleItem--;
        
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.visibleItem inSection:0]
                               atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                       animated:YES];
    }
}

- (IBAction)handleLeftSwipe:(UISwipeGestureRecognizer *)sender {
    
    UICollectionView *collectionView = (UICollectionView *)sender.view;
    
    if (collectionView && (self.visibleItem < self.imagePaths.count - 1)) {
        
        self.visibleItem++;
        
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.visibleItem inSection:0]
                               atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                       animated:YES];
    }
}

@end
