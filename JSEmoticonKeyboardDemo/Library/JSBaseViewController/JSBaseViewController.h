//
//  JSBaseViewController.h
//  JSBaseViewControllerDemo
//
//  Created by 菅思博 on 16/12/27.
//  Copyright © 2016年 菅思博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSBaseViewController : UIViewController
#pragma mark 组件属性
@property (nonatomic, strong) UIImageView *navigationImageView;

#pragma mark 组件方法
#pragma mark NavigationBar
/**
 初始化创建NavigationBar: Title

 @param attributedTitle 文字
 @param imageName       图片名称
 */
- (void)createNavigationBarWithTitle:(NSAttributedString *)attributedTitle
                       withImageName:(NSString *)imageName;

/**
 初始化创建NavigationBar: TitleView
 */
- (void)createNavigationBarWithTitleView:(UIView *)titleView
                           withImageName:(NSString *)imageName;

/**
 初始化创建NavigationBarLeftItem

 @param leftAttributedTitle 富文本文字
 @param leftImageName       图片名称
 */
- (void)createNavigationBarLeftItemWithTitle:(NSAttributedString *)leftAttributedTitle
                               withImageName:(NSString *)leftImageName
                   withButtonImageTitleStyle:(JSButtonImageTitleStyle)buttonImageTitleStyle;

/**
 初始化创建NavigationBarRightItem
 
 @param rightAttributedTitle 富文本文字
 @param rightImageName       图片名称
 */
- (void)createNavigationBarRightItemWithTitle:(NSAttributedString *)rightAttributedTitle
                                withImageName:(NSString *)rightImageName
                    withButtonImageTitleStyle:(JSButtonImageTitleStyle)buttonImageTitleStyle;

/**
 NavigationBarLeftItem触发事件
 
 @param leftSender 左Button
 */
- (void)leftButtonClick:(UIButton *)leftSender;

/**
 NavigationBarRightItem触发事件
 
 @param rightSender 右Button
 */
- (void)rightButtonClick:(UIButton *)rightSender;

#pragma mark MBProgressHUD
///**
// 普通 HUD
// */
//- (void)showBaseHUD;
//
///**
// 普通 HUD 带文本
// 
// @param title 标题不可为空
// */
//- (void)showBaseHUDWithTitle:(NSString *)title;
//
///**
// 成功 HUD
//
// @param successTitle 标题可为空, 默认 Success
// */
//- (void)showSuccessHUDWithSuccessTitle:(NSString *)successTitle;
//
///**
// 错误 HUD
//
// @param errorTitle 标题可为空, 默认 Error
// */
//- (void)showErrorHUDWithErrorTitle:(NSString *)errorTitle;
//
///**
// 警告 HUD
// 
// @param warningTitle 标题可为空, 默认 Warning
// */
//- (void)showWarningHUDWithWarningTitle:(NSString *)warningTitle;
//
///**
// 提示HUD
// 
// @param infoTitle 标题可为空, 默认 Info
// */
//- (void)showInfoHUDWithInfoTitle:(NSString *)infoTitle;
//
///**
// 安卓 Toast
// 
// @param title 标题不可为空
// */
//- (void)showToastHUDWithTitle:(NSString *)title;
//
///**
// HUD 消失
// */
//- (void)dismissHUD;
//
///**
// HUD 延迟消失
// 
// @param afterDelay 延迟时间
// */
//- (void)dismissHUDAfter:(NSTimeInterval)afterDelay;
//
///**
// 成功 HUD 延迟消失
// 
// @param successTitle 标题可为空, 默认Success
// @param afterDelay   延迟时间
// */
//- (void)showSuccessHUDWithSuccessTitle:(NSString *)successTitle
//                       dismissHUDAfter:(NSTimeInterval)afterDelay;
//
///**
// 错误 HUD 延迟消失
// 
// @param errorTitle  标题可为空, 默认Error
// @param afterDelay  延迟时间
// */
//- (void)showErrorHUDWithErrorTitle:(NSString *)errorTitle
//                   dismissHUDAfter:(NSTimeInterval)afterDelay;
//
///**
// 警告 HUD 延迟消失
// 
// @param warningTitle 标题可为空, 默认Warning
// @param afterDelay   延迟时间
// */
//- (void)showWarningHUDWithWarningTitle:(NSString *)warningTitle
//                       dismissHUDAfter:(NSTimeInterval)afterDelay;
//
///**
// 提示 HUD 延迟消失
// 
// @param infoTitle   标题可为空, 默认Info
// @param afterDelay  延迟时间
// */
//- (void)showInfoHUDWithInfoTitle:(NSString *)infoTitle
//                 dismissHUDAfter:(NSTimeInterval)afterDelay;
//
///**
// 安卓 Toast 延迟消失
//
// @param title       标题不可为空
// @param afterDelay  延时时间
// */
//- (void)showToastHUDWithTitle:(NSString *)title
//              dismissHUDAfter:(NSTimeInterval)afterDelay;

@end
