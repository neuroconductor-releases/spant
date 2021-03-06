read_ima <- function(fname, verbose = FALSE) {
  if (verbose) print(fname)
  
  vars <- read_siemens_txt_hdr(fname, "vd")
  
  # calculate expected size of data in bytes - assuming complex 4byte floats
  data_size <- vars$x_pts * vars$y_pts * vars$z_pts * vars$N * 4 * 2
  
  dcm_info <- oro.dicom::readDICOM(fname, pixelData = FALSE)$hdr
  dcm_info <- as.data.frame(dcm_info)
  padding <- 0
  if (dcm_info[nrow(dcm_info),3] == "DataSetTrailingPadding") {
    padding <- as.numeric(dcm_info[nrow(dcm_info),5]) + 12
  }
  
  con <- file(fname, 'rb')
  # assume data points are at the end of the file 
  seek(con, -data_size - padding, origin = "end")
  #print(seek(con, where = NA))
  raw_pts <- readBin(con, "numeric", size = 4L, n = (vars$x_pts * vars$y_pts * 
                                                     vars$z_pts * vars$N * 2),
                     endian = "little")
  close(con)
  
  # make complex
  data <- raw_pts[c(TRUE, FALSE)] + 1i * raw_pts[c(FALSE, TRUE)]
  
  data <- array(data, dim = c(vars$N, 1, 1, vars$z_pts, vars$y_pts, vars$x_pts, 
                              1))
  
  data <- aperm(data, c(7,5,6,4,3,2,1))
  
  res <- c(NA, vars$x_dim / vars$x_pts, vars$y_dim / vars$y_pts,
           vars$z_dim / vars$z_pts, 1, NA, 1 / vars$fs * 2)
  
  # freq domain vector vector
  freq_domain <- rep(FALSE, 7)

  ref <- def_acq_paras()$ref
  
  ima_norm <- c(vars$norm_sag, vars$norm_cor, vars$norm_tra)
  ima_pos  <- c(vars$pos_sag,  vars$pos_cor,  vars$pos_tra)
  rotation <- vars$ip_rot

  x_dirn   <- c(1, 0, 0)
  x_new    <- rotate_vec(x_dirn, ima_norm, -rotation)
  col_vec  <- cross(ima_norm, x_new)
  row_vec  <- cross(col_vec, ima_norm)
  pos_vec  <- ima_pos - row_vec * ( vars$x_pts / 2 - 0.5) * vars$x_dim /
                     vars$x_pts - col_vec * (vars$y_pts / 2 - 0.5) *
                     vars$y_dim / vars$y_pts 
  
  mrs_data <- list(ft = vars$ft, data = data, resolution = res,
                   te = vars$te, ref = ref, row_vec = row_vec,
                   col_vec = col_vec, pos_vec = pos_vec,
                   freq_domain = freq_domain)
  
  class(mrs_data) <- "mrs_data"
  mrs_data
}

#' Read a directory containing Siemens MRS IMA files and combine along the coil
#' dimension. Note that the coil ID is inferred from the sorted file name and
#' should be checked when consistency is required between two directories.
#' @param dir data directory path.
#' @return mrs_data object.
#' @export
read_ima_coil_dir <- function(dir) {
  files <- list.files(dir, full.names = TRUE)
  #warning("coil ordering is based on file name only.")
  files <- sort(files)
  mrs_list <- lapply(files, read_mrs, format = "ima", verbose = TRUE)
  mrs_data <- append_coils(mrs_list)
  return(mrs_data)
}

#' Read a directory containing Siemens MRS IMA files and combine along the
#' dynamic dimension. Note that the coil ID is inferred from the sorted file
#' name and should be checked when consistency is required.
#' @param dir data directory path.
#' @return mrs_data object.
#' @export
read_ima_dyn_dir <- function(dir) {
  files <- list.files(dir, full.names = TRUE)
  #warning("coil ordering is based on file name only.")
  files <- sort(files)
  mrs_list <- lapply(files, read_mrs, format = "ima", verbose = TRUE)
  mrs_data <- append_dyns(mrs_list)
  return(mrs_data)
}