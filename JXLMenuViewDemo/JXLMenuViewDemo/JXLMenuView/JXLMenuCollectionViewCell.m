    //
//  XLMenuCollectionViewCell.m
//  Food
//
//  Created by Eiwodetianna on 9/6/15.
//  Copyright © 2015 jinxinliang. All rights reserved.
//

#import "JXLMenuCollectionViewCell.h"

@interface JXLMenuCollectionViewCell ()

@property (nonatomic, strong) UIView *selectedMarkView;



@end

@implementation JXLMenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _menuTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _menuTitleLabel.text = @"";
        _menuTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_menuTitleLabel];
        
        _selectedMarkView = [[UIView alloc] initWithFrame:CGRectZero];
        _selectedMarkView.backgroundColor = [UIColor colorWithRed:249.f / 255.f green:82.f / 255.f blue:30.f / 255.f alpha:1.0f];
        _selectedMarkView.hidden = YES;
        [self.contentView addSubview:_selectedMarkView];
        
        self.contentView.layer.borderWidth = 0.5f;

        
        
        
    }
    return self;

}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    _selectedMarkView.frame = CGRectMake(0, 0, 5, self.contentView.frame.size.height);
    _menuTitleLabel.frame = self.contentView.frame;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _menuTitleLabel.textColor = titleColor;
    self.contentView.layer.borderColor = self.titleColor.CGColor;
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    _titleSelectedColor = titleSelectedColor;
    if (self.isSelected) {
        _menuTitleLabel.textColor = _titleSelectedColor;
    }
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    _selectedMarkView.hidden = !selected;
    self.menuTitleLabel.textColor = selected ? self.titleSelectedColor : self.titleColor;
}


@end
