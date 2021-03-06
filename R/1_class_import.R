#---------------------------------------------------------------------------------------------------------
# import
#---------------------------------------------------------------------------------------------------------
setClass("import",
      representation(
          name          = "character",
          description   = "character",
          color         = "data.frame",      #
          commodity     = "character",
          unit          = "character",
          reserve       = "numeric",
          imp           = "data.frame",
          GIS                = "GIS", # @GIS # setClassUnion("GIS", members=c("SpatialPolygonsDataFrame", "NULL"))
          misc = "list"
      ),
      prototype(
          name          = "",
          description   = "",
          color         = data.frame(region   = character(),
                                     color    = character(),
                                     stringsAsFactors = FALSE),
          commodity     = "",
          unit          = "",
          reserve       = Inf,
          imp           = data.frame(region   = character(),
                                     year     = numeric(),
                                     slice    = character(),
                                     imp.lo   = numeric(),
                                     imp.up   = numeric(),
                                     imp.fx   = numeric(),
                                     price     = numeric(),
                                     stringsAsFactors = FALSE),
      GIS           = NULL,
      #! Misc
      misc = list(
      )),
      S3methods = TRUE
);
setMethod("initialize", "import", function(.Object, ...) {
  attr(.Object, 'GUID') <- '8954c52f-6514-49ae-9688-17d6c5e74f06'
  .Object
})
                                              