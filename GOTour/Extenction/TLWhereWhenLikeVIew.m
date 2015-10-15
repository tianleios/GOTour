//
//  TLWhereWhenLikeVIew.m
//  旅行
//
//  Created by 磊 田 on 15/10/5.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TLWhereWhenLikeVIew.h"
@interface TLWhereWhenLikeVIew()

@property (nonatomic, strong) UILabel *lbl;
@end

@implementation TLWhereWhenLikeVIew

-(void)setSelectM:(SelectModel *)selectM
{
    _selectM  = selectM;
    self.lbl.frame = self.bounds;
    NSString *likecount = [_selectM.like_count stringValue];
    
    if (_style == TLWhereStyle) {
          self.lbl.textAlignment = NSTextAlignmentLeft;
        _lbl.textColor = [UIColor blackColor];
        
        NSTextAttachment *attachment2 = [[NSTextAttachment alloc]init];
        attachment2.image = [UIImage imageNamed:@"activity_location.png"];
        attachment2.bounds = CGRectMake(0, 0, 10, 10);
        
        NSAttributedString *locationS = [NSAttributedString attributedStringWithAttachment:attachment2];
        
         NSAttributedString *adress = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@",_selectM.destination]];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
        [str appendAttributedString:locationS];
        [str appendAttributedString:adress];
        self.lbl.attributedText = str;
        return;
        
    }
    
    if (_style == TLWhereLikeStyle) {
        
        

        self.lbl.textAlignment = NSTextAlignmentRight;
        
        NSTextAttachment *attachment1 = [[NSTextAttachment alloc]init];
        attachment1.image = [UIImage imageNamed:@"activity_btnLike.png"];
        attachment1.bounds = CGRectMake(5, -4.5, 18, 18);
        
        NSTextAttachment *attachment2 = [[NSTextAttachment alloc]init];
        attachment2.image = [UIImage imageNamed:@"activity_location.png"];
        attachment2.bounds = CGRectMake(0, 0, 10, 10);

        NSAttributedString *imageStr1 = [NSAttributedString attributedStringWithAttachment:attachment1];
        NSAttributedString *imageStr2 = [NSAttributedString attributedStringWithAttachment:attachment2];
        
         NSAttributedString *like = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@  ",likecount]];
        NSAttributedString *adress = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",_selectM.destination]];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithAttributedString:imageStr1];
        [str appendAttributedString:like];
        [str appendAttributedString:imageStr2];
        [str appendAttributedString:adress];
        self.lbl.attributedText = str;
           
    }else{
         _lbl.textColor = [UIColor whiteColor];
        self.lbl.textAlignment = NSTextAlignmentLeft;
        NSString *str1 = [self dateString:_selectM.start_date];
        NSString *str2 = [self dateString:_selectM.end_date];
        NSString *timeString = [NSString stringWithFormat:@"%@-%@",str1,str2];
    
        NSTextAttachment *attachment1 = [[NSTextAttachment alloc]init];
        attachment1.image = [UIImage imageNamed:@"activity_time.png"];
        attachment1.bounds = CGRectMake(0, -1, 10,10);

        NSTextAttachment *attachment2 = [[NSTextAttachment alloc]init];
        attachment2.image = [UIImage imageNamed:@"activity_location.png"];
        attachment2.bounds = CGRectMake(0, -1, 10, 10);

        NSAttributedString *imageStr1 = [NSAttributedString attributedStringWithAttachment:attachment1];
        NSAttributedString *imageStr2 = [NSAttributedString attributedStringWithAttachment:attachment2];
        
        NSAttributedString *time = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@  ",timeString]];
        NSAttributedString *adress = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",_selectM.destination]];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithAttributedString:imageStr2];
        
        [str appendAttributedString:adress];
        [str appendAttributedString:imageStr1];
        [str appendAttributedString:time];
        
        self.lbl.attributedText = str;
     
    }

   
}
-(NSString *)dateString:(NSString *)str
{
    //开始时间
    NSDate *date =nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    结束日期：2015-12-31
    [formatter setDateFormat:@"yyyy-MM-dd"];
    date = [formatter dateFromString:str];
    [formatter setDateFormat:@"M月d日"];
    NSString *string = [formatter stringFromDate:date];
    return string;

}
- (instancetype)init
{
    self = [super init];
    if (self) {

        _lbl = [[UILabel alloc]init];

        [self addSubview:_lbl];
       
        _lbl.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
