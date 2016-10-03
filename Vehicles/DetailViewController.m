//
//  DetailViewController.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "DetailViewController.h"
#import "Vehicle.h"
#import "ContainerViewCell.h"
#import "UITableView+RegisterCell.h"
#import "LocalizeManager.h"
#import "ImageListController.h"
#import "VehicleViewModel.h"
#import "PropertyInfo.h"

@interface DetailViewController () <UITextFieldDelegate>

@property (strong) VehicleViewModel *vehicleViewModel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerCellWithClass:[ContainerViewCell class]];
    
    self.vehicleViewModel = [[VehicleViewModel alloc] initWithVehicle:self.vehicle];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.titleView = self.vehicleViewModel.viewForVehicleModel;
    self.navigationItem.titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    return self.vehicleViewModel.propertiesInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PropertyInfo *info = self.vehicleViewModel.propertiesInfo[indexPath.row];
    
    ContainerViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ContainerViewCell class])
                                    forIndexPath:indexPath];
    cell.textLabel.text = info.key;
    cell.accessoryView = info.view;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
       
    if (self.vehicle.images.count > 0) {
        
        UIButton *button =
        [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        [button setTitle:LocalizeManager.Images forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showImages) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        return button;
        
    } else {
        
        return nil;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

- (void)showImages {
    
    [self performSegueWithIdentifier:@"ShowImagesSegue" sender:self.vehicle.images];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    self.vehicleViewModel.editing = editing;
    
    if (editing) {
        
        [self.navigationItem.titleView becomeFirstResponder];
        
    } else {
        
        [self.navigationItem.titleView resignFirstResponder];
        [self.tableView endEditing:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowImagesSegue"]) {
        
        UINavigationController *nc = segue.destinationViewController;
        
        ImageListController *imageListController = (ImageListController *)nc.topViewController;
        imageListController.imagePaths = sender;
    }
}

@end
