% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mrs_data_proc.R
\name{mask_xy_mat}
\alias{mask_xy_mat}
\title{Mask a 2D MRSI dataset in the x-y dimension.}
\usage{
mask_xy_mat(mrs_data, mask)
}
\arguments{
\item{mrs_data}{MRS data object.}

\item{mask}{matrix of boolean values specifying the voxels to mask, where a
value of TRUE indicates the voxel should be removed.}
}
\value{
masked dataset.
}
\description{
Mask a 2D MRSI dataset in the x-y dimension.
}
