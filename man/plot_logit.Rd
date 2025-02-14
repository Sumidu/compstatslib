% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logit_plot.R
\name{plot_logit}
\alias{plot_logit}
\title{compstatslib plot_logit() function}
\usage{
plot_regr(points, ...)
}
\arguments{
\item{points}{A \code{dataframe} of *x* and *y* coordinates to plot.}

\item{formula}{A \code{formula} to use in estimating logit
(e.g., \code{y ~ x}).}

\item{regression}{A logical parameter that plots a regression line when
set to TRUE and hides it when set to FALSE. It is set to TRUE by default.}

\item{stats}{A logical parameter that displays the relevant statistics on
the plot area when set to TRUE; it hides them when set to FALSE.
It is set to TRUE by default.
The following parameters are provided on the plot area:
 \item{Intercept}{The intercept of the logistic regression.}
 \item{Coefficient}{The coefficient of the independent variable.}
 \item{AIC}{An information theoretic fit criterion.}}
}
\value{
A \code{dataframe} containing the points coordinates.
}
\description{
Non-interactive visualization function that plots given points,
logistic regression line and relevant statistics.
}
\examples{
pts <- data.frame(x = c(1, 3, 5, 8), y = c(2, 4, 6 ,8))
plot_regr(pts, formula = y ~ x)

names(pts) <- c("input", "output")
plot_regr(pts, formula = output ~ input)

}
\seealso{
\code{\link{interactive_regression}}
}
