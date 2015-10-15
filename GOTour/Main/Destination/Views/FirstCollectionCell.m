//
//  FirstCollectionCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "FirstCollectionCell.h"

@interface FirstCollectionCell()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *lbl;


@end
@implementation FirstCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageV = [[UIImageView alloc] init];
        [self addSubview:_imageV];
        
        _imageV.layer.cornerRadius = kMargin;
        _imageV.layer.masksToBounds = YES;
        
        _lbl = [[UILabel alloc] init];
        [self addSubview:_lbl];
        _lbl.textAlignment = NSTextAlignmentLeft;
        _lbl.textColor = [UIColor whiteColor];
        _lbl.font = [UIFont boldSystemFontOfSize:20];
        
    }
    return self;
}

- (void)setFirstDM:(FirstDestionModel *)firstDM
{
    _firstDM = firstDM;
    _imageV.frame = self.bounds;
    NSURL *url = [NSURL URLWithString:_firstDM.bg_pic];

    [_imageV sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"] ];
    
    _lbl.frame = CGRectMake(2*kMargin, self.bounds.size.height *4/5, self.bounds.size.width - 2*kMargin ,  self.bounds.size.height /5);
    _lbl.text = _firstDM.name;
    
}
@end
