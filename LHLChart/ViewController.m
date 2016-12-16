//
//  ViewController.m
//  LHLChart
//
//  Created by Henly on 2016/12/6.
//  Copyright © 2016年 Henly. All rights reserved.
//

#import "ViewController.h"
#import "LHLChart-Bridging-Header.h"

@interface CubicLineSampleFillFormatter : NSObject <IChartFillFormatter>
{
}
@end

@implementation CubicLineSampleFillFormatter

- (CGFloat)getFillLinePositionWithDataSet:(LineChartDataSet *)dataSet dataProvider:(id<LineChartDataProvider>)dataProvider
{
    return 0;
}

@end


@interface ViewController ()<ChartViewDelegate>
{
    LineChartView *lineView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.184 green:1.000 blue:0.738 alpha:1.000];
    lineView = [[LineChartView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height / 3.0f,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 3.0)];
    lineView.backgroundColor = [UIColor colorWithRed:0.184 green:1.000 blue:0.738 alpha:1.000];
    [self.view addSubview:lineView];
    
    lineView.dragEnabled = YES;//是否拖拽，
    lineView.drawGridBackgroundEnabled = NO;//绘制网格背景
    lineView.scaleXEnabled = NO;
    lineView.pinchZoomEnabled = NO;
    lineView.descriptionText = @"每月收入支出图";
    //X轴设置
    ChartXAxis *xAxis = lineView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBothSided;//X轴样式
    xAxis.drawLabelsEnabled = YES;//X轴是否需要绘制文字
    xAxis.drawAxisLineEnabled = YES;//X轴绘制
    xAxis.drawGridLinesEnabled = NO;//X轴网格绘制
    xAxis.axisLineWidth = 0.4f;//数轴宽度
    [xAxis setLabelCount:10 force:NO];//X轴数量一般默认是6个
    
    //Y轴设置
    ChartYAxis *yAxis = lineView.leftAxis;
    yAxis.spaceTop = .5f;//Y轴顶部的最大值的百分比
    yAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    [yAxis setLabelCount:5 force:NO];//Y轴坐标个数
    yAxis.labelTextColor = [UIColor blackColor];//Y轴坐标文字颜色
    yAxis.labelPosition = YAxisLabelPositionInsideChart;
    yAxis.drawGridLinesEnabled = NO;//Y轴网格
    yAxis.axisLineColor = UIColor.blackColor;
    
    lineView.rightAxis.enabled = NO;
    
    int count = 30;
    double range = 10;
    [self setDataCount:count range:range];
    
    [lineView animateWithXAxisDuration:3 yAxisDuration:3];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 设置数据

 
 */
- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *yDataValu = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *yDataValu2 = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i ++) {
        double value = arc4random() % (int)range;
        [yDataValu addObject:[[ChartDataEntry alloc] initWithX:i y:value]];
    }
    
    for (int j = 0; j< count; j ++) {
        double value = arc4random() % (int)range;
        [yDataValu2 addObject:[[ChartDataEntry alloc] initWithX:j y:value]];

    }
    
    
    LineChartDataSet *setChart = nil,*setChart2 = nil;
    if (lineView.data.dataSetCount > 0) {
        
        setChart = (LineChartDataSet *)lineView.data.dataSets[0];
        setChart.values = yDataValu;
        [lineView.data notifyDataChanged];
        [lineView notifyDataSetChanged];

    }else
    {
        setChart = [[LineChartDataSet alloc] initWithValues:yDataValu label:@"收入"];
        setChart.mode = LineChartModeCubicBezier;
        setChart.cubicIntensity = 0.2;
        setChart.drawCirclesEnabled = NO;
        setChart.lineWidth = 1.8;
        setChart.circleRadius = 10.0;
        [setChart setCircleColor:UIColor.whiteColor];
        setChart.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        [setChart setColor:UIColor.whiteColor];
        setChart.fillColor = UIColor.whiteColor;
        setChart.fillAlpha = 1.f;
        setChart.drawHorizontalHighlightIndicatorEnabled = NO;
        setChart.fillFormatter = [[CubicLineSampleFillFormatter alloc] init];
        
        setChart2 = [[LineChartDataSet alloc] initWithValues:yDataValu2 label:@"支出"];
        setChart2.mode = LineChartModeCubicBezier;
        setChart2.cubicIntensity = 0.2;
        setChart2.drawCirclesEnabled = NO;
        setChart2.lineWidth = 1.8;
        setChart2.circleRadius = 10.0;
        [setChart2 setCircleColor:UIColor.redColor];
        setChart2.highlightColor = [UIColor colorWithRed:1/255.f green:1/255.f blue:1/255.f alpha:1.f];
        [setChart2 setColor:UIColor.redColor];
        setChart2.fillColor = UIColor.redColor;
        setChart2.fillAlpha = 1.f;
        setChart2.drawHorizontalHighlightIndicatorEnabled = NO;
        setChart2.fillFormatter = [[CubicLineSampleFillFormatter alloc] init];
        
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
        [arr addObject:setChart];
        [arr addObject:setChart2];

        LineChartData *data = [[LineChartData alloc] initWithDataSets:arr];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.f]];
        [data setDrawValues:NO];
        
        lineView.data = data;

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
