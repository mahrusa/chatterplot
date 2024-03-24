library(ggplot2)
data("mpg")
View(mpg)

mpg$cyl <- factor(mpg$cyl, levels <- c("4", "5", "6", "8"))
mpg$trans <- substr(mpg$trans, start = 1, stop = 4)
mpg$trans <- factor(mpg$trans)
mpg$drv <- factor(mpg$drv, ordered = TRUE, levels = c("f", "r", "4"))
mpg$fl <- factor(mpg$fl, levels <- c("p", "d", "e", "r"), 
                 labels <- c("gasoline", "diesel", "other", "other"))
mpg$class <- factor(mpg$class, levels <- c("2seater", "subcompact", "compact", 
                                           "midsize", "suv", "minivan", "pickup"))

graphScatter = function(frame, varx, vary) {
  namex = deparse(substitute(varx))
  namey = deparse(substitute(vary))
  ggplot(data = frame, aes(x = varx, y = vary)) + 
    geom_point() + 
    labs(x = namex, y = namey, 
         title = paste("Relationship between ", namex, " and ", namey))
}

graphScatterByColor = function(frame, varx, vary, varc) {
  namex = deparse(substitute(varx))
  namey = deparse(substitute(vary))
  namec = deparse(substitute(varc))
  ggplot(data = frame, aes(x = varx, y = vary, col = varc)) + 
    geom_point() + 
    labs(x = namex, y = namey, 
         title = paste("Relationship between ", namex, " and ", namey)) +
    guides(fill = guide_legend(title = namec))
}

graphViolin = function(frame, varx, vary) {
  namex = deparse(substitute(varx))
  namey = deparse(substitute(vary))
  ggplot(data = frame, aes(x = varx, y = vary)) + 
    geom_violin() + 
    labs(x = namex, y = namey, 
         title = paste("Relationship between ", namex, " and ", namey))
}

graphViolinByColor = function(frame, varx, vary, varc) {
  namex = deparse(substitute(varx))
  namey = deparse(substitute(vary))
  namec = deparse(substitute(varc))
  ggplot(data = frame, aes(x = varx, y = vary, fill = varc)) + 
    geom_violin(alpha = 0.5) + 
    labs(x = namex, y = namey, 
         title = paste("Relationship between ", namex, " and ", namey)) +
    guides(fill = guide_legend(title = namec))
}

graphDensity = function(frame, varx) {
  namex = deparse(substitute(varx))
  ggplot(data = frame, aes(x = varx)) + 
    geom_density() + 
    labs(x = namex, y = "Density", 
         title = paste("Density of ", namex))
}

graphDensityByColor = function(frame, varx, varc) {
  namex = deparse(substitute(varx))
  namec = deparse(substitute(varc))
  ggplot(data = frame, aes(x = varx, fill = varc)) + 
    geom_density(alpha = 0.5) + 
    labs(x = namex, y = "Density", 
         title = paste("Density of ", namex)) +
    guides(fill = guide_legend(title = namec))
}



addLine = function(frame, varx, vary) {
  geom_smooth(method = "lm", se = FALSE, color = "blue", data = frame, 
                                     aes(x = varx, y = vary))
}

getMax = function(vect) {
  max(vect)
}

getMin = function(vect) {
  min(vect)
}

getAvg = function(vect) {
  mean(vect)
}

graphScatter(mpg, mpg$cty, mpg$hwy) + addLine(mpg, mpg$cty, mpg$hwy)
graphScatterByColor(mpg, mpg$cty, mpg$hwy, mpg$fl)

graphViolin(mpg, mpg$cty, mpg$hwy)
graphViolinByColor(mpg, mpg$cty, mpg$hwy, mpg$fl)

graphDensity(mpg, mpg$cty)
graphDensityByColor(mpg, mpg$cty, mpg$fl)

getMax(mpg$cty)
getMin(mpg$cty)
getAvg(mpg$cty)
getMode(mpg$cty)
