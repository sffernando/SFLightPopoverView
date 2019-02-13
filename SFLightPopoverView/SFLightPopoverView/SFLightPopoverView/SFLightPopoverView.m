//
//  SFLightPopoverView.m
//  SFLightPopoverView
//
//  Created by Fernando on 2019/1/25.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import "SFLightPopoverView.h"
#import "SFLightPopoverViewCell.h"

#import "UIView+YYAdd.h"

@interface SFLightPopoverView ()<UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *_triangleImageView;
    UIView      *_contentView;
    
    UITableView *_contentTableView;
    UILabel     *_titleLabel;
    
    NSArray     *_dataSource;
    
    CGFloat     popoverHeight;
}
@end

@implementation SFLightPopoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configDefaultValues];
        popoverHeight = 0.f;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(tapToismiss:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = self.bounds;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 2.f;
        _contentView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
        _contentView.layer.shadowOffset = CGSizeMake(0, 0);
        _contentView.layer.shadowOpacity = 1.f;
        _contentView.layer.shadowRadius = 3;
        _contentView.layer.masksToBounds = NO;
        [self addSubview:_contentView];
        
        _triangleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_menu_triangle_white"]];
        [_contentView addSubview:_triangleImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textColor = _actionTitleNormalColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_titleLabel];
        
        [self configTableView];
        
        self.hidden = YES;
    }
    return self;
}


- (void)configDefaultValues {
    
    _popoverWidth = 100.f;
    
    _popoverTitleHeight = 30.f;
    _popoverItemHeight = 35.f;
    
    _actionTitleNormalColor = [UIColor blackColor];
    _actionTitleNormalFont  = [UIFont systemFontOfSize:13];
    
    _actionTitleSelectedColor = [UIColor cyanColor];
    _actionTitleSelectedFont  = [UIFont systemFontOfSize:13];
    _popoverTitleColor = _actionTitleNormalColor;
    
    _maxRows = 4;
}

- (void)configTableView {
    _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _contentTableView.allowsMultipleSelection = NO;
    _contentTableView.scrollEnabled = NO;
    _contentTableView.showsVerticalScrollIndicator = NO;
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    [_contentTableView registerClass:[SFLightPopoverViewCell class] forCellReuseIdentifier:NSStringFromClass(SFLightPopoverViewCell.class)];
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentView addSubview:_contentTableView];
}

