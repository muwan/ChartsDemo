# ChartsDemo使用
Charts是一套非常漂亮的开源图表组件，它是MPAndroidChart在苹果端的移植版本，同时支持iOS/tvOS/OSX平台。
同时，Charts是用 Swift 语言编写的，能够在 Swift 和 Objc 工程中使用。
这个Demo是一个简单的集成，使用了LineChartView，画两个曲线图。

可以在[我的博客](https://luholi.xyz/2016/12/06/Xcode8-Uses-Charts-Objective-C/)查看具体步骤

## 主要代码：
```Objective-C
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
```
![应用截图](https://luholi.xyz/img/SimulatorScreenShot20161216.png)
