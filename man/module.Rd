\name{module}
\alias{module}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
function to do ...
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
module(...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (...) 
{
    mlre <- ""
    if (!is.na(Sys.getenv("MODULES_RUN_QUARANTINE", unset = NA))) {
        for (mlv in strsplit(Sys.getenv("MODULES_RUN_QUARANTINE"), 
            " ")[[1]]) {
            if (grepl("^[A-Za-z_][A-Za-z0-9_]*$", mlv)) {
                if (!is.na(Sys.getenv(mlv, unset = NA))) {
                  mlre <- paste0(mlre, mlv, "_modquar='", Sys.getenv(mlv), 
                    "' ")
                }
                mlrv <- paste0("MODULES_RUNENV_", mlv)
                mlre <- paste0(mlre, mlv, "='", Sys.getenv(mlrv), 
                  "' ")
            }
        }
        if (mlre != "") {
            mlre <- paste0("env ", mlre)
        }
    }
    arglist <- as.list(match.call())
    arglist[1] <- "r"
    args <- paste0("\"", paste0(arglist, collapse = "\" \""), 
        "\"")
    cmd <- paste(mlre, "/usr/bin/tclsh", "/usr/share/Modules/libexec/modulecmd.tcl", 
        args, sep = " ")
    mlstatus <- TRUE
    hndl <- pipe(cmd)
    eval(expr = parse(file = hndl))
    close(hndl)
    invisible(mlstatus)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
