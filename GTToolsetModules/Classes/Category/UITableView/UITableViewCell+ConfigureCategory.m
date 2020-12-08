//
//  UITableViewCell+ConfigureCategory.m
//  GTWork
//
//  Created by yjh on 2020/8/27.
//  Copyright © 2020 apple. All rights reserved.
//
#import <objc/runtime.h>
#import "UITableViewCell+ConfigureCategory.h"
#import <GTToolsetModules/ConfigurationHeader.h>
#import <YYKit/YYKit.h>

#define WIDTH_ONE_PIXEL (1.0 / [UIScreen mainScreen].scale)
NSString * const separatorColorKey = @"tableViewCellSeparatorColor";

GTTableViewCellSeparatorMargin GTTableViewCellSeparatorMarginMake(CGFloat topLeftMargin, CGFloat topRightMargin, CGFloat leftMargin, CGFloat rightMargin, CGFloat bottomLeftMargin, CGFloat bottomRightMargin)
{
    return (GTTableViewCellSeparatorMargin){topLeftMargin, topRightMargin, leftMargin, rightMargin, bottomLeftMargin, bottomRightMargin};
}

@implementation UITableViewCell(ConfigureCategory)

- (UITableView *)superTableView
{
    UIView *view = self;
    while (![view isKindOfClass: [UITableView class]] && view != nil) {
        view = view.superview;
    }
    return (UITableView *)view;
}

- (BOOL)isFirstRowInSection
{
    return [self.superTableView indexPathForRowAtPoint: self.center].row == 0;
}

- (BOOL)isLastRowInSection
{
    UITableView *tableView = self.superTableView;
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint: self.center];
    NSInteger count = [tableView.dataSource tableView: tableView numberOfRowsInSection: indexPath.section];
    return indexPath.row == count - 1;
}

- (void)configureSeparatorAndHideFirstTopSeparator:(BOOL)hideFirstTopSeparator andHideLastBottomSeparator:(BOOL)hideLastBottomSeparator
{
    [self configureSeparatorWithLeftMargin: 14.0f andHideFirstTopSeparator: hideFirstTopSeparator andHideLastBottomSeparator: hideLastBottomSeparator];
}

- (void)configureSeparatorWithLeftMargin:(CGFloat)leftMargin andHideFirstTopSeparator:(BOOL)hideFirstTopSeparator andHideLastBottomSeparator:(BOOL)hideLastBottomSeparator
{
    [self configureSeparatorWithSeparatorMargin: GTTableViewCellSeparatorMarginMake(0, 0, leftMargin, 0, 0, 0) andHideFirstTopSeparator: hideFirstTopSeparator andHideLastBottomSeparator: hideLastBottomSeparator];
}

- (void)configureSeparatorWithSeparatorMargin:(GTTableViewCellSeparatorMargin)separatorMargin andHideFirstTopSeparator:(BOOL)hideFirstTopSeparator andHideLastBottomSeparator:(BOOL)hideLastBottomSeparator
{
    UIView *topLineView = [self.contentView viewWithTag: 1001];
    if (topLineView == nil) {
        topLineView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 0, 1.0 / [UIScreen mainScreen].scale)];
        topLineView.backgroundColor = self.customSeparatorColor ?: COLOR_GRAY_E0;
        topLineView.tag = 1001;
        topLineView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        [self.contentView addSubview: topLineView];
    }

    UIView *bottomLineView = [self.contentView viewWithTag: 1002];
    if (bottomLineView == nil) {
        bottomLineView = [[UIView alloc] initWithFrame: CGRectMake(0, self.contentView.height - WIDTH_ONE_PIXEL, 0, WIDTH_ONE_PIXEL)];
        bottomLineView.backgroundColor = self.customSeparatorColor ?: COLOR_GRAY_E0;
        bottomLineView.tag = 1002;
        bottomLineView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self.contentView addSubview: bottomLineView];
    }

    if ([self isFirstRowInSection] && [self isLastRowInSection]) {
        topLineView.hidden = hideFirstTopSeparator;
        bottomLineView.hidden = hideLastBottomSeparator;
    } else if ([self isFirstRowInSection]) {
        topLineView.hidden = hideFirstTopSeparator;
        bottomLineView.hidden = NO;
    } else if ([self isLastRowInSection]) {
        topLineView.hidden = YES;
        bottomLineView.hidden = hideLastBottomSeparator;
    } else {
        topLineView.hidden = YES;
        bottomLineView.hidden = NO;
    }
    topLineView.left = separatorMargin.topLeftMargin;
    topLineView.width = self.width - separatorMargin.topLeftMargin - separatorMargin.topRightMargin;
    bottomLineView.left = separatorMargin.leftMargin;
    bottomLineView.width = self.width - separatorMargin.leftMargin - separatorMargin.rightMargin;
}

#pragma mark - getter & setter

- (void)setCustomSeparatorColor:(UIColor *)customSeparatorColor
{
    objc_setAssociatedObject(self, &separatorColorKey, customSeparatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)customSeparatorColor
{
    return objc_getAssociatedObject(self, &separatorColorKey);
}
@end
