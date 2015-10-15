//
//  TitleLbl.m
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TitleLbl.h"

@implementation TitleLbl

+ (instancetype)createLblWithFrame:(CGRect)frame title:(NSString *)title
{
    TitleLbl *lbl = [[TitleLbl alloc]initWithFrame:frame];
    
    lbl.title = title;
    return lbl;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.textAlignment = NSTextAlignmentLeft;
        self.font = [UIFont systemFontOfSize:13];
    }

    return self;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
    NSMutableAttributedString *attributeStr1 = [[NSMutableAttributedString alloc] initWithString:@"发现 "];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    attachment.bounds = CGRectMake(2, 2, 5,5);
    attachment.image = [UIImage imageNamed:@"activity_poin.png"];
   NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attachment];
    //
    NSAttributedString *attributeStr2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@",title]];
    [attributeStr1 appendAttributedString:imageStr];
    [attributeStr1 appendAttributedString:attributeStr2];
    
    self.attributedText = attributeStr1;
    

}
@end
