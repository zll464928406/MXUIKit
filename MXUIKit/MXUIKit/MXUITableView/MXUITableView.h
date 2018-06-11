//
//  MXUITableView.h
//  MXUIKit
//
//  Created by sunny on 2018/6/1.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class MXUITableView;

@protocol MXUITableViewDataSource <NSObject>

- (NSInteger)numberOfSectionsInTableView:(MXUITableView *)tableView;
- (NSInteger)tableView:(MXUITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSView *)tableView:(MXUITableView *)tableView viewForRow:(NSInteger)row inSection:(NSInteger)section;

@optional
- (BOOL)tableView:(MXUITableView *)tableView isExpandInSection:(NSInteger)section;
- (NSTableRowView *)tableView:(MXUITableView *)tableView rowViewForRow:(NSInteger)row inSection:(NSInteger)section;
- (NSView *)tableView:(MXUITableView *)tableView viewForSection:(NSInteger)section;

@end

@protocol MXUITableViewDelegate <NSObject>

@optional
- (CGFloat)tableView:(MXUITableView *)tableView heightOfRow:(NSInteger)row inSection:(NSInteger)section;
- (CGFloat)tableView:(MXUITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (void)tableView:(MXUITableView *)tableView didSelectedAtPath:(NSIndexPath *)path;
- (BOOL)tableView:(MXUITableView *)tableView shouldSelectAtIndexPath:(NSIndexPath*)indexPath;
- (void)tableView:(MXUITableView *)tableView doubleClickAtPath:(NSIndexPath *)path;

@end

@interface MXUITableView : NSView

@property(nonatomic,weak) id<MXUITableViewDataSource> dataSource;
@property(nonatomic,weak) id<MXUITableViewDelegate> delegate;

@property(nonatomic, strong) NSColor *rowSelectedColor;

- (void)reloadData;
- (void)reloadDataForSection:(NSInteger)section;
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(NSTableViewAnimationOptions)animation;
- (void)deleteRowsAtIndexPath:(NSIndexPath*)location withNumber:(NSUInteger)length withRowAnimation:(NSTableViewAnimationOptions)animation;
- (void)expandSection:(NSInteger)section expand:(BOOL)expand;
- (BOOL)isExpandForSection:(NSInteger)section;

@end
