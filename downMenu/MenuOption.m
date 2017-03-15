//
//  MenuOption.m

#define screenH [UIScreen mainScreen].bounds.size.height
#define screenW [UIScreen mainScreen].bounds.size.width
#define rowH 35
#import "MenuOption.h"
#import "UIView+Extension.h"
@interface MenuOption ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign) CGRect rect;
@property(nonatomic,weak ) UITableView *tableView;
@end

@implementation MenuOption
static NSString *identifier=@"menuCell";

//self  指的就是外面的蒙板
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.2];
      //  self.backgroundColor=[UIColor redColor];
        [self addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
    
}
+(MenuOption*)menu{
    return  [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
}

-(void)setContentView:(UIView *)contentView{
    
    _contentView=contentView;
    [self addSubview:contentView];
}
//从底部 动画出现
-(void)showFromBottom{
    
    UIWindow *window= [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.contentView.frame=CGRectMake(0, screenH-self.contentView.height, screenW,self.contentView.height);
    }];

    
}
-(void)showFromView:(UIView *)fromView{
    
     UIWindow *window= [UIApplication sharedApplication].keyWindow;
    //转换坐标 矫正显示内容的位置
    _rect= [fromView convertRect:fromView.bounds toView:window];
    self.contentView.y=_rect.origin.y+fromView.height;
    [window addSubview:self];
    
}


-(void)hidden{
    
    [self removeFromSuperview];
}

-(void)showTableViewMenuFrom:(UIView *)fromView{
    
    UIWindow *window= [UIApplication sharedApplication].keyWindow;
     [window addSubview:self];
    
    //确定位置
   _rect= [fromView convertRect:fromView.bounds toView:window];
    UITableView  *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(_rect), fromView.width, 0)];
   [self addSubview:tableView];
    
    
    tableView.delegate=self;
    tableView.dataSource=self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    tableView.rowHeight=rowH;
    _tableView=tableView;

    [UIView animateWithDuration:0.25 animations:^{
  
        tableView.frame=CGRectMake(0, CGRectGetMaxY(_rect), fromView.width, rowH*_contentArray.count);
    }];
  
}

-(void)dissmiss{
    
    [UIView animateWithDuration:0.25 animations:^{
        _tableView.frame=CGRectMake(0, CGRectGetMaxY(_rect), _rect.size.width, 0);}];
       
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self  removeFromSuperview];
    });
    
}

#pragma  mark - tableView delegate and dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
 
    cell.textLabel.text=self.contentArray[indexPath.row];
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //通知要用带参数的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"menuOptionNotification" object:nil userInfo:@{@"selectedIndex":@(indexPath.row)}];
   [self dissmiss];

}

@end
