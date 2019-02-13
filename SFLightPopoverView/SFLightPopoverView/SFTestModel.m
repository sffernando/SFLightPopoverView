//
//  SFTestModel.m
//  SFLightPopoverView
//
//  Created by Fernando on 2019/1/29.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import "SFTestModel.h"

@implementation SFTestModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _actionTitle = @"";
    }
    return self;
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    
    if (![other isKindOfClass:[SFTestModel class]]) {
        return NO;
    }
    
    return [self.actionTitle isEqualToString:((SFTestModel *)other).actionTitle];
}

@end
