//
//  ViewController.m
//  MXUIKit
//
//  Created by sunny on 2018/6/1.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "ViewController.h"
#import "MXUITableView.h"
#import "MXSlideTopicCell.h"
#import "MXSectionView.h"
#import "Masonry.h"

@interface ViewController () <MXUITableViewDelegate, MXUITableViewDataSource>

@property (nonatomic, strong) MXUITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArray = @[@{@"type":@"NSTableView"},
                       @{@"type":@"NSPopUpButton"},
                       @{@"type":@"NSButton"}
                       ];
    
    self.tableView = [[MXUITableView alloc] initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView expandSection:0 expand:NO];
    [self.tableView expandSection:1 expand:NO];
}

#pragma mark - MXUITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(MXUITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(MXUITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(NSView *)tableView:(MXUITableView *)tableView viewForRow:(NSInteger)row inSection:(NSInteger)section
{
    MXSlideTopicCell *cell = [MXSlideTopicCell new];
    cell.titleField.stringValue = @"nihao";
    return cell;
}

-(NSView *)tableView:(MXUITableView *)tableView viewForSection:(NSInteger)section
{
    MXSectionView *sectionView= [MXSectionView new];
    sectionView.titleField.stringValue = [NSString stringWithFormat:@"---%ld---", section];
    return sectionView;
}


#pragma mark - MXUITableViewDelegate
- (CGFloat)tableView:(MXUITableView *)tableView heightOfRow:(NSInteger)row inSection:(NSInteger)section
{
    return 50.0f;
}

- (CGFloat)tableView:(MXUITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (void)tableView:(MXUITableView *)tableView didSelectedAtPath:(NSIndexPath *)path
{
//    NSLog(@"%ld ----%ld", path.section, path.item);
}

- (void)tableView:(MXUITableView *)tableView doubleClickAtPath:(NSIndexPath *)path
{
    NSLog(@"%ld ----%ld", path.section, path.item);
}


@end
