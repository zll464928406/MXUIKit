//
//  ViewController.m
//  MXUIKit
//
//  Created by sunny on 2018/6/1.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "ViewController.h"
#import "MXUITableView.h"
#import "MXUISlider.h"
#import "MXSlideTopicCell.h"
#import "MXSectionView.h"
#import "LabelWindowController.h"
#import "NSSliderWindowController.h"
#import "Masonry.h"

@interface ViewController () <MXUITableViewDelegate, MXUITableViewDataSource>

@property (nonatomic, strong) MXUITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSWindowController *windowController;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArray = @[@{@"type":@"MXUILabel"},
                       @{@"type":@"MXUISlider"},
                       @{@"type":@"NSButton"}
                       ];
    
    self.tableView = [[MXUITableView alloc] initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    [self.tableView expandSection:0 expand:NO];
}

#pragma mark - MXUITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(MXUITableView *)tableView
{
    return 1;
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
    NSDictionary *dict = [self.dataArray objectAtIndex:path.item];
    NSString *type = [dict objectForKey:@"type"];
    if ([type isEqualToString:@"MXUILabel"])
    {
        LabelWindowController *windowController = [[LabelWindowController alloc] init];
        self.windowController = windowController;
        [self.windowController.window orderFront:nil];
    }
    else if ([type isEqualToString:@"MXUISlider"])
    {
        NSSliderWindowController *windowController = [[NSSliderWindowController alloc] init];
        self.windowController = windowController;
        [self.windowController.window orderFront:nil];
    }
}


@end
