locallib <- Sys.getenv( "SHOTMAP_LOCAL")

options(error=traceback)
#options(error=recover)

Args              <- commandArgs()
abund.map.file    <- Args[4]
metadata.file     <- Args[5]
outpath           <- Args[6]
cat.fields.file   <- Args[7]
r.lib             <- Args[8]

if( !is.na( r.lib ) ){
    .libPaths( r.lib )  
}

source( paste( locallib, "/lib/R/shotmap.R", sep="" ) )

#####################
#### INPUT VARIABLES
div.map   <- read.table( file = metadata.file,
                         header = T,
                        )
abund.map <- read.table( file = abund.map.file,
                         header = T,
                         row.names = 1,
                         check.names = F
)
if(  cat.fields.file == "NULL" ){
  set_categorical_fields( NULL )
} else {
    cat.field.list <- read.table( file = cat.fields.file )
    set_categorical_fields( as.vector( cat.field.list ) )
}

# Set up the output infrastructure
alpha.out  <- paste( outpath, "/Alpha_Diversity/", sep="")
beta.out   <- paste( outpath, "/Beta_Diversity/", sep="")
family.out <- paste( outpath, "/Families/", sep="")
dir.create( outpath, showWarnings = FALSE )
dir.create( alpha.out, showWarnings = FALSE )
dir.create( beta.out, showWarnings = FALSE )
dir.create( family.out, showWarnings = FALSE )

# Filter families based on Patrick's recommendations
abund.map   <- abundance_variance_filtering( abund.map, "full.observation" )

# Run the pipeline
plot_diversity_stats( div.map, alpha.out )
categorical_diversity_analyses( div.map, alpha.out )
continuous_diversity_analyses( div.map, alpha.out )
categorical_family_analyses( div.map, abund.map, family.out, 0.15 )
continuous_family_analyses( div.map, abund.map, family.out, 0.15 )
ordinate_samples( div.map, abund.map, beta.out )