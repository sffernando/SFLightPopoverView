//
//  SFLightPopoverView.h
//  SFLightPopoverView
//
//  Created by Fernando on 2019/1/25.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFLightPopoverViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFLightPopoverView : UIView

@property (nonatomic, weak) id<SFLightPopoverViewDelegate> delegate;

@property (nonatomic, copy, readonly) NSString *popoverTitle;

/**
 * popover title color
 * default is [UIColor grayColor]
 */
@property (nonatomic, nullable, strong) UIColor *popoverTitleColor;
/**
 * popover title font
 * default is [UIFont systemFontOfSize:10]
 */
@property (nonatomic, nullable, strong) UIFont  *popoverTitleFont;

/**
 * action title normal color
 * default is [UIColor blackColor]
 */
@property (nonatomic, nonnull, strong) UIColor *actionTitleNormalColor;
/**
 * action title normal font
 * default is [UIFont systemFontOfSize:10]
 */
@property (nonatomic, nonnull, strong) UIFont  *actionTitleNormalFont;


/**
 * action title selected color
 * default is #FF3570
 */
@property (nonatomic, nonnull, strong) UIColor *actionTitleSelectedColor;
/**
 * action title selected font
 * default is [UIFont systemFontOfSize:12]
 */
@property (nonatomic, nonnull, strong) UIFont *actionTitleSelectedFont;

/**
 * popover title height
 * if the value is not zero, but if the popoverTitle value is nil, popoverTitleHeight does not work
 */
@property (nonatomic, assign) CGFloat popoverTitleHeight;
/**
 * popover item height
 * default value is 35.f
 */
@property (nonatomic, assign) CGFloat popoverItemHeight;
/**
 * max item rows
 */
@property (nonatomic, assign) NSUInteger maxRows;

/** Config the popover view width
 * Default 100.f
 */
@property(nonatomic, assign) CGFloat popoverWidth;

/** datasource */
- (void)reloadDataWithTitle:(nullable NSString *)title
                    options:(NSArray <id<SFLightPopoverViewDataMoelProtocol>>*)options;

/** MANUAL call after the properties changed*/
- (void)applyAppearanceChanges;

/**
 * aroundRect : display rect must convert to be the absolute rect in SFLightPopoverView
 */
- (void)showAtAroundRect:(CGRect)aroundRect animated:(BOOL)animated;

/**
 * dismiss
 */
- (void)dismisssAnimated:(BOOL)animated;

/**
 * deselect the selected item
 */
- (void)deselectTheItem;

/**
 * select a specific item
 */
- (void)selectTheItem:(id<SFLightPopoverViewDataMoelProtocol>)item;

@end

NS_ASSUME_NONNULL_END
