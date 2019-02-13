//
//  SFLightPopoverViewHeader.h
//  SFLightPopoverView
//
//  Created by Fernando on 2019/1/25.
//  Copyright © 2019 Fernando. All rights reserved.
//

#ifndef SFLightPopoverViewHeader_h
#define SFLightPopoverViewHeader_h

#import "Masonry.h"

@protocol SFLightPopoverViewDataMoelProtocol <NSObject>

@property (nonatomic,   copy) NSString  *actionTitle;

@optional

@property (nonatomic, assign) NSInteger actionType;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic) id attachment;

@end

@class SFLightPopoverView;
@protocol SFLightPopoverViewDelegate <NSObject>

@optional
- (void)popoverViewDidDismiss:(SFLightPopoverView *)popoverView;

- (void)popoverView:(SFLightPopoverView *)popoverView didSelectOption:(id<SFLightPopoverViewDataMoelProtocol>)optionItem;

@end

#endif /* SFLightPopoverViewHeader_h */
