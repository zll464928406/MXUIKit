//
//  NSIndexPath+Additions.h
//  MXUIKit
//
//  Created by sunny on 2018/6/8.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (Additions)

@property (nonatomic, readonly) NSInteger row;
@property (nonatomic, readonly) NSInteger section;

+ (instancetype )indexPathForRow:(NSInteger)row inSection:(NSInteger)section;

@end
