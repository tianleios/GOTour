//
//  NextCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "NextCell.h"

@implementation NextCell

+(instancetype)createCelllWithReusableID:(NSString *)ID tags:(NSArray *)tags  collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    NextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.nextModel = tags[indexPath.row];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w = frame.size.width;
        CGFloat h = frame.size.height;
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.layer.cornerRadius = kMargin;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        
      
        _textLbl = [[UILabel alloc]initWithFrame:CGRectMake(2*kMargin,h/5, w-4*kMargin, h*0.6)];
        _textLbl.textAlignment = NSTextAlignmentCenter;
        _textLbl.font = [UIFont boldSystemFontOfSize:20];
        _textLbl.textColor = [UIColor whiteColor];
        [self addSubview:_textLbl];
    }
    return self;
}
-(void)setNextModel:(NextModel *)nextModel
{
    _nextModel = nextModel;
    _textLbl.text = _nextModel.title;
    _textLbl.numberOfLines = 0;
    NSURL *url = [NSURL URLWithString:_nextModel.bg_pic];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_imageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
}

@end
