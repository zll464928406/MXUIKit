//
//  MXTableView.h
//  MXUIKit
//
//  Created by sunny on 2018/6/8.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class MXTableView;

@protocol MXTableViewDelegate <NSObject>

- (CGFloat)tableView:(MXTableView *)tableView heightOfRow:(NSInteger)row inSection:(NSInteger)section;
- (CGFloat)tableView:(MXTableView *)tableView heightForHeaderInSection:(NSInteger)section;

@optional
- (void)tableView:(MXTableView *)tableView didSelectedAtPath:(NSIndexPath *)path;
- (BOOL)tableView:(MXTableView *)tableView shouldSelectAtIndexPath:(NSIndexPath*)indexPath;
- (void)tableView:(MXTableView *)tableView doubleClickAtPath:(NSIndexPath *)path;

@end

@protocol MXTableViewDataSource <NSObject>

- (NSInteger)numberOfSectionsInTableView:(MXTableView *)tableView;
- (BOOL)tableView:(MXTableView *)tableView isExpandInSection:(NSInteger)section;
- (NSInteger)tableView:(MXTableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSView *)tableView:(MXTableView *)tableView viewForRow:(NSInteger)row inSection:(NSInteger)section;
- (NSTableRowView *)tableView:(MXTableView *)tableView rowViewForRow:(NSInteger)row inSection:(NSInteger)section;
- (NSView *)tableView:(MXTableView *)tableView viewForSection:(NSInteger)section;

@end

@interface MXTableView : NSTableView

@property (nonatomic, weak)id<MXTableViewDataSource> mxDataSource;
@property (nonatomic, weak)id<MXTableViewDelegate> mxDelegate;


- (void)reloadAllData;
- (void)reloadDataForSection:(NSInteger)section;
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(NSTableViewAnimationOptions)animation;
- (void)deleteRowsAtIndexPath:(NSIndexPath*)location withNumber:(NSUInteger)length withRowAnimation:(NSTableViewAnimationOptions)animation;
- (void)expandSection:(NSInteger)section expand:(BOOL)expand;
- (BOOL)isExpandForSection:(NSInteger)section;

@end
