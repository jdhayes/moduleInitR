# define modules runtine quarantine configuration
Sys.setenv('MODULES_RUN_QUARANTINE'='LD_LIBRARY_PATH LD_PRELOAD')

# setup quarantine if defined
mlre <- ''
if (!is.na(Sys.getenv('MODULES_RUN_QUARANTINE', unset=NA))) {
   for (mlv in strsplit(Sys.getenv('MODULES_RUN_QUARANTINE'), ' ')[[1]]) {
      if (grepl('^[A-Za-z_][A-Za-z0-9_]*$', mlv)) {
         if (!is.na(Sys.getenv(mlv, unset=NA))) {
            mlre <- paste0(mlre, mlv, "_modquar='", Sys.getenv(mlv), "' ")
         }
         mlrv <- paste0('MODULES_RUNENV_', mlv)
         mlre <- paste0(mlre, mlv, "='", Sys.getenv(mlrv), "' ")
      }
   }
   if (mlre != '') {
      mlre <- paste0('env ', mlre)
   }
}

# define module command and surrounding initial environment (default value
# for MODULESHOME, MODULEPATH, LOADEDMODULES and parse of init config files)
cmdpipe <- pipe(paste0(mlre, '/usr/bin/tclsh /usr/share/Modules/libexec/modulecmd.tcl r autoinit'))
eval(parse(cmdpipe))
close(cmdpipe)

.onLoad <- function(libname, pkgname) {
  # Module function assumes MODULEPATH and MODULEDIR are set in login profile
  # Get base environment from login profile
  base_env <- strsplit(system('bash -l -c "env"',intern = TRUE),'\n')
  base_env <- strsplit(as.character(base_env),'=')

  # Iterate through base environment
  for (x in seq(1,length(base_env))) {

    # Set environment based on login profile
    if (base_env[[x]][1]=="LOADEDMODULES" || base_env[[x]][1]=="MODULESHOME" || base_env[[x]][1]=="MODULEPATH" || base_env[[x]][1]=="MODULES_DIR" || base_env[[x]][1]=="HPCC_MODULES"){
      if (base_env[[x]][1]=="LOADEDMODULES"){
        default_modules <- strsplit(base_env[[x]][2],":")
      }
      else{
        l <- list(base_env[[x]][2])
        names(l) <- base_env[[x]][1]
        do.call(Sys.setenv, l)
      }
    }
  }

  # Make sure to process default modules after the environment is set with the above loop
  for (x in seq(1,length(default_modules[[1]]))){
    module_name <- default_modules[[1]][x]
    print(paste("Loading module",module_name))
    try(eval(paste('module("load",',module_name,')')))
  }
}
