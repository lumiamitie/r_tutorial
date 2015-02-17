#### ggplot2 #####################
library(gcookbook)
library(ggplot2)


####### 데이터 살펴보기 #############
#### 산점도
    plot(mtcars$wt, mtcars$mpg)
    # plot함수, x값의 벡터와 y값의 벡터를 인자로 받는다
    
    qplot(mtcars$wt, mtcars$mpg)
    qplot(wt, mpg, data=mtcars)
    ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()
    # 세개가 동일하다

#### 선 그래프
    plot(pressure$temperature, pressure$pressure, type="l")
    points(pressure$temperature, pressure$pressure)
    
    qplot(pressure$temperature, pressure$pressure, geom="line")
    qplot(temperature, pressure, data= pressure, geom="line")
    ggplot(pressure,aes(x=temperature, y= pressure)) + geom_line()

#### 선그래프 +점
    qplot(temperature, pressure, data= pressure, geom=c("line","point"))
    ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line() + geom_point()


#### 막대그래프
    barplot(BOD$demand, names.arg=BOD$Time)
    # 히스토그램과 비슷하지만 x축이 연속적이지 않고 이산값이다.
    barplot(table(mtcars$cyl))
    
    ### 빈도수 대신 '값' 자체를 가지고 그리려면 geom="bar"와 stat="identity"
    # x값이 이산일 때와 연속일 때의 차이?
    qplot(BOD$Time, BOD$demand, geom="bar", stat = "identity")
    qplot(factor(BOD$Time), BOD$demand, geom="bar", stat = "identity")
    
    # ggplot2에서 막대그래프의 기본 설정은 빈도수이다.
    qplot(mtcars$cyl) #연속
    qplot(factor(mtcars$cyl)) #이산
    
    ### 벡터가 데이터 프레임안에 들어 있을 경우
    # 값 막대그래프
    qplot(Time, demand, data= BOD, geom="bar", stat="identity")
    ggplot(BOD, aes(x=Time, y= demand)) + geom_bar(stat="identity")
    # 빈도수
    qplot(factor(cyl),data = mtcars)
    ggplot(mtcars, aes(x=factor(cyl))) + geom_bar()

#### 히스토그램
    #일차원 데이터의 분포
    hist(mtcars$mpg)
    hist(mtcars$mpg, breaks = 10) # breaks로 대강의 상자(bin) 개수를 지정
    
    qplot(mtcars$mpg)
    qplot(mpg, data=mtcars, binwidth = 4)
    ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth = 4)

#### BoxPlot
    plot(ToothGrowth$supp, ToothGrowth$len)
    
    # 두 벡터가 하나의 데이터 프레임에 들어있을 경우, 다음과 같은 공식형(formula) 문법을 사용할 수 있다.
    boxplot(len ~ supp, data = ToothGrowth)
    boxplot(len ~ supp+dose, data = ToothGrowth) # 두 변수의 상호작용을 x축으로 한다
    
    qplot(ToothGrowth$supp, ToothGrowth$len, geom="boxplot")
    qplot(supp, len, data=ToothGrowth, geom="boxplot") #같은 데이터프레임
    ggplot(ToothGrowth, aes(x=supp, y=len)) + geom_boxplot()
    
    qplot(interaction(ToothGrowth$supp, ToothGrowth$dose), ToothGrowth$len, geom="boxplot")
    ggplot(ToothGrowth, aes(x=interaction(supp, dose), y=len)) + geom_boxplot()

#### 함수 곡선 그리기
    curve(x^3 - 5*x, from=-4, to=4)

    # 사용자 정의 함수를 그래프로 그리기
    myfun = function(xvar){
      1/ (1 + exp(-xvar + 10) )
    }
    curve(myfun(x), from = 0, to = 20)
    curve(1 - myfun(x), add=TRUE, col="red") # 곡선 추가하기
    
    qplot(c(0,20), fun = myfun, stat="function", geom="line")
    ggplot(data.frame(x=c(0,20)), aes(x=x)) + stat_function(fun = myfun, geom="line")


### 그래프 그리기 #################################################################

#### Bar and line Graphs ####
#bar graphs of values

