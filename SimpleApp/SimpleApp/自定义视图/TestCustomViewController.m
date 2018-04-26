//
//  TestCustomViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/10/31.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "TestCustomViewController.h"

#import "SelectImageItemView.h"
#import "SelectImageView.h"
#import "SHSingleOptionMenuHeaderView.h"
#import "SHSingleOptionMenuView.h"

@interface TestCustomViewController ()<SingleOptionMenuDelegate>

@property (nonatomic, strong) SHSingleOptionMenuHeaderView *optionMenu;
@property (nonatomic, strong) SHSingleOptionMenuView *menu;

@property (nonatomic, strong) UIView *expandView;

@end

@implementation TestCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addOptionMenuView];
    [self.view addSubview:self.expandView];
}

#pragma mark - touch event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

#pragma mark - select image view
- (void)addSelectImageView {
    SelectImageItemView *item = [SelectImageItemView loadFromNib];
    item.frame = CGRectMake(0, 80, 100, 100);
    item.backgroundImage = [UIImage imageNamed:@"circle"];
    [self.view addSubview:item];
}

#pragma mark - single option menu view

- (void)addOptionMenuView {
    self.menu = [[SHSingleOptionMenuView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 45)];
    _menu.menuHeaderSource = [self menuHeaderItemsSource];
    _menu.delegate = self;
    _menu.headerItemSpace = 10;
    _menu.headerItemHeight = 25;
    _menu.expandHeight = 500;
    [self.view addSubview:_menu];
}

#pragma mark - option menu header delegate

- (NSArray<SHSingleOptionMenuHeaderEntityModel *> *)menuHeaderItemsSource {
    NSMutableArray *entity = [NSMutableArray array];
    NSArray *titles = @[@"品牌", @"分类", @"尺码", @"闪电发货"];
    for (NSString *title in titles) {
        SHSingleOptionMenuHeaderEntityModel *header = [[SHSingleOptionMenuHeaderEntityModel alloc] init];
        header.title = title;
        header.icon = @"filter_img";
        header.selectedIcon = @"selectd_filter_img";
        header.iconIsLeft = ![titles.lastObject isEqualToString:title];
        
        [entity addObject:header];
    }
    
    return entity;
}

- (NSInteger)menu:(SHSingleOptionMenuView *)menu numberOfContentItemsCountForHeaderIndex:(NSInteger)index {
    if (index == 0) {
        return 17;
    }
    
    return 5;
}

- (CGSize)menu:(SHSingleOptionMenuView *)menu itemSizeForIndexPath:(SHOptionMenuIndexPath *)indexPath {
    if (indexPath.headerIndex == 0) {
        return CGSizeMake(375, 40);
    }
    
    return CGSizeMake(150, 40);
}

bool isSelected = NO;

- (UIView *)menu:(SHSingleOptionMenuView *)menu itemForIndexPath:(SHOptionMenuIndexPath *)indexPath reusableItem:(UIView *)item itemSup:(UIView *)sup {
    UILabel *actualItem = (UILabel *)item;
    if (!item) {
        actualItem = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 40)];
        actualItem.font = [UIFont systemFontOfSize:14];
        actualItem.textAlignment = NSTextAlignmentLeft;
    }
    
    actualItem.textColor = [UIColor orangeColor];
    NSArray *titles = @[@"品牌", @"分类", @"尺码", @"闪电发货"];
    actualItem.text = [NSString stringWithFormat:@"%@---%ld", titles[indexPath.headerIndex], indexPath.contentIndex];
    if (isSelected) {
        actualItem.textColor = [UIColor redColor];
        isSelected = NO;
    }
    
    return actualItem;
}

- (void)menu:(SHSingleOptionMenuView *)menu didSelectedContentItemForIndexPath:(SHOptionMenuIndexPath *)indexPath {
    NSLog(@"-----header:%ld content:%ld", indexPath.headerIndex, indexPath.contentIndex);
    
    SHSingleOptionMenuHeaderEntityModel *header = [[SHSingleOptionMenuHeaderEntityModel alloc] init];
    header.title = @"品牌---1";
    header.icon = @"filter_img";
    header.selectedIcon = @"selectd_filter_img";
    [menu reloadHeaderItemWithEntity:header index:indexPath.headerIndex];
    
    NSSet *set = [NSSet setWithObject:@(indexPath.contentIndex)];
    isSelected = YES;
    [menu reloadContentItemsAtIndexs:set];
}

- (void)willDisplayMenuHeaderItem:(UIButton *)btn index:(NSInteger)index {
    if (index ==0 ) {
        
    }
    else if (index == 3) {
        btn.backgroundColor = [UIColor hexStringToColor:@"F7F7F7"];
        return;
    }
}

- (SHSingleOptionMenuHeaderSelectedStyle)menuHeaderItemSelectedStyleWithIndex:(NSInteger)index {
    if (index == 3) {
        return SHSingleOptionMenuHeaderSelectedRedBorder;
    }
    
    if (index == 2 || index == 1) {
        return SHSingleOptionMenuHeaderSelectedExpand;
    }
    
    return SHSingleOptionMenuHeaderSelectedDefault;
}

@end
