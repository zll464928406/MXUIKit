//
//  MXUITableView.m
//  MXUIKit
//
//  Created by sunny on 2018/6/1.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "MXUITableView.h"
#import "MXTableView.h"
#import "MXTableViewRowView.h"
#import "MXSlideTopicCell.h"
#import "Masonry.h"

@interface MXUITableView () <MXTableViewDataSource, MXTableViewDelegate>

@property(nonatomic, strong) NSScrollView *scrollView;
@property(nonatomic, strong) MXTableView *tableView;

@end

@implementation MXUITableView
- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor clearColor].CGColor;
    
    self.scrollView    = [[NSScrollView alloc] init];
    self.scrollView.hasVerticalScroller  = YES;
    self.scrollView.frame = self.bounds;
    self.scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0.0f);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    self.tableView.headerView = nil;
    self.tableView = [[MXTableView alloc] init];
    self.tableView.frame = self.scrollView.frame;
    self.tableView.headerView = nil;
    self.tableView.autoresizingMask = YES;
//    self.tableView.gridStyleMask = NSTableViewDashedHorizontalGridLineMask | NSTableViewSolidVerticalGridLineMask;
    self.tableView.mxDelegate = self;
    self.tableView.mxDataSource = self;
    self.scrollView.contentView.documentView = self.tableView;
    [self.tableView registerNib:nil forIdentifier:@"MXSlideTopicCell"];
    // 3.0.创建表列
    NSTableColumn *chatColumen = [[NSTableColumn alloc] initWithIdentifier:NSStringFromClass(NSTableColumn.class)];
    chatColumen.title = @"";
    chatColumen.headerCell.alignment = NSTextAlignmentCenter;
    chatColumen.minWidth =  self.tableView.frame.size.width;
    chatColumen.resizingMask = NSTableColumnUserResizingMask | NSTableColumnAutoresizingMask;
    [self.tableView addTableColumn:chatColumen];
    /*
     NSTableColumnNoResizing        不能改变宽度
     NSTableColumnAutoresizingMask  拉大拉小窗口时会自动布局
     NSTableColumnUserResizingMask  允许用户调整宽度
     */
    
    [self.tableView reloadAllData];
    
//    [self.tableView expandSection:0 expand:NO];
//    [self.tableView expandSection:1 expand:NO];
//    [self.tableView expandSection:2 expand:NO];
//    [self.tableView expandSection:4 expand:NO];
}

#pragma mark - Public Method
- (void)reloadData
{
    [self.tableView reloadAllData];
}

- (void)reloadDataForSection:(NSInteger)section
{
    [self.tableView reloadDataForSection:section];
}

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadRowAtIndexPath:indexPath];
}

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView selectRowAtIndexPath:indexPath];
}

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(NSTableViewAnimationOptions)animation
{
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)deleteRowsAtIndexPath:(NSIndexPath*)location withNumber:(NSUInteger)length withRowAnimation:(NSTableViewAnimationOptions)animation
{
    [self.tableView deleteRowsAtIndexPath:location withNumber:length withRowAnimation:animation];
}

- (void)expandSection:(NSInteger)section expand:(BOOL)expand
{
    [self.tableView expandSection:section expand:expand];
}

- (BOOL)isExpandForSection:(NSInteger)section
{
    return [self.tableView isExpandForSection:section];
}

- (__kindof NSView *)makeViewWithIdentifier:(NSUserInterfaceItemIdentifier)identifier owner:(id)owner
{
    return [self.tableView makeViewWithIdentifier:identifier owner:nil];
}

#pragma mark - MXTableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(MXTableView *)tableView
{
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)])
    {
        return [self.dataSource numberOfSectionsInTableView:self];
    }
    
    return 1;
}

- (BOOL)tableView:(MXTableView *)tableView isExpandInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(tableView:isExpandInSection:)])
    {
        return [self.dataSource tableView:self isExpandInSection:section];
    }
    
    return YES;
}

- (NSInteger)tableView:(MXTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)])
    {
        return [self.dataSource tableView:self numberOfRowsInSection:section];
    }
    
    return 1;
}

- (NSView *)tableView:(MXTableView *)tableView viewForRow:(NSInteger)row inSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(tableView:viewForRow:inSection:)])
    {
        return [self.dataSource tableView:self viewForRow:row inSection:section];
    }
    
    return nil;
}

- (NSTableRowView *)tableView:(MXTableView *)tableView rowViewForRow:(NSInteger)row inSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(tableView:rowViewForRow:inSection:)])
    {
        return [self.dataSource tableView:self rowViewForRow:row inSection:section];
    }
    
    NSString *identifier = NSStringFromClass(MXTableViewRowView.class);
    MXTableViewRowView *rowView = [tableView makeViewWithIdentifier:identifier owner:self];
    if (rowView == nil)
    {
        rowView = [[MXTableViewRowView alloc] init];
        rowView.selectedColor = self.rowSelectedColor;
        rowView.identifier = identifier;
    }
    
    return rowView;
}

- (NSView *)tableView:(MXTableView *)tableView viewForSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(tableView:viewForSection:)])
    {
        return [self.dataSource tableView:self viewForSection:section];
    }
    
    return nil;
}

#pragma mark - MXTableViewDelegate
- (CGFloat)tableView:(MXUITableView *)tableView heightOfRow:(NSInteger)row inSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightOfRow:inSection:)])
    {
        return [self.delegate tableView:self heightOfRow:row inSection:section];
    }
    
    return 50.0f;
}
- (CGFloat)tableView:(MXUITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
    {
        return [self.delegate tableView:self heightForHeaderInSection:section];
    }
    
    return 30.0f;
}

- (void)tableView:(MXUITableView *)tableView didSelectedAtPath:(NSIndexPath *)path
{
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectedAtPath:)])
    {
        [self.delegate tableView:self didSelectedAtPath:path];
    }
}
- (BOOL)tableView:(MXUITableView *)tableView shouldSelectAtIndexPath:(NSIndexPath*)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:shouldSelectAtIndexPath:)])
    {
        return [self.delegate tableView:self shouldSelectAtIndexPath:indexPath];
    }
    
    return YES;
}

- (void)tableView:(MXUITableView *)tableView doubleClickAtPath:(NSIndexPath *)path
{
    if ([self.delegate respondsToSelector:@selector(tableView:doubleClickAtPath:)])
    {
        [self.delegate tableView:self doubleClickAtPath:path];
    }
}


#pragma mark - Notifications


#pragma mark - Getter & Setter
-(NSColor *)rowSelectedColor
{
    return _rowSelectedColor ? _rowSelectedColor : [NSColor lightGrayColor];
}

-(void)setDelegate:(id<MXUITableViewDelegate>)delegate
{
    _delegate = delegate;
    if (self.dataSource)
    {
        [self reloadData];
    }
}

-(void)setDataSource:(id<MXUITableViewDataSource>)dataSource
{
    _dataSource = dataSource;
    if (self.delegate)
    {
        [self reloadData];
    }
}

@end
