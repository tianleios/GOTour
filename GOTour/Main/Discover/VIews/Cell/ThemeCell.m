//
//  ThemeCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "ThemeCell.h"

@implementation ThemeCell

+(instancetype)createCelllWithReusableID:(NSString *)ID collections:(NSArray *)collections collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    ThemeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.collectionModel = collections[indexPath.row];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w = frame.size.width;
        CGFloat h = frame.size.height;
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.layer.cornerRadius = 2*kMargin;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        
        
        _textLbl = [[UILabel alloc]initWithFrame:CGRectMake(2*kMargin,h/3, w-4*kMargin, h/3)];
        _textLbl.textAlignment = NSTextAlignmentCenter;
        _textLbl.font = [UIFont boldSystemFontOfSize:23];
        _textLbl.textColor = [UIColor whiteColor];
         _textLbl.numberOfLines = 0;
        [self addSubview:_textLbl];
    }
    return self;
}
-(void)setCollectionModel:(CollectionModel *)collectionModel
{
    _collectionModel = collectionModel;
    if ([_collectionModel.title_notshown  isEqual: @0] || _collectionModel.title.length != 0 ) {
        
        _textLbl.text = _collectionModel.title;
    }
    _urlString = _collectionModel.url;
    NSURL *url = [NSURL URLWithString:_collectionModel.bg_pic[0]];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
}

@end
