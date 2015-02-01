# Anti Aliasing with R
# install.package("Cairo")
# install.package("igraph")
library(igraph)
g <- graph.tree(40, 4)
plot(g)

library(Cairo)
CairoWin()
plot(g)




install.packages("ggvis")
library(ggvis)


## ggvis??
# 1) Declaratively describe data graphics with a syntax similar in spirit to ggplot2.
# 2) Create rich interactive graphics that you can play with locally in Rstudio or in your browser.
# 3) Leverage shiny’s infrastructure to publish interactive graphics usable from any browser
# The goal is to combine the best of R (e.g. every modelling function you can imagine) and the best of the web (everyone has a web browser)



### Scatter Plots
  head(mtcars)
  mtcars %>% ggvis(~wt, ~mpg) %>% layer_points()
  
  # Smaller points, a different shape, a different outline (stroke) color, and empty fill
  mtcars %>% 
    ggvis(~wt, ~mpg) %>% 
    layer_points(size := 25, shape := "diamond", stroke := "red", fill := NA)

### Regression Lines
  # Adding a smooth line
  mtcars %>% 
    ggvis(~wt, ~mpg) %>%
    layer_points() %>%
    layer_smooths()
  
  # With a linear model, and 95% confidence interval for the model
  mtcars %>% 
    ggvis(~wt, ~mpg) %>%
    layer_points() %>%
    layer_model_predictions(model = "lm", se = TRUE)

### Scatter plots with grouping
  # Coloring points by a variable
  mtcars %>% 
    ggvis(~wt, ~mpg) %>% 
    layer_points(fill = ~factor(cyl))
  
  # Coloring points, and adding a smoother for each group. 
  # The grouping variable (which is applied before the transform_smooth is calculated) must be specified with group_by()
  mtcars %>% 
    ggvis(~wt, ~mpg, fill = ~factor(cyl)) %>% 
    layer_points() %>% 
    group_by(cyl) %>% 
    layer_model_predictions(model = "lm")

### Bar graphs
  head(pressure)
  
  # When the variable on the x axis is continuous (e.g., numeric or date-time)
  pressure %>% 
    ggvis(~temperature, ~pressure) %>%
    layer_bars()
  
  # It’s possible to specify the width of the bars
  pressure %>% 
    ggvis(~temperature, ~pressure) %>%
    layer_bars(width = 10)
  
  # When the variable on the x axis is categorical (e.g., factor or character)
  pressure2 <- pressure %>% mutate(temperature = factor(temperature))
  
  pressure2 %>% ggvis(~temperature, ~pressure) %>%
    layer_bars()

### Line graphs
  pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()
  
  # Lines with points
  pressure %>% ggvis(~temperature, ~pressure) %>%
    layer_points() %>% 
    layer_lines()

### Histograms
head(faithful)

faithful %>% ggvis(~eruptions) %>% layer_histograms()

# Modify the fill color and binwidth
faithful %>% ggvis(~eruptions, fill := "#fff8dc") %>%
  layer_histograms(binwidth = 0.25)



######## ggvis basic ########
# The goal of ggvis is to make it easy to build interactive graphics for exploratory data analysis
# ggvis has a similar underlying theory to ggplot2 (the grammar of graphics), but it’s expressed a little differently, 
# and adds new features to make your plots interactive
# ggvis also incorporates shiny’s reactive programming model and dplyr’s grammar of data transformation

##### ggvis() #####
p <- ggvis(mtcars, x = ~wt, y = ~mpg)

# This doesn’t actually plot anything because you haven’t told ggvis how to display your data. You do that by layering visual elements
layer_points(p)

# If you’re not using RStudio, you’ll notice that this plot opens in your web browser. 
# That’s because all ggvis graphics are web graphics, and need to be shown in the browser
# RStudio includes a built-in browser so it can show you the plots directly.

layer_points(ggvis(mtcars, x = ~wt, y = ~mpg))

# To make life easier ggvis uses the %>% (pronounced pipe) function from the magrittr packag
mtcars %>%
  ggvis(x = ~wt, y = ~mpg) %>%
  layer_points()

library(dplyr)
mtcars %>%
  ggvis(x = ~mpg, y = ~disp) %>%
  mutate(disp = disp / 61.0237) %>% # convert engine displacment to litres
  layer_points()

# We use ~ before the variable name to indicate that we don’t want to literally use the value of the mpg variable (which doesn’t exist), 
# but instead we want we want to use the mpg variable inside in the dataset.

# The first two arguments to ggvis() are usually the position, so by convention you can drop x and y
mtcars %>%
  ggvis(~mpg, ~disp) %>%
  layer_points()

# You can add more variables to the plot by mapping them to other visual properties like fill, stroke, size and shape
mtcars %>% ggvis(~mpg, ~disp, stroke = ~vs) %>% layer_points()

mtcars %>% ggvis(~mpg, ~disp, fill = ~vs) %>% layer_points()

mtcars %>% ggvis(~mpg, ~disp, size = ~vs) %>% layer_points()

mtcars %>% ggvis(~mpg, ~disp, shape = ~factor(cyl)) %>% layer_points()