#data: tips from reshape2
    library(reshape2)
    head(tips)

    df <- data.frame(time = factor(c("Lunch","Dinner"), levels=c("Lunch","Dinner")),
                     total_bill = c(14.89, 17.23))
    # stat="bin" vs stat="identity"
    # stat="bin" : the height of each bar equal to the number of cases in each group
    # stat="identity" : the heights of the bars represent values in the data (map values to the y aesthetic)

    # the height of the bar will represent the value in a column of the data frame. This is done by using stat="identity"
    ggplot(data=df, aes(x=time, y=total_bill)) + geom_bar(stat="identity")
    
    # Map the time of day to different fill colors. These both have the same result.
    ggplot(data=df, aes(x=time, y=total_bill, fill=time)) + geom_bar(stat="identity")
    ggplot(data=df, aes(x=time, y=total_bill)) + geom_bar(aes(fill=time), stat="identity")
    
    # Add a black outline
    ggplot(data=df, aes(x=time, y=total_bill, fill=time)) + geom_bar(colour="black", stat="identity")
    
    # No legend, since the information is redundant
    ggplot(data=df, aes(x=time, y=total_bill, fill=time)) +
      geom_bar(colour="black", stat="identity") +
      guides(fill=FALSE)
    
    # desired bar graph?
        # Add title, narrower bars, gray fill, and change axis labels
    ggplot(data=df, aes(x=time, y=total_bill, fill=time)) + 
      geom_bar(colour="black", fill="#DD8888", width=.7, stat="identity") + 
      guides(fill=FALSE) +
      xlab("Time of day") + ylab("Total bill") +
      ggtitle("Average bill for 2 people")
#geom_bar에서 fill이 없어지면 lunch와 dinner가 색상으로 구분됨, fill이 있으면 그 색상으로 통일



#bar graphs of counts
    #the height of the bar will represent the count of cases. This is done by using stat="bin" (which is the default)

  # Bar graph of counts
  ggplot(data=tips, aes(x=day)) + geom_bar(stat="bin")
  # Equivalent to this, since stat="bin" is the default:
  ggplot(data=tips, aes(x=day)) + geom_bar()




# line graph
    # For line graphs, the data points must be grouped so that it knows which points to connect. 
    # In this case, it is simple -- all points should be connected, so group=1. 
    # When more variables are used and multiple lines are drawn, 
    # the grouping for lines is usually done by variable (this is seen in later examples)

    # Basic line graph. These both have the same result.
    ggplot(data=df, aes(x=time, y=total_bill, group=1)) + geom_line()
    ggplot(data=df, aes(x=time, y=total_bill)) + geom_line(aes(group=1))
    # 그룹 지정을 안해주면 두 개의 그룹에 데이터가 한 개씩만 있는 것으로 인식해서 선을 그려주지 않는다
    
    # Add points
    ggplot(data=df, aes(x=time, y=total_bill, group=1)) + geom_line() + geom_point()
    
    
    # Change color of both line and points
    # Change line type and point type, and use thicker line and larger points
    # Change points to circles with white fill
    ggplot(data=df, aes(x=time, y=total_bill, group=1)) + 
      geom_line(colour="red", linetype="dotted", size=1.5) + 
      geom_point(colour="red", size=4, shape=21, fill="white")
    
    # desired line graph?
        # Change the y-range to go from 0 to the maximum value in the total_bill column,
        # and change axis labels
    ggplot(data=df, aes(x=time, y=total_bill, group=1)) + geom_line() + geom_point() +
      ylim(0, max(df$total_bill)) +
      xlab("Time of day") + ylab("Total bill") +
      ggtitle("Average bill for 2 people")




#graphs with more variables
df1 <- data.frame(sex       = factor(c("Female","Female","Male","Male")),
                  time       = factor(c("Lunch","Dinner","Lunch","Dinner"), levels=c("Lunch","Dinner")),
                  total_bill = c(13.53, 16.81, 16.24, 17.42))


