% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rats.R
\name{rats}
\alias{rats}
\title{Robust Alignment to a Target Spectrum (RATS).}
\usage{
rats(
  mrs_data,
  ref = NULL,
  xlim = c(4, 0.5),
  max_shift = 20,
  p_deg = 2,
  max_t = 0.2
)
}
\arguments{
\item{mrs_data}{MRS data to be corrected.}

\item{ref}{optional MRS data to use as a reference, the mean of all dynamics
is used if this argument is not supplied.}

\item{xlim}{optional frequency range to perform optimisation, set to NULL
to use the full range.}

\item{max_shift}{maximum allowable frequency shift in Hz.}

\item{p_deg}{polynomial degree used for baseline modelling. Negative values
disable baseline modelling.}

\item{max_t}{truncate the FID when longer than max_t to reduce time taken}
}
\value{
a list containing the corrected data; phase and shift values in units
of degrees and Hz respectively.
}
\description{
Robust Alignment to a Target Spectrum (RATS).
}
