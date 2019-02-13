//
//  SFLightPopoverViewCell.h
//  SFLightPopoverView
//
//  Created by Fernando on 2019/1/25.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFLightPopoverViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFLightPopoverViewCell : UITableViewCell

@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIFont  *normalTitleFont;

@property (nonatomic, strong) UIColor *selectTitleColor;
@property (nonatomic, strong) UIFont  *selectTitleFont;

- (void)configCellData:(id<SFLightPopoverViewDataMoelProtocol>)data;

@end

NS_ASSUME_NONNULL_END
