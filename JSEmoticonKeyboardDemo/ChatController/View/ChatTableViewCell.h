//
//  ChatTableViewCell.h
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/19.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatViewModel.h"

@interface ChatTableViewCell : UITableViewCell

@property (nonatomic, strong) ChatViewModel *chatView;

@property (nonatomic, copy) void(^deleteChatBlock)(ChatViewModel *viewModel);

@end
