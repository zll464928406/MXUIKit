//
//  MXSectionView.m
//  MXUIKit
//
//  Created by sunny on 2018/6/11.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "MXSectionView.h"
#import "Masonry.h"

@implementation MXSectionView

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
    self.titleField = [[NSTextField alloc] init];
    self.titleField.editable = NO;
    self.titleField.bordered = NO;
    self.titleField.backgroundColor = [NSColor clearColor];
    [self addSubview:self.titleField];
    [self.titleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.offset(0.0f);
        make.bottom.offset(-1.0f);
    }];
    
}

@end
