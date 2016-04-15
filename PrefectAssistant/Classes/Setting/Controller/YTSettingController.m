//
//  YTSettingController.m
//  PrefectAssistant
//
//  Created by HelloWorld on 16/4/12.
//  Copyright © 2016年 HelloWorld. All rights reserved.
//

#import "YTSettingController.h"
#import <MessageUI/MessageUI.h>
#import <MBProgressHUD.h>
#import "YTAboutController.h"

@interface YTSettingController () <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation YTSettingController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self.view setBackgroundColor:YTRandomColor];
    
    self.dataSource = @[@[@"关于"],
                        @[@"清除缓存", @"检查更新"],
                        @[@"意见反馈"]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped]; {
        [tableView setDelegate:self];
        [tableView setDataSource:self];
    }
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *temp = self.dataSource[section];
    return temp.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *section = self.dataSource[indexPath.section];
    
    static NSString *reuseId = @"YTSettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    [cell.textLabel setText:section[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    NSArray *section = self.dataSource[indexPath.section];
    
    if ([section[indexPath.row] isEqualToString:@"关于"]) {
        YTAboutController *abVC = [[YTAboutController alloc] init];
        [self presentViewController:abVC animated:YES completion:nil];
    } else if ([section[indexPath.row] isEqualToString:@"清除缓存"]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [YTAlertView showAlertMsg:[NSString stringWithFormat:@"已清除 %i.%i MB", arc4random_uniform(2), arc4random_uniform(100)]];
        });
        
    } else if ([section[indexPath.row] isEqualToString:@"检查更新"]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [YTAlertView showAlertMsg:@"您已是最新版本"];
        });
    } else if ([section[indexPath.row] isEqualToString:@"意见反馈"]) {
        [self sendMailInApp];
    }
}

#pragma mark - 在应用内发送邮件
//激活邮件功能
- (void)sendMailInApp
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        [YTAlertView showAlertMsg:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"];
        return;
    }
    if (![mailClass canSendMail]) {
        [YTAlertView showAlertMsg:@"用户没有设置邮件账户"];
        return;
    }
    [self displayMailPicker];
}

//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject:@"百分助理意见反馈"];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"memorywarning@gmail.com"];
    [mailPicker setToRecipients: toRecipients];
//    NSString *emailBody = @"<font color='red'>eMail</font> 正文";
//    [mailPicker setMessageBody:emailBody isHTML:YES];
    [self presentViewController:mailPicker animated:YES completion:nil];
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
    }
    [YTAlertView showAlertMsg:msg];
}


@end