#pragma mark -- UITableViewDataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _popoverItemHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SFLightPopoverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SFLightPopoverViewCell class]) forIndexPath:indexPath];
    cell.selectTitleFont  = _actionTitleSelectedFont;
    cell.selectTitleColor = _actionTitleSelectedColor;
    cell.normalTitleFont  = _actionTitleNormalFont;
    cell.normalTitleColor = _actionTitleNormalColor;
    if (indexPath.row < _dataSource.count) {
        [cell configCellData:[_dataSource objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    if (_delegate && [_delegate respondsToSelector:@selector(popoverView:didSelectOption:)]) {
        if (indexPath.row < _dataSource.count) {
            [_delegate popoverView:self didSelectOption:[_dataSource objectAtIndex:indexPath.row]];
        }
    }
    [self dismisssAnimated:YES];
}


#pragma mark - public methods / interface

- (void)applyAppearanceChanges {
    [self reloadDataWithTitle:_popoverTitle options:_dataSource];
}

- (void)reloadDataWithTitle:(nullable NSString *)title
                    options:(NSArray <id<SFLightPopoverViewDataMoelProtocol>>*)options
{
    _popoverTitle = [title copy];
    _dataSource = options;
    
    _titleLabel.text = _popoverTitle;
    [_contentTableView reloadData];
    
    // all options height
    CGFloat optionsHeight = (_dataSource.count > _maxRows ? _maxRows : _dataSource.count) * _popoverItemHeight;
    _contentTableView.scrollEnabled = _dataSource.count > _maxRows;
    
    popoverHeight += optionsHeight;
    
    if (_popoverTitle) {
        popoverHeight += _popoverTitleHeight; // 标题高度
        _titleLabel.frame = CGRectMake(5, 0, _popoverWidth - 10, _popoverTitleHeight);
    } else {
        _titleLabel.frame = CGRectZero;
    }
    
    popoverHeight += 5.f;
    
    _contentView.alpha = 0.f;
    _contentView.frame = CGRectMake(0, 0, _popoverWidth, popoverHeight);
    _contentTableView.frame = CGRectMake(0, _titleLabel.bottom, _contentView.width, optionsHeight);
}

- (void)showAtAroundRect:(CGRect)aroundRect animated:(BOOL)animated {
    if (!self.superview) return;
    if (self.superview.width < _contentView.width || self.superview.height < popoverHeight) return;
    
    CGPoint showRectCenter = CGPointMake(CGRectGetMidX(aroundRect), CGRectGetMidY(aroundRect));
    
    if (showRectCenter.x < self.width / 2.f && showRectCenter.y <= self.height / 2.f) {
        // left top （the second quadrant）
        CGFloat _contentLeft = showRectCenter.x - _contentView.width / 2.f;
        if (_contentLeft < 15.f) {
            _contentLeft = 15.f;
        }
        _triangleImageView.frame = CGRectMake((_contentView.width - 9)/2.f - fabsf(showRectCenter.x - _contentView.width / 2.f - _contentLeft), -5.f, 9.f, 5.F);
        _contentView.layer.anchorPoint = CGPointMake(CGRectGetMidX(_triangleImageView.frame)/_contentView.width, 0);
        _contentView.frame = CGRectMake(_contentLeft, CGRectGetMaxY(aroundRect) + 5, _contentView.width, _contentView.height);
        _triangleImageView.image = [UIImage imageNamed:@"sources.bundle/icon_trangle_white_up"];
    } else if (showRectCenter.x >= self.width / 2.f && showRectCenter.y <= self.height / 2.f) {
        // right top （the first quadrant）
        CGFloat _contentLeft = showRectCenter.x - _contentView.width / 2.f;
        if (_contentLeft > self.width - 15.f - _contentView.width) {
            _contentLeft = self.width - 15.f - _contentView.width;
        }
        _triangleImageView.frame = CGRectMake((_contentView.width - 9)/2.f + fabsf(showRectCenter.x - _contentView.width / 2.f - _contentLeft), -5.f, 9.f, 5.F);
        _contentView.layer.anchorPoint = CGPointMake(CGRectGetMidX(_triangleImageView.frame)/_contentView.width, 0);
        _contentView.frame = CGRectMake(_contentLeft, CGRectGetMaxY(aroundRect) + 5, _contentView.width, _contentView.height);
        _triangleImageView.image = [UIImage imageNamed:@"sources.bundle/icon_trangle_white_up"];
    } else if (showRectCenter.x < self.width / 2.f && showRectCenter.y > self.height / 2.f) {
        // left down （the third quadrant）
        CGFloat _contentLeft = showRectCenter.x - _contentView.width / 2.f;
        if (_contentLeft < 15.f) {
            _contentLeft = 15.f;
        }
        _triangleImageView.frame = CGRectMake((_contentView.width - 9)/2.f - fabsf(showRectCenter.x - _contentView.width / 2.f - _contentLeft), _contentView.height, 9.f, 5.f);
        _contentView.layer.anchorPoint = CGPointMake(CGRectGetMidX(_triangleImageView.frame)/_contentView.width, 1);
        _contentView.frame = CGRectMake(_contentLeft, CGRectGetMinY(aroundRect) - popoverHeight, _contentView.width, _contentView.height);
        _triangleImageView.image = [UIImage imageNamed:@"sources.bundle/icon_trangle_white_down"];
    } else if (showRectCenter.x >= self.width / 2.f && showRectCenter.y > self.height / 2.f) {
        // right down（the fourth quadrant）
        CGFloat _contentLeft = showRectCenter.x - _contentView.width / 2.f;
        if (_contentLeft > self.width - 15.f - _contentView.width) {
            _contentLeft = self.width - 15.f - _contentView.width;
        }
        _triangleImageView.frame = CGRectMake((_contentView.width - 9)/2.f + fabsf(showRectCenter.x - _contentView.width / 2.f - _contentLeft), _contentView.height, 5.f, 5.f);
        _contentView.layer.anchorPoint = CGPointMake(CGRectGetMidX(_triangleImageView.frame)/_contentView.width, 1);
        _contentView.frame = CGRectMake(_contentLeft, CGRectGetMinY(aroundRect) - popoverHeight, _contentView.width, _contentView.height);
        _triangleImageView.image = [UIImage imageNamed:@"sources.bundle/icon_trangle_white_down"];
    }
    
    self.hidden = NO;
    _contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5f, 0.5f);
    
    dispatch_block_t block = ^(void){
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1.f;
    };
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            block();
        } completion:NULL];
    } else {
        block();
    }
    
}

- (void)dismisssAnimated:(BOOL)animated {
    dispatch_block_t block = ^(void){
        _contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5f, 0.5f);
        _contentView.alpha = 0.f;
    };
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            block();
        } completion:^(BOOL finished) {
            _contentView.transform = CGAffineTransformIdentity;
            self.hidden = YES;
            
            if (_delegate && [_delegate respondsToSelector:@selector(menuViewDidDismiss:)]) {
                [_delegate popoverViewDidDismiss:self];
            }
        }];
    } else {
        block();
        self.hidden = YES;
        if (_delegate && [_delegate respondsToSelector:@selector(popoverViewDidDismiss:)]) {
            [_delegate popoverViewDidDismiss:self];
        }
    }
}

- (void)tapToismiss:(UIButton *)sender {
    [self dismisssAnimated:YES];
}

- (void)deselectTheItem {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = _contentTableView.indexPathForSelectedRow;
        if ([_contentTableView cellForRowAtIndexPath:indexPath]) {
            [_contentTableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    });
    
}

- (void)selectTheItem:(id<SFLightPopoverViewDataMoelProtocol>)item {
    if ([_dataSource containsObject:item]) {
        NSUInteger index = [_dataSource indexOfObject:item];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_contentTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        });
    }
}


@end
