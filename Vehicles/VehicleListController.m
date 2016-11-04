//
//  VehicleListController.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "VehicleListController.h"
#import "LocalizeManager.h"
#import "LocalDataProvider.h"
#import "NetDataProvider.h"
#import "UIAlertController+CustomExtension.h"
#import "VehicleFactory.h"
#import "Vehicle.h"
#import "UITableView+RegisterCell.h"
#import "SimpleCell.h"
#import "DetailViewController.h"
#import "VehicleContainer.h"
#import "VehicleSorter.h"

@interface VehicleListController ()

@property (strong) NSMutableArray<VehicleContainer *> *containers;

@property (strong) AbstractDataProvider *dataProvider;

@property (strong) NSUndoManager *undoer;

@property (strong) NSURL *URL;

@end

@implementation VehicleListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.undoer = [NSUndoManager new];
    
    self.URL = [[NSBundle mainBundle] URLForResource:@"data.json" withExtension:nil];
    
    self.title = LocalizeManager.Vehicles;
    [self.tableView registerCellWithClass:[SimpleCell class]];
    
    self.containers = [NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dataProvider = [LocalDataProvider new];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Local", @"NET"]];
    segmentedControl.frame = CGRectMake(50, 50, 200, 30);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self
                         action:@selector(dataSourceTypeChanged:)
               forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *segmentedControlButtonItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[flexibleSpace, segmentedControlButtonItem, flexibleSpace];
    self.navigationController.toolbar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setToolbarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setToolbarHidden:YES animated:NO];
}

- (IBAction)reloadData:(UIBarButtonItem *)sender {
    
    sender.enabled = NO;
    
    __weak typeof(self) wSelf = self;
    
    [self.dataProvider jsonWithURL:self.URL
                        completion:^(NSURL * _Nonnull baseURL, NSDictionary<NSString *,id> * _Nonnull json) {
                            
                            sender.enabled = YES;
                            
                            NSArray<__kindof Vehicle *> *vehicles =
                            [VehicleFactory vehiclesWithDictionary:json baseURL:baseURL];
                                 
                            wSelf.containers =
                            [VehicleSorter containersWithVehicles:vehicles];
                                 
                            [wSelf.tableView reloadData];
                        }
                             error:^(NSError * _Nonnull error) {
                                 
                                 sender.enabled = YES;
                                 
                                 UIAlertController *alertController =
                                [UIAlertController alertControllerWithMessage:error.localizedDescription
                                                                        cancelTitle:LocalizeManager.Close
                                                                        cancelBlock:nil];
                                 
                                 [wSelf presentViewController:alertController
                                                     animated:YES
                                                   completion:nil];
                             }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.containers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.containers[section].vehicles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SimpleCell class])
                                                            forIndexPath:indexPath];
    cell.textLabel.text =
    self.containers[indexPath.section].vehicles[indexPath.row].model;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        
    return self.containers[section].title;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.tag = section;
    [button addTarget:self
               action:@selector(addNewVehicle:)
     forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"EditVehicleSegue"
                              sender:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        typeof(self) sSelf =
        [self.undoManager prepareWithInvocationTarget:self];
        [self.undoManager setActionName:@"Delete"];
        
        [sSelf undoRemoveRowAtIndexPath:indexPath
                                vehicle:self.containers[indexPath.section].vehicles[indexPath.row]];
        
        [self.containers[indexPath.section].vehicles removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }   
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    typeof(self) sSelf =
    [self.undoManager prepareWithInvocationTarget:self];
    [self.undoManager setActionName:@"Move"];
    
    [sSelf undoMoveRowFromIndexPath:fromIndexPath
                        toIndexPath:toIndexPath];
    
    VehicleContainer *vehicleContainer = self.containers[fromIndexPath.section];
    
    Vehicle *vehicle = vehicleContainer.vehicles[fromIndexPath.row];
    
    [vehicleContainer.vehicles removeObjectAtIndex:fromIndexPath.row];
    [vehicleContainer.vehicles insertObject:vehicle atIndex:toIndexPath.row];
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if (sourceIndexPath.section == proposedDestinationIndexPath.section) {
        
        return proposedDestinationIndexPath;
    }
    return sourceIndexPath;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DetailViewController *detailViewController = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"AddVehicleSegue"]) {
        
        detailViewController.vehicle = sender;
        
    } else if ([segue.identifier isEqualToString:@"EditVehicleSegue"]) {
        
        NSIndexPath *indexPath = sender;
        
        Vehicle *vehicle =
        self.containers[indexPath.section].vehicles[indexPath.row];
        
        detailViewController.vehicle = vehicle;
        
        typeof(self) sSelf =
        [self.undoManager prepareWithInvocationTarget:self];
        [self.undoManager setActionName:@"Edit"];
        
        Vehicle *originalVehicle = [vehicle copy];
        
        [sSelf undoEditVehicle:originalVehicle atIndexPath:indexPath];
    }
}