# If you want to make the points a fixed colour or size, you need to use := instead of =. The := operator means to use a raw, unscaled value.
mtcars %>% ggvis(~wt, ~mpg, fill := "red", stroke := "black") %>% layer_points()

mtcars %>% ggvis(~wt, ~mpg, size := 300, opacity := 0.4) %>% layer_points()

mtcars %>% ggvis(~wt, ~mpg, shape := "cross") %>% layer_points()


##### interactivity #####
mtcars %>% 
  ggvis(~wt, ~mpg, 
        size := input_slider(10, 100),
        opacity := input_slider(0, 1)
  ) %>% 
  layer_points()


mtcars %>% 
  ggvis(~wt) %>% 
  layer_histograms(width = input_slider(0, 2, step = 0.1))

# As well as input_slider(), ggvis provides input_checkbox(), input_checkboxgroup(), 
# input_numeric(), input_radiobuttons(), input_select() and input_text()
# You can also use keyboard controls with left_right() and up_down()

keys_s <- left_right(10, 1000, step = 50)
mtcars %>% ggvis(~wt, ~mpg, size := keys_s, opacity := 0.5) %>% layer_points()


##### layer type #####
### There are five simple layers
# 1) Points, layer_points(), with properties x, y, shape, stroke, fill, strokeOpacity, fillOpacity, and opacity
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points()

# 2) Paths and polygons, layer_paths()
df <- data.frame(x = 1:10, y = runif(10))
df %>% ggvis(~x, ~y) %>% layer_paths()

t <- seq(0, 2 * pi, length = 100)
df <- data.frame(x = sin(t), y = cos(t))
df %>% ggvis(~x, ~y) %>% layer_paths(fill := "red") # if you supply a 'fill', you will get a polygon

# 3) Filled areas, layer_ribbons(). Use properties y and y2 to control the extent of the area
df <- data.frame(x = 1:10, y = runif(10))
df %>% ggvis(~x, ~y) %>% layer_ribbons()

df %>% ggvis(~x, ~y + 0.1, y2 = ~y - 0.1) %>% layer_ribbons()

# 4) Rectangles, layer_rects(). The location and size of the rectangle is controlled by the x, x2, y and y2 properties
set.seed(1014)
df <- data.frame(x1 = runif(5), x2 = runif(5), y1 = runif(5), y2 = runif(5))
df %>% ggvis(~x1, ~y1, x2 = ~x2, y2 = ~y2, fillOpacity := 0.1) %>% layer_rects()

# 5) Text, layer_text(). The text layer has many new options to control the apperance of the text: 
# text (the label), dx and dy (margin in pixels between text and anchor point), angle (rotate the text), font (font name), 
# fontSize (size in pixels), fontWeight (e.g. bold or normal), fontStyle (e.g. italic or normal.)

df <- data.frame(x = 3:1, y = c(1, 3, 2), label = c("a", "b", "c"))
df %>% ggvis(~x, ~y, text := ~label) %>% layer_text()

df %>% ggvis(~x, ~y, text := ~label) %>% layer_text(fontSize := 50)

df %>% ggvis(~x, ~y, text := ~label) %>% layer_text(angle := 45)

### Compound layers
# The four most common compound layers are 
# 1) layer_lines() which automatically orders by the x variable
t <- seq(0, 2 * pi, length = 20)
df <- data.frame(x = sin(t), y = cos(t))
df %>% ggvis(~x, ~y) %>% layer_paths()

df %>% ggvis(~x, ~y) %>% layer_lines()

# layer_lines() is equivalent to arrange() + layer_paths()
df %>% ggvis(~x, ~y) %>% arrange(x) %>% layer_paths()

# 2) layer_histograms() and layer_freqpolys() which allows you to explore the distribution of continuous. 
# Both layers first bin the data with compute_bin() then display the results with either rects or lines.
mtcars %>% ggvis(~mpg) %>% layer_histograms()

binned <- mtcars %>% compute_bin(~mpg) # Or equivalently
binned %>% 
  ggvis(x = ~xmin_, x2 = ~xmax_, y2 = 0, y = ~count_, fill := "black") %>%
  layer_rects()

# 3) layer_smooths() fits a smooth model to the data, and displays predictions with a line. It’s used to highlight the trend in noisy data:
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths()

smoothed <- mtcars %>% compute_smooth(mpg ~ wt) # Or equivalently
smoothed %>% ggvis(~pred_, ~resp_) %>% layer_paths()

# You can control the degree of wiggliness with the span parameter
span <- input_slider(0.2, 1, value = 0.75)
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths(span = span)

##### multiple layers #####
# Rich graphics can be created by combining multiple layers on the same plot. This easier to do: just layer on multiple elements
mtcars %>% 
  ggvis(~wt, ~mpg) %>% 
  layer_smooths() %>% 
  layer_points()

# adding two smoothers with varying degrees of wiggliness
mtcars %>% ggvis(~wt, ~mpg) %>%
  layer_smooths(span = 1) %>%
  layer_smooths(span = 0.3, stroke := "red")


