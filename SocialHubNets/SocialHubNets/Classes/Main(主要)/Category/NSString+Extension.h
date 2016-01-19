
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)
/**
 *  返回字符串所占用的尺寸 来设置动态的宽/高
 *
 *  @param font    字体
 *  @param maxSize 限制的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