# bar graph
    # Stacked bar graph -- this is probably not what you want
    ggplot(data=df1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity")
    
    # Bar graph, time on x-axis, color fill grouped by sex -- use position_dodge()
    ggplot(data=df1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity", position=position_dodge())
    ggplot(data=df1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity", position=position_dodge(), colour="black")
    
    # Change colors
    ggplot(data=df1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity", position=position_dodge(), colour="black") +
      scale_fill_manual(values=c("#999999", "#E69F00"))
    
    # Bar graph, time on x-axis, color fill grouped by sex -- use position_dodge()
    ggplot(data=df1, aes(x=sex, y=total_bill, fill=time)) + geom_bar(stat="identity", position=position_dodge(), colour="black")


# line graph
    # Basic line graph with points
    ggplot(data=df1, aes(x=time, y=total_bill, group=sex)) + geom_line() + geom_point()
    
    # Map sex to color
    ggplot(data=df1, aes(x=time, y=total_bill, group=sex, colour=sex)) + geom_line() + geom_point()
    
    # Map sex to different point shape, and use larger points
    ggplot(data=df1, aes(x=time, y=total_bill, group=sex, shape=sex)) + geom_line() + geom_point()
    
    
    # Use thicker lines and larger points, and hollow white-filled points
    ggplot(data=df1, aes(x=time, y=total_bill, group=sex, shape=sex)) + 
      geom_line(size=1.5) + 
      geom_point(size=3, fill="white") +
      scale_shape_manual(values=c(22,21))
    
    # It is easy to change which variable is mapped the x-axis and which is mapped to the color or shape
    ggplot(data=df1, aes(x=sex, y=total_bill, group=time, shape=time, color=time)) + geom_line() + geom_point()



# finished example
# A bar graph
ggplot(data=df1, aes(x=time, y=total_bill, fill=sex)) + 
  geom_bar(colour="black", stat="identity",
           position=position_dodge(),
           size=.3) +                        # Thinner lines
  scale_fill_hue(name="Sex of payer") +      # Set legend title
  xlab("Time of day") + ylab("Total bill") + # Set axis labels
  ggtitle("Average bill for 2 people") +  # Set title
  theme_bw()


# A line graph
ggplot(data=df1, aes(x=time, y=total_bill, group=sex, shape=sex, colour=sex)) + 
  geom_line(aes(linetype=sex), size=1) +     # Set linetype by sex
  geom_point(size=3, fill="white") +         # Use larger points, fill with white
  ylim(0, max(df1$total_bill)) +             # Set y range
  scale_colour_hue(name="Sex of payer",      # Set legend title
                   l=30)  +                  # Use darker colors (lightness=30)
  scale_shape_manual(name="Sex of payer",
                     values=c(22,21)) +      # Use points with a fill color
  scale_linetype_discrete(name="Sex of payer") +
  xlab("Time of day") + ylab("Total bill") + # Set axis labels
  ggtitle("Average bill for 2 people") +  # Set title
  theme_bw() +
  theme(legend.position=c(.7, .4)) # Position legend inside


# with a numeric axis
    # When the variable on the x-axis is numeric, it is sometimes useful to treat it as continuous, and sometimes useful to treat it as categorical. 
    # In this data set, the dose is a numeric variable with values 0.5, 1.0, and 2.0. 
    # It might be useful to treat these values as equal categories when making a graph.
dfn <- read.table(header=T, text='
  supp dose length
    OJ  0.5  13.23
    OJ  1.0  22.70
    OJ  2.0  26.06
    VC  0.5   7.98
    VC  1.0  16.77
    VC  2.0  26.14
    ')

  # A simple graph might put dose on the x-axis as a numeric value.
  ggplot(data=dfn, aes(x=dose, y=length, group=supp, colour=supp)) + geom_line() + geom_point()
  # dose 항목이 numeric으로 되어있기 때문에 존재하지 않는 1.5가 존재한다

    # If you wish to treat it as a categorical variable instead of a numeric one, it must be converted to a factor. 
    # This can be done by modifying the data frame, or by changing the specification of the graph.

    # Copy the data frame and convert dose to a factor
    dfn2 <- dfn
    dfn2$dose <- factor(dfn2$dose)
    ggplot(data=dfn2, aes(x=dose, y=length, group=supp, colour=supp)) + geom_line() + geom_point()
    # dose 변수에는 0.5, 1, 2만 존재

    # Use the original data frame, but put factor() directly in the plot specification
    ggplot(data=dfn, aes(x=factor(dose), y=length, group=supp, colour=supp)) + geom_line() + geom_point()
    
    # It is also possible to make a bar graph when the variable is treated as categorical rather than numeric.
    
    # Use dfn2 from above
    ggplot(data=dfn2, aes(x=dose, y=length, fill=supp)) + geom_bar(stat="identity", position=position_dodge())
    
    # Use the original data frame, but put factor() directly in the plot specification
    ggplot(data=dfn, aes(x=factor(dose), y=length, fill=supp)) + geom_bar(stat="identity", position=position_dodge())





##### Scatter Plot #####
    set.seed(955)
    # Make some noisily increasing data
    dat <- data.frame(cond = rep(c("A", "B"), each=10),
                      xvar = 1:20 + rnorm(20,sd=3),
                      yvar = 1:20 + rnorm(20,sd=3))
    
    # basic scatter plot with regression lines
    
    ggplot(dat, aes(x=xvar, y=yvar)) +
      geom_point(shape=1)      # Use hollow circles
    
    ggplot(dat, aes(x=xvar, y=yvar)) +
      geom_point(shape=1) +    # Use hollow circles
      geom_smooth(method=lm)   # Add linear regression line 
    #  (by default includes 95% confidence region)
    
    
    ggplot(dat, aes(x=xvar, y=yvar)) +
      geom_point(shape=1) +    # Use hollow circles
      geom_smooth(method=lm,   # Add linear regression line
                  se=FALSE)    # Don't add shaded confidence region
    
    
    ggplot(dat, aes(x=xvar, y=yvar)) +
      geom_point(shape=1) +    # Use hollow circles
      geom_smooth()            # Add a loess smoothed fit curve with confidence region
    
    
    # Set color/shape by another variable
    ggplot(dat, aes(x=xvar, y=yvar, color=cond)) + geom_point(shape=1)
    
    # Same, but with different colors and add regression lines
    ggplot(dat, aes(x=xvar, y=yvar, color=cond)) + geom_point(shape=1) +
      scale_colour_hue(l=50) + # Use a slightly darker palette than normal
      geom_smooth(method=lm,   # Add linear regression lines
                  se=FALSE)    # Don't add shaded confidence region

    #HSL 색상표 : Hue 색조 / Saturation 채도 / Lightness 명도
    
    # Extend the regression lines beyond the domain of the data
    ggplot(dat, aes(x=xvar, y=yvar, color=cond)) + geom_point(shape=1) +
      scale_colour_hue(l=50) + # Use a slightly darker palette than normal
      geom_smooth(method=lm,   # Add linear regression lines
                  se=FALSE,    # Don't add shaded confidence region
                  fullrange=T) # Extend regression lines
    
    
    # Set shape by cond
    ggplot(dat, aes(x=xvar, y=yvar, shape=cond)) + geom_point()
    
    # Same, but with different shapes
    ggplot(dat, aes(x=xvar, y=yvar, shape=cond)) + geom_point() +
      scale_shape_manual(values=c(1,2))  # Use a hollow circle and triangle

## Handling overplotting : jitter
    # Round xvar and yvar to the nearest 5
    dat$xrnd <- round(dat$xvar/5)*5
    dat$yrnd <- round(dat$yvar/5)*5
    
    # Make each dot partially transparent, with 1/4 opacity
    # For heavy overplotting, try using smaller values
    ggplot(dat, aes(x=xrnd, y=yrnd)) +
      geom_point(shape=19,      # Use solid circles
                 alpha=1/4)     # 1/4 opacity
    
    
    # Jitter the points
    # Jitter range is 1 on the x-axis, .5 on the y-axis
    ggplot(dat, aes(x=xrnd, y=yrnd)) +
      geom_point(shape=1,      # Use hollow circles
                 position=position_jitter(width=1,height=.5))


#### Lines ####

## With one continuous and one categorical axis ##
df <- read.table(header=T, text='
     cond result
  control     10
  treatment   11.5
  ')

# Lines that go all the way across #
    # These use geom_hline because the y-axis is the continuous one, 
    # but it is also possible to use geom_vline (with xintercept) if the x-axis is continuous.

# Basic bar plot
  bp <- ggplot(df, aes(x=cond, y=result)) + geom_bar(stat = "identity", position=position_dodge())  
  
  # Add a horizontal line
  bp + geom_hline(aes(yintercept=12))
  
  # Make the line red and dashed
  bp + geom_hline(aes(yintercept=12), colour="#990000", linetype="dashed")

## Separate lines for each categorical value ##
  # Draw separate hlines for each bar. First add another column to df
  df$hline <- c(9,12)
  
  # Need to re-specify bp, because the data has changed
  bp <- ggplot(df, aes(x=cond, y=result)) + geom_bar(stat = "identity", position=position_dodge())
  
  # Draw with separate lines for each bar
  # The error bars have no height -- ymin=ymax
  bp + geom_errorbar(aes(y=hline, ymax=hline, ymin=hline), colour="#AA0000")
  
  # Make the lines narrower
  bp + geom_errorbar(width=0.5, aes(y=hline, ymax=hline, ymin=hline), colour="#AA0000")
  
  
  # Can get the same result, even if we get the hline values from a second data frame
  df.hlines <- data.frame(cond=c("control","treatment"), hline=c(9,12))
  
  # The bar graph are from df, but the lines are from df.hlines
  bp + geom_errorbar(data=df.hlines, aes(y=hline, ymax=hline, ymin=hline), colour="#AA0000")


## Lines over grouped bars ##
  df <- read.table(header=T, text='
       cond group result hline
    control     A     10     9
  treatment     A   11.5    12
  control       B     12     9
  treatment     B     14    12
  ')
  
  # Define basic bar plot
  bp <- ggplot(df, aes(x=cond, y=result, fill=group)) + geom_bar(stat = "identity", position=position_dodge()) 
  
  # The error bars get plotted over one another -- there are four but it looks like two
  bp + geom_errorbar(aes(y=hline, ymax=hline, ymin=hline), linetype="dashed")

## With two continuous axes ##
df <- read.table(header=T, text='
      cond xval yval
   control 11.5 10.8
   control  9.3 12.9
   control  8.0  9.9
   control 11.5 10.1
   control  8.6  8.3
   control  9.9  9.5
   control  8.8  8.7
   control 11.7 10.1
   control  9.7  9.3
   control  9.8 12.0
   treatment 10.4 10.6
   treatment 12.1  8.6
   treatment 11.2 11.0
   treatment 10.0  8.8
   treatment 12.9  9.5
   treatment  9.1 10.0
   treatment 13.4  9.6
   treatment 11.6  9.8
   treatment 11.5  9.8
   treatment 12.0 10.6
   ')

# The basic scatterplot
sp <- ggplot(df, aes(x=xval, y=yval, colour=cond)) + geom_point()

# Add a horizontal line
sp + geom_hline(aes(yintercept=10))

# Add a red dashed vertical line
sp + geom_hline(aes(yintercept=10)) + geom_vline(aes(xintercept=11.5), colour="#BB0000", linetype="dashed")

## Automatically drawing lines for the mean ##
  # Add colored lines for the mean xval of each group
  # Note that the y range of the line is determined by the data.
  sp + geom_hline(aes(yintercept=10)) +
    geom_line(stat="vline", xintercept="mean")

## Using lines with facets ##
  # Normally, if you add a line, it will appear in all facets.
  # Facet, based on cond
  spf <- sp + facet_grid(. ~ cond)
  
  # Draw a horizontal line in all of the facets at the same value
  spf + geom_hline(aes(yintercept=10))

    # If you want the different lines to appear in the different facets, there are two options. 
    # One is to create a new data frame with the desired values for the lines. 
    # Another option (with more limited control) is to use stat and xintercept in geom_line().

  df.vlines <- data.frame(cond=levels(df$cond), xval=c(10,11.5))
  
  spf + geom_hline(aes(yintercept=10)) +
    geom_vline(aes(xintercept=xval), data=df.vlines,
               colour="#990000", linetype="dashed")
  
  
  spf + geom_hline(aes(yintercept=10)) +
    geom_line(stat="vline", xintercept="mean")
 
### Facets ###
library(reshape2)

sp <- ggplot(tips, aes(x=total_bill, y=tip/total_bill)) + geom_point(shape=1)

## facet_grid ##
  # Divide by levels of "sex", in the vertical direction
  sp + facet_grid(sex ~ .)
  
  # Divide by levels of "sex", in the horizontal direction
  sp + facet_grid(. ~ sex)
  
  # Divide with "sex" vertical, "day" horizontal
  sp + facet_grid(sex ~ day)

## facet_wrap ##
    # Instead of faceting with a variable in the horizontal or vertical direction, 
    # facets can be placed next to each other, wrapping with a certain number of columns or rows. 

  # Divide by day, going horizontally and wrapping with 2 columns
  sp + facet_wrap( ~ day, ncol=2)

## Modifying facet label appearance ##
  sp + facet_grid(sex ~ day) +
    theme(strip.text.x = element_text(size=8, angle=75),
          strip.text.y = element_text(size=12, face="bold"),
          strip.background = element_rect(colour="red", fill="#CCCCFF"))

## Free scales ##
    # Normally, the axis scales on each graph are fixed, which means that they have the same size and range. 
    # They can be made independent, by setting scales to free, free_x, or free_y.

  # A histogram of bill sizes
  hp <- ggplot(tips, aes(x=total_bill)) + geom_histogram(binwidth=2,colour="white")
  
  # Histogram of total_bill, divided by sex and smoker
  hp + facet_grid(sex ~ smoker)
  
  # Same as above, with scales="free_y"
  hp + facet_grid(sex ~ smoker, scales="free_y")
  
  # With panels that have the same scaling, but different range (and therefore different physical sizes)
  hp + facet_grid(sex ~ smoker, scales="free", space="free")



##### 그래프 세부 모양 조정하기 #######################################
### Title ###
  bp <- ggplot(PlantGrowth, aes(x=group, y=weight)) + geom_boxplot()
  
  bp + ggtitle("Plant growth")
  # Equivalent to
  bp + labs(title="Plant growth")
  
  # If the title is long, it can be split into multiple lines with \n
  bp + ggtitle("Plant growth with\ndifferent treatments")
  
  # Reduce line spacing and use bold text
  bp + ggtitle("Plant growth with\ndifferent treatments") + 
    theme(plot.title = element_text(lineheight=.8, face="bold"))

### Axes ###
# changing the order or direction of the axes

    # swapping X and Y axes #
    bp + coord_flip()

## discrete axes ##
    # chaning the order of items #
    
    # Manually set the order of a discrete-valued axis
    bp + scale_x_discrete(limits=c("trt1","trt2","ctrl"))
    
    
    # Reverse the order of a discrete-valued axis 
    # Get the levels of the factor
    flevels <- levels(PlantGrowth$group)
    # "ctrl" "trt1" "trt2"
    # Reverse the order
    flevels <- rev(flevels)
    # "trt2" "trt1" "ctrl"
    bp + scale_x_discrete(limits=flevels)
    
    # Or it can be done in one line:
    bp + scale_x_discrete(limits = rev(levels(PlantGrowth$group)) )
    
    
    # Setting tick mark labels #
    bp + scale_x_discrete(breaks=c("ctrl", "trt1", "trt2"), labels=c("Control", "Treat 1", "Treat 2"))
    
    # Hide x tick marks, labels, and grid lines
    bp + scale_x_discrete(breaks=NULL)
    
    # Hide all tick marks and labels (on X axis), but keep the gridlines
    bp + theme(axis.ticks = element_blank(), axis.text.x = element_blank())

## continuous axes ##
    # Setting range and reversing direction of an axis #
    
    # Set the range of a continuous-valued axis
    # These are equivalent
    bp + ylim(0,8)
    bp + scale_y_continuous(limits=c(0,8))
    
    # If the y range is reduced using the method above, the data outside the range is ignored. 
    # This might be OK for a scatterplot, but it can be problematic for the box plots used here. 
    # For bar graphs, if the range does not include 0, the bars will not show at all!
    # To avoid this problem, you can use coord_cartesian instead. 
    # Instead of setting the limits of the data, it sets the viewing area of the data.
    
    # These two do the same thing; all data points outside the graphing range are dropped,
    # resulting in a misleading box plot
    bp + ylim(5, 7.5)
    bp + scale_y_continuous(limits=c(5, 7.5))
    
    # Using coord_cartesian "zooms" into the area
    bp + coord_cartesian(ylim=c(5, 7.5))
    
    # Specify tick marks directly
    bp + coord_cartesian(ylim=c(5, 7.5)) + 
      scale_y_continuous(breaks=seq(0, 10, 0.25))  # Ticks from 0-10, every .25
    
    
    # Reversing the direction of an axis #
    # Reverse order of a continuous-valued axis
    bp + scale_y_reverse()
    
    # Setting and hiding tick markers #
    
    # Setting the tick marks on an axis
    # This will show tick marks on every 0.25 from 1 to 10
    # The scale will show only the ones that are within range (3.50-6.25 in this case)
    bp + scale_y_continuous(breaks=seq(1,10,1/4))
    
    # The breaks can be spaced unevenly
    bp + scale_y_continuous(breaks=c(4, 4.25, 4.5, 5, 6,8))
    
    # Suppress ticks and gridlines
    bp + scale_y_continuous(breaks=NULL)
    
    # Hide tick marks and labels (on Y axis), but keep the gridlines
    bp + theme(axis.ticks = element_blank(), axis.text.y = element_blank())
    
    
    
    # Axis transformations: log, sqrt, etc. #
    # By default, the axes are linearly scaled. It is possible to transform the axes with log, power, roots, and so on.
    
    # There are two ways of transforming an axis. 
    # With a scale transform,       the data is transformed before properties such as breaks (the tick locations) and range of the axis are decided. 
    # With a coordinate transform,  the transformation happens after the breaks and scale range are decided. 
    # This results in different appearances, as shown below.
    
    # Create some noisy exponentially-distributed data
    set.seed(201)
    n <- 100
    dat <- data.frame(xval = (1:n+rnorm(n,sd=5))/20, yval = 2*2^((1:n+rnorm(n,sd=5))/20))
    
    # A scatterplot with regular (linear) axis scaling
    sp <- ggplot(dat, aes(xval, yval)) + geom_point()
    sp
    
    # log2 scaling of the y axis (with visually-equal spacing)
    library(scales)     # Need the scales package
    sp + scale_y_continuous(trans=log2_trans())
    
    # log2 coordinate transformation (with visually-diminishing spacing)
    sp + coord_trans(y="log2")
    
    
    # With a scale transformation, you can also set the axis tick marks to show exponents
    sp + scale_y_continuous(trans = log2_trans(),
                            breaks = trans_breaks("log2", function(x) 2^x),
                            labels = trans_format("log2", math_format(2^.x)))
    
    # Many transformations are available. See ?trans_new for a full list.
    
    # A couple scale transformations have convenience functions: scale_y_log10 and scale_y_sqrt (with corresponding versions for x).
    set.seed(205)
    n <- 100
    dat10 <- data.frame(xval = (1:n+rnorm(n,sd=5))/20, yval = 10*10^((1:n+rnorm(n,sd=5))/20))
    
    sp10 <- ggplot(dat10, aes(xval, yval)) + geom_point()
    
    # log10
    sp10 + scale_y_log10()
    
    # log10 with exponents on tick labels
    sp10 + scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                         labels = trans_format("log10", math_format(10^.x)))
    
    
    # Fixed ratio between x and y axes #
    # Data where x ranges from 0-10, y ranges from 0-30
    set.seed(202)
    dat <- data.frame(xval = runif(40,0,10), yval = runif(40,0,30))
    sp <- ggplot(dat, aes(xval, yval)) + geom_point()
    
    # Force equal scaling
    sp + coord_fixed()
    
    # Equal scaling, with each 1 on the x axis the same length as y on x axis
    sp + coord_fixed(ratio=1/3)


## Axis labels and text formatting ##
    
    bp + theme(axis.title.x = element_blank()) +   # Remove x-axis label
      ylab("Weight (Kg)")                    # Set y-axis label
    
    # Also possible to set the axis label with the scale
    # Note that vertical space is still reserved for x's label
    bp + scale_x_discrete(name="") +
      scale_y_continuous(name="Weight (Kg)")
    
    # To change the fonts, and rotate tick mark labels:
      
    # Change font options:
    # X-axis label: bold, red, and 20 points
    # X-axis tick marks: rotate 90 degrees CCW, move to the left a bit (using vjust,
    #   since the labels are rotated), and 16 points
    bp + theme(axis.title.x = element_text(face="bold", colour="#990000", size=20),
               axis.text.x  = element_text(angle=90, vjust=0.5, size=16))

## Tick mark label text formatters ##
    
    # Label formatters
    library(scales)   # Need the scales package
    bp + scale_y_continuous(labels=percent) +
      scale_x_discrete(labels=abbreviate)  # In this particular case, it has no effect
    
    # Other useful formatters for continuous scales include comma, percent, dollar, and scientific. 
    # For discrete scales, abbreviate will remove vowels and spaces and shorten to four characters. 
    # For dates, use date_format.
    
    # Sometimes you may need to create your own formatting function. 
    # This one will display numeric minutes in HH:MM:SS format.
    
    # Self-defined formatting function for times.
    timeHMS_formatter <- function(x) {
      h <- floor(x/60)
      m <- floor(x %% 60)
      s <- round(60*(x %% 1))                   # Round to nearest second
      lab <- sprintf('%02d:%02d:%02d', h, m, s) # Format the strings as HH:MM:SS
      lab <- gsub('^00:', '', lab)              # Remove leading 00: if present
      lab <- gsub('^0', '', lab)                # Remove leading 0 if present
    }
    
    bp + scale_y_continuous(label=timeHMS_formatter)

## Hiding gridlines ##

    # Hide all the gridlines
    bp + theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank())
    
    # Hide just the minor gridlines
    bp + theme(panel.grid.minor=element_blank())
    
    # Hide all the horizontal gridlines
    bp + theme(panel.grid.minor.x=element_blank(), panel.grid.major.x=element_blank())
    
    # Hide all the vertical gridlines
    bp + theme(panel.grid.minor.y=element_blank(), panel.grid.major.y=element_blank())



### Legends ###

## removing the legends ##
  bp <- ggplot(data=PlantGrowth, aes(x=group, y=weight, fill=group)) + geom_boxplot()
  
  # Remove legend for a particular aesthetic (fill)
  bp + guides(fill=FALSE)
  
  # It can also be done when specifying the scale
  bp + scale_fill_discrete(guide=FALSE)
  
  # This removes all legends
  bp + theme(legend.position="none")


## Changing the order of items in the legend ##
  bp + scale_fill_discrete(breaks=c("trt1","ctrl","trt2"))

## Reversing the order of items in the legend ##
  
  # These two methods are equivalent:
  bp + guides(fill = guide_legend(reverse=TRUE))
  bp + scale_fill_discrete(guide = guide_legend(reverse=TRUE))
  
  # You can also modify the scale directly:
  bp + scale_fill_discrete(breaks = rev(levels(PlantGrowth$group)))

## Hiding the legend title ##
  # Remove title for fill legend
  bp + guides(fill=guide_legend(title=NULL))
  
  # Remove title for all legends
  bp + theme(legend.title=element_blank())


## Modifying the text of legend titles and labels ##
  # With fill and color
  # bar graph
  bp + scale_fill_discrete(name="Experimental\nCondition")
  
  bp + scale_fill_discrete(name="Experimental\nCondition",
                           breaks=c("ctrl", "trt1", "trt2"),
                           labels=c("Control", "Treatment 1", "Treatment 2"))
  
  # Using a manual scale instead of hue
  bp + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"), 
                         name="Experimental\nCondition",
                         breaks=c("ctrl", "trt1", "trt2"),
                         labels=c("Control", "Treatment 1", "Treatment 2"))

## Modifying the appearance of the legend title and labels ##
  # Title appearance
  bp + theme(legend.title = element_text(colour="blue", size=16, face="bold"))
  
  # Label appearance
  bp + theme(legend.text = element_text(colour="blue", size = 16, face = "bold"))

## Changing the position of the legend ##
  # Position legend outside the plotting area (left/right/top/bottom)
  bp + theme(legend.position="top")
  
  # It is also possible to position the legend inside the plotting area.
  # Note that the numeric position below is relative to the entire area, including titles and labels, not just the plotting area.
  
  # Position legend in graph, where x,y is 0,0 (bottom left) to 1,1 (top right)
  bp + theme(legend.position=c(.5, .5))
  
  # Set the "anchoring point" of the legend (bottom-left is 0,0; top-right is 1,1)
  # Put bottom-left corner of legend box in bottom-left corner of graph
  bp + theme(legend.justification=c(0,0), legend.position=c(0,0))
  
  # Put bottom-right corner of legend box in bottom-right corner of graph
  bp + theme(legend.justification=c(1,0), legend.position=c(1,0))

