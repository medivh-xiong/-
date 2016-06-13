//
//  ViewController.m
//  微博个人详情界面
//
//  Created by 熊欣 on 16/6/12.
//  Copyright © 2016年 熊欣. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Image.h"

#define XHheadViewHeight 200
#define XHbtnViewHeight  44
#define XHheadViewMinH   64

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *contentTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (nonatomic, readwrite, assign) CGFloat originOffsetY;
@property (nonatomic, readwrite, weak) UILabel *titleLabel;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
   
    [self setContentTableAttribute];
    
}

- (void)setUpNavigationBar
{
    // ----1.首先苹果官方自动回做一个处理，会在导航控制的上面自动添加导航栏，并且其他空间高度自动产生变化，这个变化是在ViewDidAppear这个方法里面添加的，因此要做一个处理；
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // ----然后隐藏导航栏,苹果官方做了处理了，如果给任意图片都会做处理，因此传递一个空的image就会变成透明，类型一定要改成defualt否则无法设置背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
   
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"吾即大灾变";
    self.titleLabel = titleLabel;
    
    [titleLabel setTextColor:[UIColor colorWithWhite:1 alpha:0]];
    [titleLabel sizeToFit];
    
    // ----设置titleView
    self.navigationItem.titleView = titleLabel;

}

- (void)setContentTableAttribute
{
    // ----tableView的偏移量是tablview内容与可视范围的差值，没有设置contentInset就没有偏移量
//        self.originOffsetY = self.contentTable.contentOffset.y;
    self.originOffsetY = - (XHheadViewHeight + XHbtnViewHeight);
    
    // ----设置数据源和代理方法
    self.contentTable.delegate = self;
    self.contentTable.dataSource = self;
    
    // ----设置内容偏移量和设置初始的偏移位置信息，顿时立刻调用didScroll方法
    self.contentTable.contentInset = UIEdgeInsetsMake(XHheadViewHeight + XHbtnViewHeight, 0, 0, 0);
    
    NSLog(@"origin = %f", self.originOffsetY);
    
}

#pragma mark - taleView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

#pragma mark - tableView代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // ----移动的高度=移动后的y-最初的y
    CGFloat scrollHeight = scrollView.contentOffset.y - self.originOffsetY;
    NSLog(@"height = %f", scrollHeight);
    
    CGFloat h = XHheadViewHeight - scrollHeight;
    
    // ----添加悬停效果
    if (h <= XHheadViewMinH) {
        h = XHheadViewMinH;
    }
    
    self.topViewHeight.constant = h;
    
    // ----如果透明度为1的情况下，导航栏自动回坐处理，让图片透明，因此可以设置成0.99
    CGFloat alpha = scrollHeight / (XHheadViewHeight - XHheadViewMinH);
    
    if (alpha >= 1) {
        alpha = 0.99f;
    }
    
    self.titleLabel.textColor = [UIColor colorWithWhite:0 alpha:alpha];
   
    // ----设定导航栏的渐变色，因为导航栏颜色没法设置透明度，只能从图片进行修改
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    
}


@end
