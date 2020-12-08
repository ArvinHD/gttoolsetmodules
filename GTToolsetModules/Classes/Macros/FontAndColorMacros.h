//
//  FontAndColorMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

//字体大小和颜色配置

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark -  间距区

//默认间距
#define KNormalSpace 12.0f
#define KLeftMargin 16.0f
#define KRightMargin 16.0f
#define KTopNewsMargin 9.0f
#define KBottomMargin 15.0f

#pragma mark -  颜色区

#pragma mark - **************** 业务色
#define CBrandColor0  [UIColor colorWithHexString:@"406CFE"] /**<  业务品牌色 0*/
#define CBrandColor1  [UIColor colorWithHexString:@"DAE5FF"] /**<  业务品牌色 1*/

#pragma mark - **************** 背景色
#define CCardBgColor         [UIColor colorWithHexString:@"ffffff"] /**<  卡片背景*/
#define CPageBgColor         [UIColor colorWithHexString:@"FAFBFD"] /**<  页面背景*/
#define CControlsBgColor     [UIColor colorWithHexString:@"f8f8f8"] /**<  控件背景*/
#define CMainBgColor         [UIColor colorWithHexString:@"406CFE"] /**<  主色*/
#define CMainShallowBgColor  [UIColor colorWithHexString:@"E0E7FF"] /**<  主色-浅*/
#define CWarnBgColor         [UIColor colorWithHexString:@"FF4136"] /**<  警告色*/

#pragma mark - **************** 文字颜色
#define CMainTestColor            [UIColor colorWithHexString:@"2965FA"] /**<  主色*/
#define CMainShallowTestColor     [UIColor colorWithHexString:@"EAF0FF"] /**<  主色-浅*/
#define CWarnTestColor            [UIColor colorWithHexString:@"F45959"] /**<  警告色*/
#define CMainTitleTestColor       [UIColor colorWithHexString:@"262626"] /**<  主标题*/
#define CSubtitleTestColor        [UIColor colorWithHexString:@"555555"] /**<  副标题*/
#define CWeakCopywriterTestColor  [UIColor colorWithHexString:@"999999"] /**<  弱文案*/
#define CSubWeakCopywriterTestColor  [UIColor colorWithHexString:@"C0C0C0"] /**<  次弱文案*/
#define CBasisTestColor           [UIColor colorWithHexString:@"ffffff"] /**<  基础色*/

#pragma mark - **************** 分割线/分隔条
#define CDividerColor  [UIColor colorWithHexString:@"#EAEEEF"] /**<  分割线*/
#define CSplitterColor  [UIColor colorWithHexString:@"#FAFBFD"] /**<  分隔条*/


#pragma mark - **************** 蒙层
#define CProductsCoverLayerColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.55] /**<  产品蒙层*/
#define CMarketCoverLayerColor    [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75] /**<  营销蒙层*/

#pragma mark - 字号

#define CStressFont     [UIFont systemFontOfSize:27] /**<  页面核心强调*/
#define CTitleFont      [UIFont systemFontOfSize:18] /**<  大标题*/
#define CListFont       [UIFont systemFontOfSize:17] /**<  列表*/
#define CSubTitleFont   [UIFont systemFontOfSize:15] /**<  小标题*/
#define CContentFont    [UIFont systemFontOfSize:13] /**<  常规内容*/
#define CSubContentFont [UIFont systemFontOfSize:12] /**<  次常规内容*/
#define CWeakFont       [UIFont systemFontOfSize:11] /**<  弱化内容*/
//粗体
#define CStressBoldFont     [UIFont boldSystemFontOfSize:27] /**<  页面核心强调*/
#define CTitleBoldFont      [UIFont boldSystemFontOfSize:18] /**<  大标题*/
#define CListBoldFont       [UIFont boldSystemFontOfSize:17] /**<  列表*/
#define CSubTitleBoldFont   [UIFont boldSystemFontOfSize:15] /**<  小标题*/
#define CContentBoldFont    [UIFont boldSystemFontOfSize:13] /**<  常规内容*/
#define CSubContentBoldFont [UIFont boldSystemFontOfSize:12] /**<  次常规内容*/
#define CWeakBoldFont       [UIFont boldSystemFontOfSize:11] /**<  弱化内容*/
//根据配置适配字体大小
#define CconfigureFont(fontSize) [UIFont systemFontOfSize:[GTuntil getConfigureFont:fontSize]]
#define CconfigureBoldFont(fontSize) [UIFont boldSystemFontOfSize:[GTuntil getConfigureFont:fontSize]]

#pragma mark - 圆角&间距&描边&图标&置灰态
#pragma mark - **************** 圆角

#define KSmallRoundedCorners 2.0f /**<  小*/
#define KMediumRoundedCorners 4.0f /**<  中*/
#define KBigRoundedCorners 8.0f /**<  大*/

#pragma mark - **************** 间距
#define KLRlargeSpace 16.0f /**<  左右页边距*/
#define KLevelSpace 8.0f /**<  水平边距*/
#define KBigLevelSpace 12.0f /**<  水平大边距*/
#define KVerticalSpace 8.0f /**<  垂直边距*/
#define KBigVerticalSpace 12.0f /**<  垂直大边距*/

#pragma mark - **************** 描边
#define KBorderWidth 1.0f /**<  边框宽度*/
#define KThickWidth 2.0f /**<  边框宽度*/

#pragma mark - **************** 图标尺寸
#define KBigIconSize 32.0f/**<  大*/
#define KMediumIconSize 32.0f/**<  中*/
#define KSmallIconSize 32.0f/**<  小*/
#define KVSmallIconSize 32.0f/**<  特小*/


//------------------------临时
//主题色 导航栏颜色
#define CNavBgColor  [UIColor colorWithHexString:@"4A82FF"] /**<  背景主色调 */
#define CNavBgFontColor  [UIColor colorWithHexString:@"ffffff"] /**<  导航栏字体颜色*/
#define CTabFontColor  [UIColor colorWithHexString:@"909398"] /**<  tabbar 默认颜色 */
#define CTabselectFontColor  [UIColor colorWithHexString:@"4A82FF"] /**<  tabbar 选中颜色 */

//默认页面背景色
#define CViewBgColor [UIColor colorWithHexString:@"#F2F6FC"] /**< 页面背景 */

//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"#F2F6FC"]

//次级字色
#define CFontColor1 [UIColor colorWithHexString:@"1f1f1f"]

//再次级字色
#define CFontColor2 [UIColor colorWithHexString:@"5c5c5c"]

//新闻主标题颜色
#define GTColorNewsTitle [UIColor colorWithHexString:@"#303133"]
//新闻3级颜色（底部时间）
#define GTColorNewsThird [UIColor colorWithHexString:@"#8C8C8C"]

#pragma mark -  字体区

//新闻主标题字体
#define GTFontNewsTitle [UIFont systemFontOfSize:16.0f]
//新闻3级字体（底部时间）
#define GTFontNewsThird [UIFont systemFontOfSize:12.0f]

//随机色
#define _R_COLOR(color) ((((unsigned int)color) >> 16) & 0xFF)
#define _G_COLOR(color) ((((unsigned int)color) >> 8) & 0xFF)
#define _B_COLOR(color) (((unsigned int)color) & 0xFF)
#define UICOLOR_RGB(color) [UIColor colorWithRed: _R_COLOR(color) / 255.0 green: _G_COLOR(color) / 255.0 blue: _B_COLOR(color) / 255.0 alpha: 1]
#define COLOR_GRAY_E0 UICOLOR_RGB(0xe0e0e0)

#endif /* FontAndColorMacros_h */
