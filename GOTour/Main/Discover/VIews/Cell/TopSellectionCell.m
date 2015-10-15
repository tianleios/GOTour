//
//  TopSellectionCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TopSellectionCell.h"

@implementation TopSellectionCell

+(instancetype)createCelllWithReusableID:(NSString *)ID topSellections:(NSArray *)topSellections collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    TopSellectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.topModel = topSellections[indexPath.row];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w = frame.size.width;
        CGFloat h = frame.size.height;
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, h*1.4, h)];
        _imageView.layer.cornerRadius = 2*kMargin;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        
        //小标题
        CGFloat ivX = CGRectGetMaxX(_imageView.frame);
        CGFloat subTitleX = ivX + 2*kMargin;
        
        _subTextLbl = [[UILabel alloc] initWithFrame:CGRectMake(subTitleX, 2*kMargin, kScreenWidth - subTitleX, 4*kMargin)];
//        _subTextLbl.backgroundColor = [UIColor redColor];
        _subTextLbl.textAlignment = NSTextAlignmentLeft;
        _subTextLbl.font = [UIFont systemFontOfSize:13];
        [self addSubview:_subTextLbl];
        //
        CGFloat textLblY = CGRectGetMaxY(_subTextLbl.frame);
        _textLbl = [[UILabel alloc]initWithFrame:CGRectMake(subTitleX,textLblY, w-subTitleX , (h- textLblY)/1.5)];
        _textLbl.textAlignment = NSTextAlignmentLeft;
        _textLbl.font = [UIFont systemFontOfSize:15];
        _textLbl.textColor = [UIColor blackColor];
        _textLbl.numberOfLines = 2;
//        _textLbl.backgroundColor = [UIColor cyanColor];
        [self addSubview:_textLbl];
    }
    return self;
}
-(void)setTopModel:(TopSelectionModel *)topModel
{
    _topModel = topModel;
    SelectionModel *selectionM = _topModel.selection;
    
    NSURL *url = [NSURL URLWithString:selectionM.bg_pic];
    [_imageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
    //浏览数
    [self attributeString];
       //
    NSMutableString *str1 = [selectionM.title mutableCopy];
    [str1 appendString:[NSString stringWithFormat:@" - %@",selectionM.sub_title]];
    _textLbl.text = str1;
}
-(void)attributeString
{
    NSNumber *precent = _topModel.hotness;
    NSString *subText = [NSString stringWithFormat:@"%@%%的小伙伴浏览了",precent];
    

    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:subText];
//    NSForegroundColorAttributeName
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
    _subTextLbl.attributedText = attributeStr;
}

@end
