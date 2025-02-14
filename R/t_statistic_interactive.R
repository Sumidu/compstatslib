#' compstatslib interactive_t_test() function
#' 
#' Interactive visualization function that allows one to *manipulate* the parameters that affect hypothesis testing in order to see how their variation influences the null t and alternative t distributions, and statistical power.
#' 
#' @param diff The test difference.
#' @param sd Population standard deviation.
#' @param n Sample size.
#' @param alpha Significance level.
#' 
#' @usage 
#' interactive_t_test()
#' 
#' One can click on the gear icon on the top-left corner of the plotting area to open the parameter settings.
#' The movement of the alternative t-statistics distribution with respect to the null distribution will be visible, as well as the consequent change in statistical power.
#' 
#' @export
interactive_t_test <- function() {
  manipulate::manipulate(
    plot_t_test(diff, sd, n, alpha),
    diff  = manipulate::slider(0, 4, step = 0.1, initial = 0.5),
    sd    = manipulate::slider(1, 5, step = 0.1, initial = 4),
    n     = manipulate::slider(2, 500, step = 1, initial = 100),
    alpha = manipulate::slider(0.01, 0.1, step = 0.01, initial = 0.05)
  )
}

#' compstatslib plot_t_test() function
#' 
#' Non-interactive visualization function that plots null and alternative
#' t distributions of a t-test. Shows rejection zone and power as areas
#' under the curves.
#' 
#' @param diff The test difference (defaults to 0.5).
#' @param sd Population standard deviation (defaults to 4).
#' @param n Sample size (defaults to 100).
#' @param alpha Significance level (defaults to 0.05).
#' 
#' @usage
#' plot_t_test()
#' 
#' @examples
#' plot_t_test()
#' plot_t_test(diff=-0.1, sd=3)
#' 
#' @export
plot_t_test <- function(diff = 0.5, sd = 4, n = 100, alpha = 0.05) {
  df <- n - 1
  t <- diff / (sd / sqrt(n))
  t_null_plot(df, alpha)
  t_alt_lines(df, t, alpha)
}

# Plot a distribution
plotdist <- function(xseq, xdens, col, xlim, type, lty, lwd, segments=NULL, qlty, qcol, polyfill=NULL) {
  if (type == "plot") {
    plot(xseq, xdens, type="l", lwd=0, col=col, frame=FALSE, xlim=xlim, lty=lty, ylab='', xlab='')
  }
  
  if (!is.null(polyfill)) {
    polygon(polyfill[,1], polyfill[,2], col=qcol, border=qcol)
  }
  
  # draw quantile lines
  if (!is.null(segments)) {
    segments(x0=segments[,1], x1=segments[,1], y0=0, y1=segments[,2], lwd=lwd, col=qcol, lty=qlty)
  }
  
  lines(xseq, xdens, type="l", lwd=lwd, col=col, lty=lty)
}

# Plot the t distribution
plott <- function(lwd=2, ncp=0, df=300, col=rgb(0.30,0.50,0.75), xlim=c(-3,3), type="plot", lty="solid", quants=NULL, qlty="solid", qcol=rgb(0.30,0.50,0.75, 0.5), fill_quants=NULL) {
  xseq = seq(ncp-6, ncp+6, length=1000)
  xdens = dt(xseq, ncp=ncp, df=df)
  if (length(xlim) == 0) {
    xlim = c(ncp-3.5, ncp+3.5)
  }
  
  segments <- NULL
  polyfill <- NULL
  
  if (!is.null(quants)) {
    xquants = qt(quants, ncp=ncp, df=df)
    dquants = dt(xquants, ncp=ncp, df=df)
    segments = cbind(xquants, dquants)
  }
  
  if(!is.null(fill_quants)) {
    polyq = qt(fill_quants, ncp=ncp, df=df)
    polyfill.x = seq(polyq[1], polyq[2], by=0.001)
    polyfill.y = dt(polyfill.x, ncp=ncp, df=df)
    polyfill.x = c(polyfill.x[1], polyfill.x, tail(polyfill.x,1))
    polyfill.y = c(0, polyfill.y, 0)
    polyfill <- cbind(polyfill.x, polyfill.y)
  }
  
  plotdist(xseq, xdens, col, xlim, type, lty, lwd, segments, qlty, qcol, polyfill)
}

t_null_plot <- function(df, alpha) {
  plott(df=df, col=rgb(0.75, 0.1, 0.1), qcol=rgb(1, 0.5, 0.5), xlim=c(-6, 6), fill_quants=c(1-alpha, 0.999))
}

t_alt_lines <- function(df, ncp=0, alpha) {
  blue <- rgb(0.1, 0.1, 0.75)
  lightblue <- rgb(0.4, 0.4, 1, 0.3)
  quants <- c(0.5)
  power_quant <- pt(qt(1-alpha, df=df), df=df, ncp=ncp)
  plott(df=df, ncp=ncp, type='lines', lty="dashed", col=blue, quants=quants, qcol=lightblue, xlim=c(-6, 6), fill_quants=c(power_quant, 0.999))
}
