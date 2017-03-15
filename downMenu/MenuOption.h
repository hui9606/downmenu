//
//  MenuOption.h

//

#import <UIKit/UIKit.h>

@interface MenuOption : UIButton//这个继承于uiview 

@property(nonatomic,strong) NSArray *contentArray;

@property(nonatomic,strong) UIView *contentView;

+(MenuOption*)menu;
-(void)showFromBottom;
-(void)showFromView:(UIView *)fromView;
-(void)showTableViewMenuFrom:(UIView *)fromView;
@end
