//
//  FPViewController.m
//  Peregrine
//
//  Created by Rake Yang on 05/06/2019.
//  Copyright (c) 2019 BinaryParadise. All rights reserved.
//

#import "FPViewController.h"
#import <Peregrine/Peregrine.h>

@interface FPViewController ()

@property (nonatomic, copy) NSArray<PGRouterNode *> *data;

@end

@implementation FPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.data = [[PGRouterManager routerMap].allValues sortedArrayUsingComparator:^NSComparisonResult(PGRouterNode *  _Nonnull obj1, PGRouterNode * _Nonnull obj2) {
        return [obj1.name compare:obj2.name];
    }];
    [self.data enumerateObjectsUsingBlock:^(PGRouterNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.childs sortUsingComparator:^NSComparisonResult(PGRouterNode *  _Nonnull obj11,  PGRouterNode * _Nonnull obj22) {
            return [obj11.name compare:obj22.name];
        }];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data objectAtIndex:section].childs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xxx"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"xxx"];
    }
    PGRouterNode *node = [[self.data objectAtIndex:indexPath.section].childs objectAtIndex:indexPath.row];
    cell.textLabel.text = node.config.actionName;
    cell.detailTextLabel.text = [node.config.parameters[@"c"] stringByRemovingPercentEncoding];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.data objectAtIndex:section].name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PGRouterNode *node = [[self.data objectAtIndex:indexPath.section].childs objectAtIndex:indexPath.row];
    [PGRouterManager openURL:node.config.URL.absoluteString completion:^(BOOL ret, id object) {
        
    }];
}

@end
