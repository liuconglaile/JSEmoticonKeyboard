//
//  JSBaseViewController.m
//  JSBaseViewControllerDemo
//
//  Created by 菅思博 on 16/12/27.
//  Copyright © 2016年 菅思博. All rights reserved.
//

#import "JSBaseViewController.h"

@interface JSBaseViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation JSBaseViewController
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark 组件方法
#pragma mark NavigationBar
- (void)createNavigationBarWithTitle:(NSAttributedString *)attributedTitle
                       withImageName:(NSString *)imageName {
    self.navigationController.navigationBarHidden = YES;
    
    _navigationImageView = [[UIImageView alloc] init];
    
    _navigationImageView.backgroundColor = [UIColor whiteColor];
    
    _navigationImageView.image = [UIImage imageNamed:imageName];
    _navigationImageView.contentMode = UIViewContentModeScaleToFill;
    
    _navigationImageView.userInteractionEnabled = YES;
    
    _navigationImageView.frame = CGRectMake(0, 0, JSSCREEN_W, 64);

    [self.view addSubview:_navigationImageView];
    
    _titleLabel = [[UILabel alloc] init];
    
    _titleLabel.backgroundColor = [UIColor clearColor];
    
    _titleLabel.attributedText = attributedTitle;
    
    CGFloat labelWidth = [_titleLabel.text js_widthForFont:_titleLabel.font];
    CGFloat labelHeight = [_titleLabel.text js_heightForFont:_titleLabel.font
                                                       width:labelWidth];
    
    _titleLabel.frame = CGRectMake((JSSCREEN_W - labelWidth) / 2, 20 + (44 - labelHeight) / 2, labelWidth, labelHeight);
        
    [_navigationImageView addSubview:_titleLabel];
}

- (void)createNavigationBarWithTitleView:(UIView *)titleView
                           withImageName:(NSString *)imageName {
    self.navigationController.navigationBarHidden = YES;
    
    _navigationImageView = [[UIImageView alloc] init];
    
    _navigationImageView.backgroundColor = [UIColor whiteColor];
    
    _navigationImageView.image = [UIImage imageNamed:imageName];
    _navigationImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _navigationImageView.userInteractionEnabled = YES;

    _navigationImageView.frame = CGRectMake(0, 0, JSSCREEN_W, 64);
    
    [self.view addSubview:_navigationImageView];
    
    CGFloat viewWidth = titleView.frame.size.width;
    CGFloat viewHeight = titleView.frame.size.height;
    
    titleView.frame = CGRectMake((JSSCREEN_W - viewWidth) / 2, 20 + (44 - viewHeight) / 2, viewWidth, viewHeight);
    
    [_navigationImageView addSubview:titleView];
}

