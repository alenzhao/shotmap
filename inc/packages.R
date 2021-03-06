#!/usr/bin/R

args <- commandArgs(TRUE)

r.lib  <- args[1]
mirror <- args[2]

.libPaths( r.lib )

install.packages( "vegan", lib=r.lib, repos=mirror );
install.packages( "plyr", lib=r.lib, repos=mirror );
install.packages( "dplyr", lib=r.lib, repos=mirror );
install.packages( "ggplot2", lib=r.lib, repos=mirror );
install.packages( "reshape2", lib=r.lib, repos=mirror );
install.packages( "fpc", lib=r.lib, repos=mirror );
install.packages( "grid", lib=r.lib, repos=mirror );
install.packages( "coin", lib=r.lib, repos=mirror );
install.packages( "MASS", lib=r.lib, repos=mirror );
install.packages( "dendextend", lib=r.lib, repos=mirror );
install.packages( "psych", lib=r.lib, repos=mirror );

source("http://bioconductor.org/biocLite.R")
biocLite("qvalue")
biocLite("multtest")