//
//  UITableViewCell+ConfigureCategory.h
//  GTWork
//
//  Created by yjh on 2020/8/27.
//  Copyright © 2020 apple. All rights reserved.
//

typedef struct GTTableViewCellSeparatorMargin {
    CGFloat topLeftMargin;
    CGFloat topRightMargin;
    CGFloat leftMargin;
    CGFloat rightMargin;
    CGFloat bottomLeftMargin;
    CGFloat bottomRightMargin;
} GTTableViewCellSeparatorMargin;

GTTableViewCellSeparatorMargin GTTableViewCellSeparatorMarginMake(CGFloat topLeftMargin, CGFloat topRightMargin, CGFloat leftMargin, CGFloat rightMargin, CGFloat bottomLeftMargin, CGFloat bottomRightMargin);


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (ConfigureCategory)

@property (nonatomic, weak, readonly) UITableView *superTableView;
@property (nonatomic, assign, readonly) BOOL isFirstRowInSection;
@property (nonatomic, assign, readonly) BOOL isLastRowInSection;
@property (nonatomic, strong) UIColor *customSeparatorColor;

/** 在 `- (void)layoutSubviews` 中调用 */
- (void)configureSeparatorAndHideFirstTopSeparator:(BOOL)hideFirstTopSeparator andHideLastBottomSeparator:(BOOL)hideLastBottomSeparator;
- (void)configureSeparatorWithLeftMargin:(CGFloat)leftMargin andHideFirstTopSeparator:(BOOL)hideFirstTopSeparator andHideLastBottomSeparator:(BOOL)hideLastBottomSeparator;
- (void)configureSeparatorWithSeparatorMargin:(GTTableViewCellSeparatorMargin)separatorMargin andHideFirstTopSeparator:(BOOL)hideFirstTopSeparator andHideLastBottomSeparator:(BOOL)hideLastBottomSeparator;

@end

NS_ASSUME_NONNULL_END
