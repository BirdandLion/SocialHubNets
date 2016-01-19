//
//  GPTextView.m
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPTextView.h"

@interface GPTextView()<UITextViewDelegate>

@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation GPTextView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UILabel *placeholder = [[UILabel alloc] init];
        [self addSubview:placeholder];
        placeholder.numberOfLines = 0;
        self.placeholderLabel = placeholder;
        
        // 设置默认的占位符颜色
        placeholder.textColor = [UIColor lightGrayColor];
        
        // 设置默认的字体
        self.font = [UIFont systemFontOfSize:17];
        
#warning 不要设置自己的代理为自己本身
//        self.delegate = self;
        /*
         监听控件的时间
         1. delegate
         2. addTarget(UIControl)
         3. 通知
         */
        // 当self的文字改变,self就会自动发出该通知. 一旦发出下面的通知,就会调用self的textDidChange. 当用户通过键盘修改文字才会发出
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
#warning 如果是copy策略,最好这样写
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    
    // 重新计算子空间frame (不要直接调用layoutSubviews)
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    
    // 重新计算子空间frame (不要直接调用layoutSubviews)
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLabel.x = 5;
    self.placeholderLabel.y = 7;
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    CGSize maxSize = CGSizeMake(self.placeholderLabel.width, MAXFLOAT);
    NSDictionary *attr = @{NSFontAttributeName: self.placeholderLabel.font};
    CGSize placeholderSize = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    self.placeholderLabel.height = placeholderSize.height;

}

#pragma mark - UITextViewTextDidChangeNotification

- (void)textDidChange
{
    // 有文字,隐藏占位label
    self.placeholderLabel.hidden = (self.attributedText.length != 0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//#pragma mark - UITextViewDelegate
//
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    NSLog(@"textViewDidBeginEditing");
//}
//
//- (void)textViewDidChange:(UITextView *)textView
//{
//    NSLog(@"textViewDidChange");
//}
//
//- (void)textViewDidChangeSelection:(UITextView *)textView
//{
//    NSLog(@"textViewDidChangeSelection");
//}

@end
