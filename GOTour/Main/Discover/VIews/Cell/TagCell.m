//
//  TagCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TagCell.h"

@implementation TagCell

+(instancetype)createCelllWithReusableID:(NSString *)ID tags:(NSArray *)tags  collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    TagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.tagModel = tags[indexPath.row];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        CGFloat w = frame.size.width;
        CGFloat h = frame.size.height;
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w,w)];
        _imageView.layer.cornerRadius = w/2;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        
        CGFloat y = CGRectGetMaxY(_imageView.frame);
        _textLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, y, w, h-y)];
        _textLbl.textAlignment = NSTextAlignmentCenter;
        _textLbl.font = [UIFont systemFontOfSize:13];
        [self addSubview:_textLbl];
    }
    return self;
}
-(void)setTagModel:(TagModel *)tagModel
{
    _tagModel = tagModel;
    _textLbl.text = tagModel.name;
    
    NSURL *url = [NSURL URLWithString:tagModel.icon];
    [_imageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
}
@end
