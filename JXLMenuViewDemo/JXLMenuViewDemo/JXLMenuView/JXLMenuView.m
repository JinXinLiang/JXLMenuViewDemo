//
//  XLMenuView.m
//  Food
//
//  Created by Eiwodetianna on 9/6/15.
//  Copyright © 2015 jinxinliang. All rights reserved.
//

#import "JXLMenuView.h"
#import "JXLMenuCollectionViewCell.h"

@interface JXLMenuView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (nonatomic, strong) UICollectionView *menuTitleCollectionView;

@property (nonatomic, readwrite, strong) UIView *centerView;

@property (nonatomic, strong) NSMutableArray *centerViewArray;

@property (nonatomic, assign) NSInteger menuCount;

@end

@implementation JXLMenuView

- (void)dealloc {
    _menuTitleCollectionView.dataSource = nil;
    _menuTitleCollectionView.delegate = nil;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.centerViewArray = [NSMutableArray array];
        _menuWith = 100.f;
        
        self.titleColor = [UIColor grayColor];
        self.titleSelectedColor = [UIColor blackColor];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        
        _menuTitleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _menuWith, frame.size.height) collectionViewLayout:flowLayout];
        _menuTitleCollectionView.showsVerticalScrollIndicator = NO;
        _menuTitleCollectionView.backgroundColor = self.backgroundColor;
        [self addSubview:_menuTitleCollectionView];
        [_menuTitleCollectionView registerClass:[JXLMenuCollectionViewCell class] forCellWithReuseIdentifier:@"menu"];
        

        
    }
    return self;
    
}

- (void)setMenuWith:(CGFloat)menuWith {
    
    _menuWith = menuWith;
    
    _menuTitleCollectionView.frame = CGRectMake(0, 0, _menuWith, self.frame.size.height);
    
    self.centerView.frame = CGRectMake(_menuTitleCollectionView.frame.origin.x + _menuTitleCollectionView.frame.size.width, _menuTitleCollectionView.frame.origin.y, self.frame.size.width - _menuTitleCollectionView.frame.origin.x - _menuTitleCollectionView.frame.size.width, self.frame.size.height);
}

- (void)setDelegate:(id<JXLMenuViewDelegate>)delegate {
    
    if (_delegate != delegate) {
        
        _delegate = delegate;
        
        _menuTitleCollectionView.dataSource = self;
        _menuTitleCollectionView.delegate = self;
        
        [self.centerViewArray removeAllObjects];
        
        _menuCount = [self.delegate numberOfRowsInMenuView:self];
        for (NSInteger count = 0; count < _menuCount; count++) {
            
            UIView *centerView = [self.delegate menuView:self centerViewForIndex:count];
            // centerView为空，抛出异常
            if (nil == centerView) {
                NSException *exception = [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"JXLMenuView:%@ failed to obtain a centerView from its delegate", self] userInfo:nil];
                @throw exception;
            }
            
            [self.centerViewArray addObject:centerView];
            
            centerView.frame = CGRectMake(_menuTitleCollectionView.frame.origin.x + _menuTitleCollectionView.frame.size.width, _menuTitleCollectionView.frame.origin.y, self.frame.size.width - _menuTitleCollectionView.frame.origin.x - _menuTitleCollectionView.frame.size.width, self.frame.size.height);
            
        }
        
        // 设置menuView默认选中
        NSIndexPath *defaultSelectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [_menuTitleCollectionView selectItemAtIndexPath:defaultSelectedIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        [_menuTitleCollectionView.delegate collectionView:_menuTitleCollectionView didSelectItemAtIndexPath:defaultSelectedIndexPath];
        
    }
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _menuCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JXLMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menu" forIndexPath:indexPath];
    
    cell.titleColor = self.titleColor;
    cell.titleSelectedColor = self.titleSelectedColor;
    
    cell.menuTitleLabel.text = [self.delegate menuView:self titleOfRow:indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![_selectedIndexPath isEqual:indexPath]) {
        
        if (self.centerView != nil) {
            [_centerView removeFromSuperview];
            _centerView = nil;
        }
        
        UIView *centerView = self.centerViewArray[indexPath.item];
        if (centerView.frame.size.width != _menuWith) {
            centerView.frame = CGRectMake(_menuTitleCollectionView.frame.origin.x + _menuTitleCollectionView.frame.size.width, _menuTitleCollectionView.frame.origin.y, self.frame.size.width - _menuTitleCollectionView.frame.origin.x - _menuTitleCollectionView.frame.size.width, self.frame.size.height);
        }
        [self addSubview:centerView];
        _centerView = centerView;
        
        
        if ([self.delegate respondsToSelector:@selector(menuView:didSelectRowAtIndex:)]) {
            [self.delegate menuView:self didSelectRowAtIndex:indexPath.item];
        }
        self.selectedIndexPath = indexPath;
    }
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(menuView:heightForRow:)]) {
        return CGSizeMake(collectionView.frame.size.width, [self.delegate menuView:self heightForRow:indexPath.item]);
    }
    return CGSizeMake(_menuWith, 65.f);

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
