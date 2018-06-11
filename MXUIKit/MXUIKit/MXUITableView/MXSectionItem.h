//
//  MXSectionItem.h
//  MXUIKit
//
//  Created by sunny on 2018/6/8.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXSectionItem : NSObject

@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, assign) NSInteger sectionNumber;
@property (nonatomic, assign) BOOL isExpand;

+ (MXSectionItem *)sectionItem;

@end
