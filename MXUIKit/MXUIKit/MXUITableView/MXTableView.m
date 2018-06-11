//
//  MXTableView.m
//  MXUIKit
//
//  Created by sunny on 2018/6/8.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "MXTableView.h"
#import "MXSectionItem.h"
#import "MXRowItem.h"

#import "NSIndexPath+Additions.h"

typedef enum : NSUInteger {
    MXSectionActionNone,
    MXSectionActionAdd,
    MXSectionActionDlete
} MXSectionActionType;

@interface MXTableView ()<NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sectionsArray;
@property (nonatomic, strong) NSMutableArray *contentsArray;

@property (nonatomic, assign)NSInteger sectionsCount;

@end

@implementation MXTableView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.sectionsArray = [NSMutableArray array];
        self.contentsArray = [NSMutableArray array];
        
        self.delegate = self;
        self.dataSource = self;
        
        [self setTarget:self];
        [self setDoubleAction:@selector(doubleClickTableView:)];
    }
    return self;
}

#pragma mark - Public Methods
- (void)reloadAllData
{
    [self.contentsArray removeAllObjects];
    [self.sectionsArray removeAllObjects];
    
    self.sectionsCount = [self.mxDataSource numberOfSectionsInTableView:self];
    if (self.sectionsCount != -1)
    {
        for (NSInteger i =0; i < self.sectionsCount; i++)
        {
            // section setting
            MXSectionItem *sectionItem = [MXSectionItem sectionItem];
            sectionItem.rowNumber = self.contentsArray.count ? self.contentsArray.count : 0;
            sectionItem.sectionNumber = i;
            [self.sectionsArray addObject:sectionItem];
            // row setting
            NSInteger numberOfRowsInSection = [self.mxDataSource tableView:self numberOfRowsInSection:i];
            BOOL isExpand = [self.mxDataSource tableView:self isExpandInSection:i];
            sectionItem.isExpand = isExpand;
            [self.contentsArray addObject:sectionItem];
            if (isExpand)
            {
                for (NSInteger j =0; j < numberOfRowsInSection; j++)
                {
                    MXRowItem *rowItem = [MXRowItem rowItem];
                    rowItem.sectionItem = sectionItem;
                    rowItem.rowNumber = self.contentsArray.count ? self.contentsArray.count : 0;
                    rowItem.sectionNumber = i;
                    rowItem.rowNumberInSection = j;
                    [self.contentsArray addObject:rowItem];
                    
                }
            }
        }
    }
    
    [self reloadData];
}

- (void)reloadDataForSection:(NSInteger)section
{
    if (section >= self.sectionsArray.count)
        return;
    
    MXSectionItem *sectionItem = [self.sectionsArray objectAtIndex:section];
    if (sectionItem)
    {
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSet];
        [self.contentsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[MXRowItem class]])
            {
                [indexs addIndex:idx];
            }
        }];
        
        [self reloadDataForRowIndexes:indexs columnIndexes:[NSIndexSet indexSetWithIndex:0]];
    }
}

- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [self rowNumberForIndexPath:indexPath];
    if (row >0)
    {
        [self reloadDataForRowIndexes:[NSIndexSet indexSetWithIndex:row]  columnIndexes:[NSIndexSet indexSetWithIndex:0]];
    }
}

- (void)selectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSInteger row = [self rowNumberForIndexPath:indexPath];
    if (row >= 0)
    {
        [self selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
    }
}

- (NSIndexPath *)indexPathForAtPoint:(NSPoint)point
{
    NSInteger row = [self rowAtPoint:point];
    if (row != -1)
    {
        NSInteger section = [self sectionForRow:row];
        NSInteger relativeRow = [self rowNumberInSectionForRow:row];
        return [NSIndexPath indexPathForRow:relativeRow inSection:section];
    }
    
    return nil;
}

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(NSTableViewAnimationOptions)animation
{
    [indexPaths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = obj;
        if ([indexPath isKindOfClass:[NSIndexPath class]])
        {
            NSInteger row = [self rowNumberForIndexPath:indexPath];
            if (row >0)
            {
                MXRowItem *rowItem = [MXRowItem rowItem];
                rowItem.sectionItem = [self.sectionsArray objectAtIndex:indexPath.section];
                rowItem.sectionNumber = indexPath.section;
                rowItem.rowNumberInSection = indexPath.row;
                rowItem.rowNumber = row;
                [self.contentsArray insertObject:rowItem atIndex:row];
                
                [self insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:row]  withAnimation:animation];
                [self updateRowNumberInSection:indexPath.section];
            }
        }
        
    }];
}

