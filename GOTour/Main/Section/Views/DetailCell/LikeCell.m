//
//  LikeCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/4.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "LikeCell.h"
#import "TLIconBut.h"
#import "LikeUserModel.h"

#define kIconWidth 30
@interface LikeCell()

@end
@implementation LikeCell

///activity_btnUnLike.png 空心白
//activity_btnLike.png 实心红心
//activity_btnUnLike_red.png 空心红
+ (instancetype)createLikeCellWithLikeUser:(NSArray *)array
{
    LikeCell *cell = [[LikeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.likeUserArray = array;
    
    ImageTextBut *but = [ImageTextBut createButWithImage:[UIImage imageNamed:@"activity_btnUnLike_red.png"] title:[NSString stringWithFormat:@"%lu",(unsigned long)array.count] frame:CGRectMake(0, 0, 40, 40) scale:0.8];
    [cell addSubview:but];
    
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton *but = [[UIButton alloc]init];
        [self addSubview:but];
        _moreBut = but;
        [_moreBut setImage:[UIImage imageNamed:@"activity_moreP.png"] forState:UIControlStateNormal];
        [_moreBut addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
        
    
    }
    return self;
}

-(void)setLikeUserArray:(NSArray *)likeUserArray
{
    
    _likeUserArray = likeUserArray;
    if (likeUserArray.count != 0) {
        
     NSInteger count = (kScreenWidth - 50)/35 + 1;
    _likeBut.tintColor = [UIColor blackColor];
    if (likeUserArray.count >= count-1 ) {
        
        int i = count - 1;
       
        for (int j = 0 ; j < i - 1 ; j++) {
            
            LikeUserModel *model = likeUserArray[j];
           
 
            CGRect frame = CGRectMake(50+35*j, 5, kIconWidth, kIconWidth);
            TLIconBut *but = [TLIconBut createIconButWithModel:model frame:frame];
            
            [self addSubview:but];
        }
        
        _moreBut.frame = CGRectMake(50+(count - 2)*35, 5, kIconWidth, kIconWidth);
        
    }else{
    
        for (int i = 0; i < _likeUserArray.count; i++) {
            
            LikeUserModel *model = likeUserArray[i];
            
            CGRect frame = CGRectMake(50+35*i, 5, kIconWidth, kIconWidth);
            
            TLIconBut *but = [TLIconBut createIconButWithModel:model frame:frame];
            
            [self addSubview:but];

        }
    
        _moreBut.frame = CGRectMake(50+(_likeUserArray.count)*35, 5, kIconWidth, kIconWidth);
    }

    }
}

- (void)moreAction
{
    
    _moreBlock();
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
