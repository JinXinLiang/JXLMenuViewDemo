# JXLMenuViewDemo
**在项目中引入JXLMenuView头文件**

	#import "JXLMenuView.h"
**创建JXLMenuView设置其属性：**
	
	//// 未选中时的标题文字颜色，默认grayColor
	@property (nonatomic, strong) UIColor *titleColor;

	/// 选中时的标题文字颜色，默认blackColor
	@property (nonatomic, strong) UIColor *titleSelectedColor;

	/// menu栏的宽度，默认宽度100
	@property (nonatomic, assign) CGFloat menuWith;

	/// 获取当前menu选项的centerView
	@property (nonatomic, readonly, strong) UIView *centerView;
	
	/// 设置JXLMenuView的代理
	@property (nonatomic, assign) id<JXLMenuViewDelegate>delegate;
    
**实现JXLMenuView的代理方法-必须实现的方法：**

	@required

	/**
	 *  设置菜单选项数量
	 */
	- (NSInteger)numberOfRowsInMenuView:(JXLMenuView *)menuView;

	/**
	 *  设置每个菜单的标题
	 */
	- (NSString *)menuView:(JXLMenuView *)menuView titleOfRow:(NSInteger)menuIndex;

	/**
	 *  设置每个菜单详情内容
 	*/
	- (UIView *)menuView:(JXLMenuView *)menuView centerViewForIndex:(NSInteger)menuIndex;
**实现JXLMenuView的代理方法-选择实现的方法：**

	@optional

	/**
 	*  设置每个menu选项的高度，默认65
 	*/
	- (CGFloat)menuView:(JXLMenuView *)menuView heightForRow:(NSInteger)menuIndex;

	/**
 	*  menu选项被点击时的回调方法
 	*/
	- (void)menuView:(JXLMenuView *)menuView didSelectRowAtIndex:(NSInteger)menuIndex;


