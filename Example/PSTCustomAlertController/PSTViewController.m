//
//  PSTViewController.m
//  PSTCustomAlertController
//
//  Created by zzzworm@gmail.com on 09/02/2018.
//  Copyright (c) 2018 zzzworm@gmail.com. All rights reserved.
//

#import "PSTViewController.h"
#import <PSTCustomAlertController/PSTAlertController.h>

@interface PSTViewController ()

@end

@implementation PSTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"alert use system UI";
            break;
        case 1:
            cell.textLabel.text = @"actionsheet use system UI";
            break;
        case 2:
            cell.textLabel.text = @"alert use custom UI";
            break;
        case 3:
            cell.textLabel.text = @"actionsheet use custom UI";
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            {
                PSTAlertController *controller = [PSTAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"No WIFI connection. Use Cellular data to download?", nil) preferredStyle:PSTAlertControllerStyleAlert];
                [controller addAction:[PSTAlertAction actionWithTitle:@"OK" style:PSTAlertActionStyleDestructive handler:nil]];
                // Cancel action on a sheet should be the last action.
                [controller addCancelActionWithHandler:nil];
                [controller showInController:self animated:YES completion:nil];
            }
            break;
        case 1:
        {
            PSTAlertController *controller = [PSTAlertController alertControllerWithTitle:NSLocalizedString(@"Choose connection:",nil) message:nil preferredStyle:PSTAlertControllerStyleActionSheet];
            [controller addAction:[PSTAlertAction actionWithTitle:@"Wifi" style:PSTAlertActionStyleDefault handler:nil]];
            [controller addAction:[PSTAlertAction actionWithTitle:@"3G/4G" style:PSTAlertActionStyleDefault handler:nil]];
            // Cancel action on a sheet should be the last action.
            [controller addCancelActionWithHandler:nil];
            [controller showInController:self animated:YES completion:nil];
        }
            break;
        case 2:
        {
            PSTAlertController *controller = [PSTAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"No WIFI connection. Use Cellular data to download?", nil) preferredStyle:PSTAlertControllerStyleCustomAlert];
            [controller addAction:[PSTAlertAction actionWithTitle:@"OK" style:PSTAlertActionStyleDestructive handler:nil]];
            // Cancel action on a sheet should be the last action.
            [controller addCancelActionWithHandler:nil];
            [controller showInController:self animated:YES completion:nil];
        }
            break;
        case 3:
        {
            PSTAlertController *controller = [PSTAlertController alertControllerWithTitle:NSLocalizedString(@"Choose connection:",nil) message:nil preferredStyle:PSTAlertControllerStyleCustomActionSheet ];
            [controller addAction:[PSTAlertAction actionWithTitle:@"Wifi" style:PSTAlertActionStyleDefault handler:nil]];
            [controller addAction:[PSTAlertAction actionWithTitle:@"3G/4G" style:PSTAlertActionStyleDefault handler:nil]];
            // Cancel action on a sheet should be the last action.
            [controller addCancelActionWithHandler:nil];
            [controller showInController:self animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
}
@end
