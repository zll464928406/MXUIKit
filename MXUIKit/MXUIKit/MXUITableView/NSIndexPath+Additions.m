//
//  NSIndexPath+Additions.m
//  MXUIKit
//
//  Created by sunny on 2018/6/8.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import "NSIndexPath+Additions.h"

@implementation NSIndexPath (Additions)

+ (instancetype )indexPathForRow:(NSInteger)row inSection:(NSInteger)section {
    NSUInteger indexPath[2] = { section , row };
    return [self indexPathWithIndexes:indexPath length:2];
}

- (NSInteger)section {
    return [self indexAtPosition:0];
}


- (NSInteger)row {
    return [self indexAtPosition:1];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:NSIndexPath.class]) {
        if (self.section == [(NSIndexPath *)object section] && self.row == [(NSIndexPath *)object row]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p; section = %ld; item = %ld>", self.class, self, self.section, self.row];
}

@end
