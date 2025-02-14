% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/t_statistic_interactive.R
\name{plot_t_test}
\alias{plot_t_test}
\title{compstatslib plot_t_test() function}
\usage{
plot_t_test()
}
\arguments{
\item{diff}{The test difference (defaults to 0.5).}

\item{sd}{Population standard deviation (defaults to 4).}

\item{n}{Sample size (defaults to 100).}

\item{alpha}{Significance level (defaults to 0.05).}
}
\description{
Non-interactive visualization function that plots null and alternative
t distributions of a t-test. Shows rejection zone and power as areas
under the curves.
}
\examples{
plot_t_test()
plot_t_test(diff=-0.1, sd=3)

}
