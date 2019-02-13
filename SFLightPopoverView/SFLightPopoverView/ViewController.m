//
//  ViewController.m
//  SFLightPopoverView
//
//  Created by Fernando on 2019/1/25.
//  Copyright © 2019 Fernando. All rights reserved.
//

#import "ViewController.h"

#import "SFLightPopoverView.h"

#import "SFTestModel.h"

@interface ViewController ()<SFLightPopoverViewDelegate>

@property (nonatomic, strong) SFLightPopoverView *leftTopPopover;
@property (nonatomic, strong) SFLightPopoverView *rightTopPopover;
@property (nonatomic, strong) SFLightPopoverView *centerUpPopover;
@property (nonatomic, strong) SFLightPopoverView *centerDownPopover;
@property (nonatomic, strong) SFLightPopoverView *leftBottomPopover;
@property (nonatomic, strong) SFLightPopoverView *rightBottomPopover;

@end

@implementation ViewController


- (SFLightPopoverView *)leftTopPopover {
    if (!_leftTopPopover) {
        _leftTopPopover = [[SFLightPopoverView alloc] initWithFrame:self.view.bounds];
        _leftTopPopover.delegate = self;
        [_leftTopPopover reloadDataWithTitle:@"Fruits" options:[self leftTopDataSource]];
        [self.view addSubview:_leftTopPopover];
    }
    return _leftTopPopover;
}


- (SFLightPopoverView *)rightTopPopover {
    if (!_rightTopPopover) {
        _rightTopPopover = [[SFLightPopoverView alloc] initWithFrame:self.view.bounds];
        _rightTopPopover.delegate = self;
        _rightTopPopover.actionTitleSelectedColor = [UIColor redColor];
        _rightTopPopover.actionTitleSelectedFont = [UIFont systemFontOfSize:15];
        _rightTopPopover.popoverItemHeight = 40.f;
        [_rightTopPopover reloadDataWithTitle:nil options:[self leftTopDataSource]];
        [_rightTopPopover selectTheItem:[self leftTopDataSource].firstObject];
        [self.view addSubview:_rightTopPopover];
    }
    return _rightTopPopover;
}

- (SFLightPopoverView *)centerUpPopover {
    if (!_centerUpPopover) {
        _centerUpPopover = [[SFLightPopoverView alloc] initWithFrame:self.view.bounds];
        _centerUpPopover.delegate = self;
        [_centerUpPopover reloadDataWithTitle:@"Fruits" options:[self leftTopDataSource]];
        [self.view addSubview:_centerUpPopover];
    }
    return _centerUpPopover;
}

- (SFLightPopoverView *)centerDownPopover {
    if (!_centerDownPopover) {
        _centerDownPopover = [[SFLightPopoverView alloc] initWithFrame:self.view.bounds];
        _centerDownPopover.delegate = self;
        [_centerDownPopover reloadDataWithTitle:@"Fruits" options:[self leftTopDataSource]];
        [self.view addSubview:_centerDownPopover];
    }
    return _centerDownPopover;
}

- (SFLightPopoverView *)leftBottomPopover {
    if (!_leftBottomPopover) {
        _leftBottomPopover = [[SFLightPopoverView alloc] initWithFrame:self.view.bounds];
        _leftBottomPopover.delegate = self;
        [_leftBottomPopover reloadDataWithTitle:@"Number" options:[self rightBottomDataSource]];
        [self.view addSubview:_leftBottomPopover];
    }
    return _leftBottomPopover;
}

- (SFLightPopoverView *)rightBottomPopover {
    if (!_rightBottomPopover) {
        _rightBottomPopover = [[SFLightPopoverView alloc] initWithFrame:self.view.bounds];
        _rightBottomPopover.delegate = self;
        _rightBottomPopover.popoverWidth = 120.f;
        _rightBottomPopover.actionTitleSelectedColor = [UIColor redColor];
        _rightBottomPopover.actionTitleSelectedFont = [UIFont systemFontOfSize:15];
        _rightBottomPopover.popoverItemHeight = 30.f;
        _rightBottomPopover.maxRows = 6;
        [_rightBottomPopover reloadDataWithTitle:@"Number" options:[self rightBottomDataSource]];
        [self.view addSubview:_rightBottomPopover];
    }
    return _rightBottomPopover;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)leftTopBtnAction:(id)sender {
    [self.leftTopPopover showAtAroundRect:self.leftTopBtn.frame animated:YES];
}

- (IBAction)rightTopBtnAction:(id)sender {
    [self.rightTopPopover showAtAroundRect:self.rightTopBtn.frame animated:YES];
}
- (IBAction)centerUpBtnAction:(id)sender {
    [self.centerUpPopover showAtAroundRect:self.centerTopBtn.frame animated:YES];
}
- (IBAction)centerDownBtnAction:(id)sender {
    [self.centerDownPopover showAtAroundRect:self.centerDownBtn.frame animated:YES];
}
- (IBAction)leftBottomBtnAction:(id)sender {
    [self.leftBottomPopover showAtAroundRect:self.leftBottomBtn.frame animated:YES];
}
- (IBAction)rightBottomBtnAction:(id)sender {
    [self.rightBottomPopover showAtAroundRect:self.rightBottomBtn.frame animated:YES];
}

- (NSArray *)leftTopDataSource {
    NSMutableArray *array = [NSMutableArray array];
    NSArray *titles = @[@"Apple",@"Orange",@"Banana",@"Lemon"];
    for (int i = 0; i < titles.count; i ++) {
        SFTestModel *model = [[SFTestModel alloc] init];
        model.actionTitle = titles[i];
        [array addObject:model];
    }
    return [array copy];
}

- (NSArray *)rightBottomDataSource {
    NSMutableArray *array = [NSMutableArray array];
    NSArray *titles = @[@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven"];
    for (int i = 0; i < titles.count; i ++) {
        SFTestModel *model = [[SFTestModel alloc] init];
        model.actionTitle = titles[i];
        [array addObject:model];
    }
    return [array copy];
}

#pragma mark - SFLightPopoverViewDelegate
- (void)popoverView:(SFLightPopoverView *)popoverView didSelectOption:(id<SFLightPopoverViewDataMoelProtocol>)optionItem {
    NSLog(@"%p---%@",popoverView,optionItem.actionTitle);
}

- (void)popoverViewDidDismiss:(SFLightPopoverView *)popoverView {
    NSLog(@"%p",popoverView);
}

@end