- (void)addNewVehicle:(UIButton *)sender {
    
    NSInteger section = sender.tag;
    
    NSString *vehicleClass = self.containers[section].vehicleClass;
    
    NSString *model =
    [NSString stringWithFormat:@"%@ %@", LocalizeManager.New, NSLocalizedString(vehicleClass, @"")];
    
    Vehicle *vehicle =
    [[NSClassFromString(vehicleClass) alloc] initWithManufacturer:@""
                                                            model:model
                                                       horsePower:0
                                                           images:@[]];
    
    [self.containers[section].vehicles addObject:vehicle];
    
    NSIndexPath *indexPath =
    [NSIndexPath indexPathForRow:self.containers[section].vehicles.count - 1
                       inSection:section];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self performSegueWithIdentifier:@"AddVehicleSegue"
                              sender:vehicle];
    
    typeof(self) sSelf =
    [self.undoManager prepareWithInvocationTarget:self];
    [self.undoManager setActionName:@"Add"];
    
    [sSelf undoAddVehicleAtIndexPath:indexPath];
}

- (void)dataSourceTypeChanged:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        
        self.dataProvider = [LocalDataProvider new];
        self.URL = [[NSBundle mainBundle] URLForResource:@"data.json" withExtension:nil];
        
    } else if (sender.selectedSegmentIndex == 1) {
        
        
        self.dataProvider = [NetDataProvider new];
        self.URL = [NSURL URLWithString:@"http://azcltd.com/testTask/iOS/list.json"];
    }
}


#pragma - mark Undo stuff

- (NSUndoManager *)undoManager {
    
    return self.undoer;
}

- (IBAction)undoAction:(UIBarButtonItem *)sender {
    
    [self.undoManager undo];
}

- (void)undoRemoveRowAtIndexPath:(NSIndexPath *)indexPath
                         vehicle:(Vehicle *)vehicle {
    
    [self.containers[indexPath.section].vehicles insertObject:vehicle
                                                      atIndex:indexPath.row];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
}

- (void)undoAddVehicleAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.containers[indexPath.section].vehicles removeObjectAtIndex:indexPath.row];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)undoMoveRowFromIndexPath:(NSIndexPath *)sourceIndexPath
                     toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    Vehicle *destinationVehicle = self.containers[destinationIndexPath.section].vehicles[destinationIndexPath.row];
    
    [self.containers[destinationIndexPath.section].vehicles
     removeObjectAtIndex:destinationIndexPath.row];
    
    [self.containers[sourceIndexPath.section].vehicles insertObject:destinationVehicle atIndex:sourceIndexPath.row];
    
    [self.tableView moveRowAtIndexPath:destinationIndexPath
                           toIndexPath:sourceIndexPath];
}

- (void)undoEditVehicle:(Vehicle *)originalVehicle
            atIndexPath:(NSIndexPath *)indexPath {
    
    (self.containers[indexPath.section].vehicles)[indexPath.row] = originalVehicle;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