- (void)createNavigationBarLeftItemWithTitle:(NSAttributedString *)leftAttributedTitle
                               withImageName:(NSString *)leftImageName
                   withButtonImageTitleStyle:(JSButtonImageTitleStyle)buttonImageTitleStyle {
    _leftButton = [[UIButton alloc] init];
    
    _leftButton.backgroundColor = [UIColor clearColor];
    
    [_leftButton setImage:[UIImage imageNamed:leftImageName]
                 forState:UIControlStateNormal];
    [_leftButton setImage:[UIImage imageNamed:leftImageName]
                 forState:UIControlStateSelected];
    
    [_leftButton setAttributedTitle:leftAttributedTitle
                           forState:UIControlStateNormal];
    [_leftButton setAttributedTitle:leftAttributedTitle
                           forState:UIControlStateSelected];
    
    CGFloat imageWidth;
    CGFloat imageHeight;
    CGFloat labelWidth;
    CGFloat labelHeight;
    
    if (leftAttributedTitle) {
        labelWidth = [_leftButton.titleLabel.text js_widthForFont:_leftButton.titleLabel.font];
        labelHeight = [_leftButton.titleLabel.text js_heightForFont:_leftButton.titleLabel.font
                                                              width:labelWidth];
        
        if (leftImageName) {
            imageWidth = _leftButton.imageView.image.size.width;
            imageHeight = _leftButton.imageView.image.size.height;

            _leftButton.frame = CGRectMake(8, 20 + (44 - (imageHeight > labelHeight ? imageHeight : labelHeight)) / 2, imageWidth + labelWidth + 5.0f, imageHeight > labelHeight ? imageHeight : labelHeight);
            
            [_leftButton js_setButtonImageTitleStyle:buttonImageTitleStyle
                                             spacing:5.0f];
        }
        else {
            _leftButton.frame = CGRectMake(8, 20 + (44 - labelHeight) / 2, labelWidth, labelHeight);
        }
    }
    else {
        imageWidth = _leftButton.imageView.image.size.width;
        imageHeight = _leftButton.imageView.image.size.height;
        
        _leftButton.frame = CGRectMake(8, 20 + (44 - imageHeight) / 2, imageWidth, imageHeight);
    }
    
    [_leftButton addTarget:self
                    action:@selector(leftButtonClick:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [_navigationImageView addSubview:_leftButton];
}

- (void)createNavigationBarRightItemWithTitle:(NSAttributedString *)rightAttributedTitle
                                withImageName:(NSString *)rightImageName
                    withButtonImageTitleStyle:(JSButtonImageTitleStyle)buttonImageTitleStyle {
    _rightButton = [[UIButton alloc] init];
    
    _rightButton.backgroundColor = [UIColor clearColor];
    
    [_rightButton setImage:[UIImage imageNamed:rightImageName]
                  forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:rightImageName]
                  forState:UIControlStateSelected];
    
    [_rightButton setAttributedTitle:rightAttributedTitle
                            forState:UIControlStateNormal];
    [_rightButton setAttributedTitle:rightAttributedTitle
                            forState:UIControlStateSelected];
    
    CGFloat imageWidth;
    CGFloat imageHeight;
    CGFloat labelWidth;
    CGFloat labelHeight;
    
    if (rightAttributedTitle) {
        labelWidth = [_rightButton.titleLabel.text js_widthForFont:_rightButton.titleLabel.font];
        labelHeight = [_rightButton.titleLabel.text js_heightForFont:_rightButton.titleLabel.font
                                                               width:labelWidth];
        
        if (rightImageName) {
            imageWidth = _rightButton.imageView.image.size.width;
            imageHeight = _rightButton.imageView.image.size.height;
            
            _rightButton.frame = CGRectMake(JSSCREEN_W - (imageWidth + labelWidth + 5.0f) - 8, 20 + (44 - (imageHeight > labelHeight ? imageHeight : labelHeight)) / 2, imageWidth + labelWidth + 5.0f, imageHeight > labelHeight ? imageHeight : labelHeight);
            
            [_rightButton js_setButtonImageTitleStyle:buttonImageTitleStyle
                                              spacing:5.0f];
        }
        else {
            _rightButton.frame = CGRectMake(JSSCREEN_W - labelWidth - 8, 20 + (44 - labelHeight) / 2, labelWidth, labelHeight);
        }
    }
    else {
        imageWidth = _rightButton.imageView.image.size.width;
        imageHeight = _rightButton.imageView.image.size.height;
        
        _rightButton.frame = CGRectMake(JSSCREEN_W - imageWidth - 8, 20 + (44 - imageHeight) / 2, imageWidth, imageHeight);
    }
    
    [_rightButton addTarget:self
                     action:@selector(rightButtonClick:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [_navigationImageView addSubview:_rightButton];
}

- (void)leftButtonClick:(UIButton *)leftSender {
    NSLog(@"导航左按钮%s",__FUNCTION__);
}

- (void)rightButtonClick:(UIButton *)rightSender {
    NSLog(@"导航右按钮%s",__FUNCTION__);
}

#pragma mark MBProgressHUD
//- (void)showBaseHUD {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view
//                                                  animated:YES];
//    
//        hud.bezelView.color = JSHUD_COLOR;
//        hud.contentColor = JSHUD_CONTENT_COLOR;
//    });
//}
//
//- (void)showBaseHUDWithTitle:(NSString *)title {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view
//                                                  animated:YES];
//    
//        hud.label.text = title;
//        hud.bezelView.color = JSHUD_COLOR;
//        hud.contentColor = JSHUD_CONTENT_COLOR;
//    });
//}
//
//- (void)showSuccessHUDWithSuccessTitle:(NSString *)successTitle {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view
//                                                  animated:YES];
//    
//        hud.mode = MBProgressHUDModeCustomView;
//    
//        hud.bezelView.color = JSHUD_COLOR;
//        hud.contentColor = JSHUD_CONTENT_COLOR;
//    
//        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_success"]];
//    
//        hud.label.text = successTitle ? successTitle : @"Success";
//    });
//}
//
//- (void)showErrorHUDWithErrorTitle:(NSString *)errorTitle {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view
//                                                  animated:YES];
//        
//        hud.mode = MBProgressHUDModeCustomView;
//        
//        hud.bezelView.color = JSHUD_COLOR;
//        hud.contentColor = JSHUD_CONTENT_COLOR;
//    
//        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_error"]];
//    
//        hud.label.text = errorTitle ? errorTitle : @"Error";
//    });
//}
//
//- (void)showWarningHUDWithWarningTitle:(NSString *)warningTitle {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view
//                                                  animated:YES];
//    
//        hud.mode = MBProgressHUDModeCustomView;
//    
//        hud.bezelView.color = JSHUD_COLOR;
//        hud.contentColor = JSHUD_CONTENT_COLOR;
//    
//        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_warning"]];
//    
//        hud.label.text = warningTitle ? warningTitle : @"Warning";
//    });
//}
//
//- (void)showInfoHUDWithInfoTitle:(NSString *)infoTitle {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view
//                                                  animated:YES];
//    
//        hud.mode = MBProgressHUDModeCustomView;
//    
//        hud.bezelView.color = JSHUD_COLOR;
//        hud.contentColor = JSHUD_CONTENT_COLOR;
//    
//        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_info"]];
//    
//        hud.label.text = infoTitle ? infoTitle : @"Info";
//    });
//}
//
//- (void)showToastHUDWithTitle:(NSString *)title {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view
//                                                  animated:YES];
//    
//        hud.mode = MBProgressHUDModeText;
//    
//        hud.bezelView.color = JSHUD_COLOR;
//        hud.contentColor = JSHUD_CONTENT_COLOR;
//        
//        hud.label.text = title;
//    
//        hud.offset = CGPointMake(0.0f, MBProgressMaxOffset);
//    });
//}
//
//- (void)dismissHUD {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
//        
//        [hud hideAnimated:YES];
//    });
//}
//
//- (void)dismissHUDAfter:(NSTimeInterval)afterDelay {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.navigationController.view];
//        
//        [hud hideAnimated:YES
//               afterDelay:afterDelay];
//    });
//}
//
//- (void)showSuccessHUDWithSuccessTitle:(NSString *)successTitle
//                       dismissHUDAfter:(NSTimeInterval)afterDelay {
//    [self showSuccessHUDWithSuccessTitle:successTitle];
//    
//    [self dismissHUDAfter:afterDelay];
//}
//
//- (void)showErrorHUDWithErrorTitle:(NSString *)errorTitle
//                   dismissHUDAfter:(NSTimeInterval)afterDelay {
//    [self showErrorHUDWithErrorTitle:errorTitle];
//    
//    [self dismissHUDAfter:afterDelay];
//}
//
//- (void)showWarningHUDWithWarningTitle:(NSString *)warningTitle
//                       dismissHUDAfter:(NSTimeInterval)afterDelay {
//    [self showWarningHUDWithWarningTitle:warningTitle];
//    
//    [self dismissHUDAfter:afterDelay];
//}
//
//- (void)showInfoHUDWithInfoTitle:(NSString *)infoTitle
//                 dismissHUDAfter:(NSTimeInterval)afterDelay {
//    [self showInfoHUDWithInfoTitle:infoTitle];
//    
//    [self dismissHUDAfter:afterDelay];
//}
//
//- (void)showToastHUDWithTitle:(NSString *)title
//              dismissHUDAfter:(NSTimeInterval)afterDelay {
//    [self showToastHUDWithTitle:title];
//    
//    [self dismissHUDAfter:afterDelay];
//}

@end
