//
//  ImageCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "ImageCell.h"
#import "DetailCellFrame.h"
#import "DetailModel.h"
#import "ContentModel.h"
#import "PhotoView.h"
@implementation ImageCell
{
    UIImageView *_imageV;
    PhotoView *_photo;

}

+ (instancetype)createCellWith:(UITableView *)tableView
{
    static NSString *ID = @"imageCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[ImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//         self.selectionStyle = UITableViewCellSelectionStyleNone;
//        _imageV = [[UIImageView alloc]init];
//        [self.contentView addSubview:_imageV];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _photo = [[PhotoView alloc]init];
        [self addSubview:_photo];
    }
    return self;
}

-(void)setFrameM:(DetailCellFrame *)frameM
{
    _frameM = frameM;
    
//    _imageV.frame = frameM.imageFrame;
//    NSURL *url = [NSURL URLWithString:_frameM.detailM.content.url];
//    [_imageV sd_setImageWithURL:url   placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
    _photo.frame = frameM.imageFrame;
    _photo.imageUrls = self.imageUrls;
    _photo.urlStr = _frameM.detailM.content.url;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
