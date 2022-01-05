//
//  ViewController.m
//  DouglasPeuckerDemo
//
//  Created by Levi on 2022/1/4.
//

#import "ViewController.h"
#import "DrawView.h"
#import "DataApproximator.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;

@property (nonatomic, strong) NSArray *points;

@property (nonatomic, strong) DrawView *drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drawView.points = self.points;
    [self.view addSubview:self.drawView];
}

- (IBAction)slidersValueChanged:(id)sender {
    DataApproximator *tool = [[DataApproximator alloc] init];
    self.drawView.points = [tool reduceWithDouglasPeuker:self.points tolerance:(CGFloat)_slider.value];
    [self.drawView setNeedsDisplay];
    
    self.explainLabel.text = [NSString stringWithFormat:@"阈值:%ld 当前%ld个点",(NSInteger)_slider.value, self.drawView.points.count];
}

- (NSArray *)points
{
    if (_points == nil) {
        NSMutableArray *values = [[NSMutableArray alloc] init];
        CGFloat spaceX = (self.view.frame.size.width - 40) / 9;
        for (int i = 0; i < 10; i++)
        {
            double y = arc4random_uniform(101);
            double x = 20 + spaceX * i;
            [values addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        }
        _points = values;
    }
    return _points;
}

- (DrawView *)drawView
{
    if (_drawView == nil) {
        _drawView = [[DrawView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
        _drawView.backgroundColor = [UIColor whiteColor];
    }
    return _drawView;
}

@end