- (void)deleteRowsAtIndexPath:(NSIndexPath*)location withNumber:(NSUInteger)length withRowAnimation:(NSTableViewAnimationOptions)animation;
{
    NSInteger row = [self rowNumberForIndexPath:location];
    if (row>=0)
    {
        [self.contentsArray removeObjectsInRange:NSMakeRange(row,length)];
        [self removeRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(row,length)] withAnimation:animation];
        [self updateRowNumberInSection:location.section];
    }
}

- (BOOL)isExpandForSection:(NSInteger)section
{
    if (section >= self.sectionsArray.count)
        return NO;
    MXSectionItem *sectionItem = [self.sectionsArray objectAtIndex:section];
    return sectionItem.isExpand;
}

- (void)expandSection:(NSInteger)section expand:(BOOL)expand
{
    if (section > self.sectionsArray.count)
        return;
    
    MXSectionItem *sectionItem = [self.sectionsArray objectAtIndex:section];
    NSInteger numberOfSection = [self.mxDataSource tableView:self numberOfRowsInSection:section];
    
    if (expand && !sectionItem.isExpand)
    {
        for (NSInteger i =0; i < numberOfSection; i++)
        {
            MXRowItem *rowItem = [MXRowItem rowItem];
            rowItem.sectionItem = sectionItem;
            rowItem.rowNumber = sectionItem.rowNumber+i+1;
            rowItem.rowNumberInSection = i;
            
            [self.contentsArray insertObject:rowItem atIndex:sectionItem.rowNumber+i+1];
        }
        [self updateRowNumberInSection:section];
        [self insertRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(sectionItem.rowNumber+1, numberOfSection)]  withAnimation:NSTableViewAnimationEffectNone];
        
        sectionItem.isExpand = YES;
    }
    else if(!expand && sectionItem.isExpand)
    {
        [self.contentsArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(sectionItem.rowNumber+1, numberOfSection)]];
        [self updateRowNumberInSection:section];
        [self removeRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(sectionItem.rowNumber+1, numberOfSection)] withAnimation:NSTableViewAnimationEffectNone];
        sectionItem.isExpand = NO;
    }
}

#pragma mark - Notification
- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSTableView *tableView = notification.object;
    NSInteger row = tableView.selectedRow;
    if (row > 0)
    {
        NSInteger section = [self sectionForRow:row];
        NSInteger relativeRow = [self rowNumberInSectionForRow:row];
        
        if (section >=0 && relativeRow>=0)
        {
            NSIndexPath *path = [NSIndexPath indexPathForRow:relativeRow inSection:section];
            
            if ([self.mxDelegate respondsToSelector:@selector(tableView:didSelectedAtPath:)])
            {
                [self.mxDelegate tableView:self didSelectedAtPath:path];
            }
        }
    }
}

#pragma mark - User Action
- (void)doubleClickTableView:(id)sender
{
    NSInteger row = [self clickedRow];
    
    NSInteger section = [self sectionForRow:row];
    NSInteger relativeRow = [self rowNumberInSectionForRow:row];
    if (section>= 0 && relativeRow>= 0)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:relativeRow inSection:section];
        if ([self.mxDelegate respondsToSelector:@selector(tableView:doubleClickAtPath:)])
        {
            [self.mxDelegate tableView:self doubleClickAtPath:path];
        }
    }

}

#pragma mark- NSTableView delegate and datasource methods
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.contentsArray.count;
}

