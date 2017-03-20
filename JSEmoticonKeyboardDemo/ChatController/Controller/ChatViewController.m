//
//  ChatViewController.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/19.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "ChatViewController.h"

#import "JSEmoticonKeyboardView.h"

#import "ChatModel.h"
#import "ChatViewModel.h"

#import "ChatTableViewCell.h"

static NSString *identifier = @"ChatTableViewCell";

@interface ChatViewController () <JSEmoticonKeyboardDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) JSEmoticonKeyboardView *keyboard;

@property(nonatomic, strong) UITableView *chatList;

@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ChatViewController
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor js_colorWithHexString:@"#EEEEEE"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNavigation];
    
    [self createSubviews];
    
    _dataSource = [NSMutableArray array];
    [self setupDataSource];
}

#pragma mark Setup Navigation
- (void)setupNavigation {
    NSAttributedString *attributedTitleString = [[NSAttributedString alloc] initWithString:@"聊天界面"
                                                                                attributes:@{
                                                                                             NSForegroundColorAttributeName : [UIColor js_colorWithHexString:@"#FFFFFF"]
                                                                                             }];
    
    [self createNavigationBarWithTitle:attributedTitleString
                         withImageName:@"Navigation"];
    [self createNavigationBarLeftItemWithTitle:nil
                                 withImageName:@"BackBarButton~iphone"
                     withButtonImageTitleStyle:JSButtonImageTitleStyleLeft];
}

#pragma mark Create Subviews
- (void)createSubviews {
    _keyboard = [JSEmoticonKeyboardView defaultEmoticonKeyboard];
    
    _keyboard.emoticonKeyboardDelegate = self;
    
    [self.view addSubview:_keyboard];
    [self.view addSubview:self.chatList];
}

#pragma mark Setup DataSource
- (void)setupDataSource {
    for (int i = 0; i < 2; i++) {
        ChatViewModel *chatView = [[ChatViewModel alloc] init];
        ChatModel *chat = [[ChatModel alloc] init];
        
        chat.userType = i % 2 ? userTypeMe : userTypeOther;
        
        chat.userId = i;
        
        NSString *sendMessage = @"在村里，Lz辈分比较大，在我还是小屁孩的时候就有大人喊我叔了，这不算糗[委屈]。 成年之后，鼓起勇气向村花二丫深情表白了(当然是没有血缘关系的)[害羞]，结果她一脸淡定的回绝了:二叔！别闹……[尴尬]";
        NSString *takeMessage = @"小学六年级书法课后不知是哪个用红纸写了张六畜兴旺贴教室门上，上课语文老师看看门走了过了一会才来过了几天去办公室交作业听见语文老师说：看见那几个字我本来是不想进去的，但是后来一想养猪的也得进去喂猪[偷笑]";
        
        chat.chatContent = chat.userType != userTypeMe ? takeMessage : sendMessage;
        
        chatView.chat = chat;
        
        [_dataSource addObject:chatView];
    }
    
    [self.chatList reloadData];
    
    [self scrollTableViewToBottom];
}

#pragma mark Lazy
- (UITableView *)chatList {
    if (!_chatList) {
        _chatList = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, JSSCREEN_W, JSSCREEN_H - 64.0f - 46.5f)];
        
        _chatList.backgroundColor = [UIColor js_colorWithHexString:@"#EEEEEE"];
        
        _chatList.delegate = self;
        _chatList.dataSource = self;
        
        _chatList.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _chatList.tableFooterView = [[UIView alloc] init];
        
        [_chatList registerClass:[ChatTableViewCell class]
          forCellReuseIdentifier:identifier];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(chatListTap)];
        [_chatList addGestureRecognizer:tapGestureRecognizer];
    }
    
    return _chatList;
}

#pragma mark Action
- (void)chatListTap {
    [JSEmoticonKeyboardView hideEmoticonKeyboardViewInView:self.view];
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    if (menuController.menuVisible) {
        [menuController setMenuVisible:NO
                              animated:YES];
    }
}

//  滚动到底部
- (void)scrollTableViewToBottom {
    if (_dataSource.count - 1 >= 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataSource.count - 1
                                                    inSection:0];
        
        [self.chatList scrollToRowAtIndexPath:indexPath
                             atScrollPosition:UITableViewScrollPositionBottom
                                     animated:NO];
    }
}

#pragma mark JSEmoticonKeyboardDelegate
//  发送按钮事件
- (void)js_emoticonKeyboardSendPlainString:(NSString *)plainString {
    if (!plainString.length) {
        return;
    }
    //  点击发送，发出一条消息
    ChatViewModel *chatView = [[ChatViewModel alloc] init];
    ChatModel *chat = [[ChatModel alloc] init];
    
    chat.chatContent = plainString;
    chat.userType = userTypeOther;
    chat.userHead = @"鸣人";
    chat.userName = @"鸣人";
    chat.userId = _dataSource.count;
    
    chatView.chat = chat;
    
    [_dataSource addObject:chatView];
    
    [_chatList reloadData];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self scrollTableViewToBottom];
    }];
    
    _keyboard.emoticonTopBarView.emoticonTextView.text = @"";
    
    [_keyboard.emoticonTopBarView resetEmoticonTopBar];
}

- (void)js_updateSuperView {
    [UIView animateWithDuration:0.3f animations:^{
        _chatList.js_height = _keyboard.js_top - 64.0f;
        
        [self scrollTableViewToBottom];
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    ChatViewModel *chatView = [_dataSource objectAtIndex:indexPath.row];
    
    cell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:identifier];
    
    cell.chatView = chatView;
        
    [cell setDeleteChatBlock:^(ChatViewModel *viewModel) {
        NSUInteger index = [_dataSource indexOfObject:viewModel];
        
        [_dataSource removeObject:viewModel];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index
                                                    inSection:0];
        
        [_chatList deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationNone];
    }];

    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatViewModel *chatView = [_dataSource objectAtIndex:indexPath.row];
    
    return chatView.cellHeight;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    if (menuController.menuVisible) {
        [menuController setMenuVisible:NO
                              animated:YES];
    }
}

#pragma mark Action
- (void)leftButtonClick:(UIButton *)leftSender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
