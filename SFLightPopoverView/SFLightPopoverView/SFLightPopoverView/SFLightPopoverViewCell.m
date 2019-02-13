//
//  SFLightPopoverViewCell.m
//  SFLightPopoverView
//
//  Created by Fernando on 2019/1/25.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import "SFLightPopoverViewCell.h"

@interface SFLightPopoverViewCell ()
{
    UILabel *actionTitleLabel;
}

@end

@implementation SFLightPopoverViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        actionTitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        actionTitleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:actionTitleLabel];
        [actionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self);
            make.left.mas_greaterThanOrEqualTo(5.f);
            make.right.mas_lessThanOrEqualTo(-5.f);
        }];
    }
    return self;
}

- (void)configCellData:(id<SFLightPopoverViewDataMoelProtocol>)data {
    if (![data conformsToProtocol:@protocol(SFLightPopoverViewDataMoelProtocol)]) {
        return;
    }

    if (![data respondsToSelector:@selector(actionTitle)]) {
        return;
    }

    actionTitleLabel.text = [data actionTitle];
    
    if (![data respondsToSelector:@selector(isSelected)]) {
        return;
    }
    [self changeTitleLabelStyleIfSelected:data.selected];
}

- (void)changeTitleLabelStyleIfSelected:(BOOL)selected {
    if (selected) {
        actionTitleLabel.textColor = _selectTitleColor;
        actionTitleLabel.font = _selectTitleFont;
    } else {
        actionTitleLabel.textColor = _normalTitleColor;
        actionTitleLabel.font = _normalTitleFont;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    [self changeTitleLabelStyleIfSelected:selected];
}

@end