- (BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row
{
    id item = [self.contentsArray objectAtIndex:row];
    return [item isKindOfClass:MXSectionItem.class];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    id item = [self.contentsArray objectAtIndex:row];
    NSInteger section = [self sectionForRow:row];
    
    if (section >= 0)
    {
        if ([item isKindOfClass:[MXSectionItem class]])
        {
            return [self.mxDelegate tableView:self heightForHeaderInSection:section];
        }
        else
        {
            NSInteger relativeRow = [self rowNumberInSectionForRow:row];
            return [self.mxDelegate tableView:self heightOfRow:relativeRow inSection:section];
        }
    }
    
    return 50.0f;
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row
{
    NSInteger section = [self sectionForRow:row];
    NSInteger index = [self rowNumberInSectionForRow:row];
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:section];
    
    id item = [self.contentsArray objectAtIndex:row];
    if ([item isKindOfClass:[MXSectionItem class]])
    {
        return NO;
    }
    
    BOOL shouldSelectRow = FALSE;
    if ([self.mxDelegate respondsToSelector:@selector(tableView:shouldSelectAtIndexPath:)])
    {
        shouldSelectRow = [self.mxDelegate tableView:self shouldSelectAtIndexPath:path];
        if (shouldSelectRow)
        {
            NSInteger selectedRowNumber = [tableView selectedRow];
            if (selectedRowNumber > 0)
            {
                NSTableRowView *rowView =[tableView rowViewAtRow:selectedRowNumber-1 makeIfNecessary:YES];
                [rowView setNeedsDisplay:YES];
            }
        }
        
        return shouldSelectRow;
    }
    
    return YES;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row
{
    id item = [self.contentsArray objectAtIndex:row];
    NSInteger section = [self sectionForRow:row];
    if (section >= 0)
    {
        if (![item isKindOfClass:[MXSectionItem class]])
        {
            NSInteger relativeRow = [self rowNumberInSectionForRow:row];
            return [self.mxDataSource tableView:self rowViewForRow:relativeRow inSection:section];
        }
    }
    
    return nil;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    id item = [self.contentsArray objectAtIndex:row];
    NSInteger section = [self sectionForRow:row];
    if (section >= 0)
    {
        if ([item isKindOfClass:[MXSectionItem class]])
        {
            return [self.mxDataSource tableView:self viewForSection:section];
        }
        else
        {
            NSInteger relativeRow = [self rowNumberInSectionForRow:row];
            return [self.mxDataSource tableView:self viewForRow:relativeRow inSection:section];
        }
    }
    
    return nil;
}

#pragma mark - Private Methods
- (NSInteger)sectionForRow:(NSInteger)row
{
    id item = [self.contentsArray objectAtIndex:row];
    NSInteger sectionNumber = -1;
    if ([item isKindOfClass:[MXSectionItem class]])
    {
        sectionNumber = [(MXSectionItem*)item sectionNumber];
    }
    else if ([item isKindOfClass:[MXRowItem class]])
    {
        sectionNumber = [(MXRowItem*)item sectionNumber];
    }
    
    return sectionNumber;
}

- (NSInteger)rowNumberInSectionForRow:(NSInteger)row
{
    id item = [self.contentsArray objectAtIndex:row];
    NSInteger rowNumber = -1;
    if ([item isKindOfClass:[MXRowItem class]])
    {
        rowNumber = [(MXRowItem*)item rowNumberInSection];
    }
    
    return rowNumber;
}

- (NSInteger)rowNumberForIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section >= self.sectionsArray.count)
        return -1;
    
    MXSectionItem *sectionItem = [self.sectionsArray objectAtIndex:section];
    
    return indexPath.row + sectionItem.rowNumber+1;
}

- (void)updateRowNumberInSection:(NSInteger)section
{
    MXSectionItem *sectionItem = nil;
    for (NSInteger i =0; i < self.contentsArray.count; i++)
    {
        id item = [self.contentsArray objectAtIndex:i];
        if ([item isKindOfClass:[MXSectionItem class]])
        {
            sectionItem = item;
            [(MXSectionItem*)item setRowNumber:i];
        }
        else if ([item isKindOfClass:[MXRowItem class]])
        {
            [(MXRowItem*)item setRowNumber:i];
            [(MXRowItem*)item setRowNumberInSection:i-sectionItem.rowNumber-1];
        }
    }
}

@end
