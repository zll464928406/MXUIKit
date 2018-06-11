//
//  MXSectionItem.m
//  MXUIKit
//
//  Created by sunny on 2018/6/8.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "MXSectionItem.h"

@implementation MXSectionItem

- (id)init
{
    self = [super init];
    if (self)
    {
        self.isExpand = YES;
    }
    return self;
}

+(MXSectionItem *)sectionItem
{
    return [[MXSectionItem alloc] init];
}

@end
