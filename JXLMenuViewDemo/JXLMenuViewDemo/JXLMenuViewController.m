//
//  XLMenuViewController.m
//  JXLMenuViewDemo
//
//  Created by Eiwodetianna on 9/7/15.
//  Copyright © 2015 jinxinliang. All rights reserved.
//

#import "JXLMenuViewController.h"
#import "JXLMenuView.h"

@interface JXLMenuViewController ()<JXLMenuViewDelegate>

@property (nonatomic, strong) NSMutableArray *titles;

@end

@implementation JXLMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置navigationBar不透明
    self.navigationController.navigationBar.translucent = NO;
    // 设置titles数组
    self.titles = [NSMutableArray array];
    for (NSInteger i = 0; i < 8; i++) {
        NSString *title = [NSString stringWithFormat:@"Menu %ld", i];
        [self.titles addObject:title];
    }
    
    // 创建JXLMenuView
    JXLMenuView *jxlMenuView = [[JXLMenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    jxlMenuView.titleColor = [UIColor grayColor]; // 未选中时的标题文字颜色，默认grayColor
    jxlMenuView.titleSelectedColor = [UIColor blackColor]; // 选中时的标题文字颜色，默认blackColor
    jxlMenuView.menuWith = 100.f; // menu栏的宽度，默认宽度100
    jxlMenuView.delegate = self;
    jxlMenuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:jxlMenuView];
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark JXLMenuDelegate

- (NSInteger)numberOfRowsInMenuView:(JXLMenuView *)menuView {
    return self.titles.count;
}

- (NSString *)menuView:(JXLMenuView *)menuView titleOfRow:(NSInteger)menuIndex {
    return self.titles[menuIndex];
}


- (UIView *)menuView:(JXLMenuView *)menuView centerViewForIndex:(NSInteger)menuIndex {
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 100, 190, 50)];
    label.backgroundColor = [UIColor yellowColor];
    label.text = [NSString stringWithFormat:@"CenterView %ld", menuIndex];
    [view addSubview:label];
    return view;
}



- (void)menuView:(JXLMenuView *)menuView didSelectRowAtIndex:(NSInteger)menuIndex {
    // You can get centerView use menuView.centerView
    NSLog(@"centerView:%@", menuView.centerView);
    
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
