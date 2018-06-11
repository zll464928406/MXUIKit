//
//  MXRowItem.h
//  MXUIKit
//
//  Created by sunny on 2018/6/8.
//  Copyright © 2018年 moxtra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXSectionItem.h"

@interface MXRowItem : NSObject

@property (nonatomic, strong) MXSectionItem * sectionItem;
@property (nonatomic, assign) NSInteger rowNumber;
@property (nonatomic, assign) NSInteger sectionNumber;
@property (nonatomic, assign) NSInteger rowNumberInSection;

+ (MXRowItem *)rowItem;

@end
