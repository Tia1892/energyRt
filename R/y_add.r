

################################################################################
# Add commodity
################################################################################
sm_add_CodeProduce_commodity_list <- function(obj, app, approxim) {
  cmd <- upper_case(app)
  cmd <- stayOnlyVariable(cmd, approxim$region, 'region')
#  if (!chec_correct_name(cmd@name)) {
#    stop(paste('Incorrect commodity name "', cmd@name, '"', sep = ''))
#  }
##    cat(cmd@name, '\n')
#
#  # Add commodity to set
#  if (isCommodity(obj, cmd@name)) {
#    warning(paste('There is commodity name "', cmd@name,
#        '" now, all previous information will be removed', sep = ''))
#    obj <- removePreviousCommodity(obj, cmd@name)
#  }
#  obj@maptable[['comm']] <- addData(obj@maptable[['comm']], cmd@name)
  # Add ems_from & pEmissionFactor
  dd <- cmd@emis[, c('comm', 'comm', 'mean'), drop = FALSE]
  if (nrow(dd) > 0) {
    colnames(dd) <- c('comm', 'commp', 'Freq')
    dd[, 'commp'] <- cmd@name
    dd[, 'Freq'] <- as.numeric(dd$Freq) # Must be remove later
    #obj@maptable[['ems_from']] <- addData(obj@maptable[['ems_from']], dd[, c('comm', 'commp'), drop = FALSE])
    obj@maptable[['pEmissionFactor']] <- addData(obj@maptable[['pEmissionFactor']], dd)
  }

  dd <- cmd@agg[, c('comm', 'comm', 'agg'), drop = FALSE]
  if (nrow(dd) > 0) {
    colnames(dd) <- c('comm', 'commp', 'Freq')
    dd[, 'comm'] <- cmd@name
    dd[, 'Freq'] <- as.numeric(dd$Freq) # Must be remove later
    #obj@maptable[['ems_from']] <- addData(obj@maptable[['ems_from']], dd[, c('comm', 'commp'), drop = FALSE])
    obj@maptable[['pAggregateFactor']] <- addData(obj@maptable[['pAggregateFactor']], dd)
  }

  # Define mUpComm | mLoComm | mFxComm
  if (cmd@limtype == 'UP')
    obj@maptable[['mUpComm']] <- addData(obj@maptable[['mUpComm']], data.frame(comm = cmd@name))
  if (cmd@limtype == 'LO')
    obj@maptable[['mLoComm']] <- addData(obj@maptable[['mLoComm']], data.frame(comm = cmd@name))
  if (cmd@limtype == 'FX')
    obj@maptable[['mFxComm']] <- addData(obj@maptable[['mFxComm']], data.frame(comm = cmd@name))
  obj
}

setMethod('add0', signature(obj = 'CodeProduce', app = 'commodity',
  approxim = 'list'), sm_add_CodeProduce_commodity_list)



################################################################################
# Add demand
################################################################################
setMethod('add0', signature(obj = 'CodeProduce', app = 'demand',
  approxim = 'list'), function(obj, app, approxim) {     
  dem <- upper_case(app)
  dem <- stayOnlyVariable(dem, approxim$region, 'region')
#  if (!chec_correct_name(dem@name)) {
#    stop(paste('Incorrect demand name "', dem@name, '"', sep = ''))
#  }
#  if (isDemand(obj, dem@name)) {
#    warning(paste('There is demand name "', dem@name,
#        '" now, all previous information will be removed', sep = ''))
#    obj <- removePreviousDemand(obj, dem@name)
#  }
#  obj@maptable[['dem']] <- addData(obj@maptable[['dem']], dem@name)
  obj@maptable[['mDemComm']] <- addData(obj@maptable[['mDemComm']],
      data.frame(dem = dem@name, comm = dem@commodity)) 
  obj@maptable[['pDemand']] <- addData(obj@maptable[['pDemand']],
      simple_data_frame_approximation_chk(dem@dem, 'dem',
      obj@maptable[['pDemand']], approxim, 'dem', dem@name))
  obj
})

################################################################################
# Add supply
################################################################################
setMethod('add0', signature(obj = 'CodeProduce', app = 'supply',
  approxim = 'list'), function(obj, app, approxim) {
  sup <- upper_case(app)
  sup <- stayOnlyVariable(sup, approxim$region, 'region')
#  if (!chec_correct_name(sup@name)) {
#    stop(paste('Incorrect supply name "', sup@name, '"', sep = ''))
#  }
#  if (isSupply(obj, sup@name)) {
#    warning(paste('There is supply name "', sup@name,
#        '" now, all previous information will be removed', sep = ''))
#    obj <- removePreviousSupply(obj, sup@name)
#  }    
#  obj@maptable[['sup']] <- addData(obj@maptable[['sup']], sup@name)
  obj@maptable[['mSupComm']] <- addData(obj@maptable[['mSupComm']],
      data.frame(sup = sup@name, comm = sup@commodity))
  obj@maptable[['pSupCost']] <- addData(obj@maptable[['pSupCost']],
      simple_data_frame_approximation_chk(sup@availability, 'cost',
          obj@maptable[['pSupCost']], approxim, 'sup', sup@name))
  obj@maptable[['pSupReserve']] <- addData(obj@maptable[['pSupReserve']],
      data.frame(sup = sup@name, Freq = sup@reserve))
  obj@maptable[['pSupAva']] <- addData(obj@maptable[['pSupAva']],
            data_frame_approximation_chk(sup@availability, 'ava',
            obj@maptable[['pSupAva']], approxim, 'sup', sup@name))
  obj
})

################################################################################
# Add export
################################################################################
setMethod('add0', signature(obj = 'CodeProduce', app = 'export',
  approxim = 'list'), function(obj, app, approxim) {
  exp <- upper_case(app)
  exp <- stayOnlyVariable(exp, approxim$region, 'region')
#  if (!chec_correct_name(exp@name)) {
#    stop(paste('Incorrect export name "', exp@name, '"', sep = ''))
#  }
#  if (isExport(obj, exp@name)) {
#    warning(paste('There is export name "', exp@name,
#        '" now, all previous information will be removed', sep = ''))
#    obj <- removePreviousExport(obj, exp@name)
#  }    
#  obj@maptable[['expp']] <- addData(obj@maptable[['expp']], exp@name)
  obj@maptable[['mExpComm']] <- addData(obj@maptable[['mExpComm']],
      data.frame(expp = exp@name, comm = exp@commodity))
  obj@maptable[['pRowExportPrice']] <- addData(obj@maptable[['pRowExportPrice']],
      simple_data_frame_approximation_chk(exp@exp, 'price',
          obj@maptable[['pRowExportPrice']], approxim, 'expp', exp@name))
  obj@maptable[['pRowExportRes']] <- addData(obj@maptable[['pRowExportRes']],
      data.frame(expp = exp@name, Freq = exp@reserve))
  obj@maptable[['pRowExport']] <- addData(obj@maptable[['pRowExport']],
            data_frame_approximation_chk(exp@exp, 'exp',
            obj@maptable[['pRowExport']], approxim, 'expp', exp@name))
  obj
})

################################################################################
# Add import
################################################################################
setMethod('add0', signature(obj = 'CodeProduce', app = 'import',
  approxim = 'list'), function(obj, app, approxim) {
  imp <- upper_case(app)
  imp <- stayOnlyVariable(imp, approxim$region, 'region')
#  if (!chec_correct_name(imp@name)) {
#    stop(paste('Incorrect import name "', imp@name, '"', sep = ''))
#  }
#  if (isImport(obj, imp@name)) {
#    warning(paste('There is import name "', imp@name,
#        '" now, all previous information will be removed', sep = ''))
#    obj <- removePreviousImport(obj, imp@name)
#  }    
#  obj@maptable[['imp']] <- addData(obj@maptable[['imp']], imp@name)
  obj@maptable[['mImpComm']] <- addData(obj@maptable[['mImpComm']],
      data.frame(imp = imp@name, comm = imp@commodity))
  obj@maptable[['pRowImportPrice']] <- addData(obj@maptable[['pRowImportPrice']],
      simple_data_frame_approximation_chk(imp@imp, 'price',
          obj@maptable[['pRowImportPrice']], approxim, 'imp', imp@name))
  obj@maptable[['pRowImportRes']] <- addData(obj@maptable[['pRowImportRes']],
      data.frame(imp = imp@name, Freq = imp@reserve))
  obj@maptable[['pRowImport']] <- addData(obj@maptable[['pRowImport']],
            data_frame_approximation_chk(imp@imp, 'imp',
            obj@maptable[['pRowImport']], approxim, 'imp', imp@name))
  obj
})

################################################################################
# Add constrain
################################################################################
setMethod('add0', signature(obj = 'CodeProduce', app = 'constrain',
  approxim = 'list'), function(obj, app, approxim) {
  app <- upper_case(app)
  if (!chec_correct_name(app@name)) {
    stop(paste('Incorrect constrain name "', app@name, '"', sep = ''))
  }
  if (isConstrain(obj, app@name)) {
    stop(paste('There is constrain name "', app@name,
       '" now', sep = ''))
#    warning(paste('There is constrain name "', app@name,
#        '" now, all previous information will be removed', sep = ''))
#    obj <- removePreviousConstrain(obj, app@name)
  }
##  obj@maptable[['sup']] <- addData(obj@maptable[['sup']], sup@name)
##  obj@maptable[['mSupComm']] <- addData(obj@maptable[['mSupComm']],
##      data.frame(sup = sup@name, comm = sup@commodity))
##  obj@maptable[['pSupCost']] <- addData(obj@maptable[['pSupCost']],
##      simple_data_frame_approximation_chk(sup@availability, 'cost',
##          obj@maptable[['pSupCost']], approxim, 'sup', sup@name))
##  obj@maptable[['pSupReserve']] <- addData(obj@maptable[['pSupReserve']],
##      data.frame(sup = sup@name, Freq = sup@reserve))
##  obj@maptable[['pSupAva']] <- addData(obj@maptable[['pSupAva']],
##            data_frame_approximation_chk(sup@availability, 'ava',
##            obj@maptable[['pSupAva']], approxim, 'sup', sup@name))
#  if (!chec_correct_name(app@name)) {
#    stop(paste('Incorrect technology name "', app@name, '"', sep = ''))
#  }
#  if (isConstrain(obj, app@name)) {
#    warning(paste('There is constrain name "', app@name,
#        '" now, all previous information will be removed', sep = ''))
#  }
#  tt <- showEquation(app, approxim)
#  obj@constrain[[app@name]] <- tt
  if (app@type == 'tax') {
     obj@maptable[['pTaxCost']] <- addData(obj@maptable[['pTaxCost']],
        simple_data_frame_approximation_chk(app@rhs, 'tax',
         obj@maptable[['pTaxCost']], approxim, 'comm', app@comm))
  } else
  if (app@type == 'subs') {
     obj@maptable[['pSubsCost']] <- addData(obj@maptable[['pSubsCost']],
        simple_data_frame_approximation_chk(app@rhs, 'subs',
         obj@maptable[['pSubsCost']], approxim, 'comm', app@comm))
  } else {
    # Define lhs equation type
    ccc <- c("comm", "region", "year", "slice")
    if (app@type %in% c('capacity', 'newcapacity')) ccc <- c("region", "year")
    # capacity newcapacity activity input output sharein shareout
    if (app@type %in% c('output', 'shareout')) before <- 'Out' else
    if (app@type %in% c('input', 'sharein'))   before <- 'Inp' else
    if (app@type == 'capacity') before <- 'Cap' else
    if (app@type == 'newcapacity') before <- 'NewCap' else stop('Unlnown constrain type')
    ast <- c(names(app@for.sum), names(app@for.each))[!(c(names(app@for.sum), names(app@for.each)) %in% ccc)] 
    if (length(ast) > 1) stop('Wrong constrain') else
    if (length(ast) == 1) {
      before <- paste(before, toupper(substr(ast, 1, 1)), substr(ast, 2, nchar(ast)), sep = '')
    }
 #   cat(app@name, '\n')
#    if (app@name == 'GAS_UP') browser()
    FL <- TRUE
    for(cc in ccc) if (nrow(obj@maptable[[cc]]@data) == 0) FL <- FALSE
    if (length(ast) != 0 && nrow(obj@maptable[[ast]]@data) == 0) FL <- FALSE
    if (FL) {
      obj@maptable[['cns']] <- addData(obj@maptable[['cns']], app@name)
      obj@maptable[[paste('mCns', before, sep = '')]] <- addData(obj@maptable[[paste('mCns', before, sep = '')]], 
           data.frame(cns = app@name, stringsAsFactors = FALSE))  
      if (app@type == 'sharein')  obj@maptable[['mCnsRhsTypeShareIn']] <- 
         addData(obj@maptable[['mCnsRhsTypeShareIn']], data.frame(cns = app@name, stringsAsFactors = FALSE)) else
      if (app@type == 'shareout')  obj@maptable[['mCnsRhsTypeShareOut']] <- 
        addData(obj@maptable[['mCnsRhsTypeShareOut']], data.frame(cns = app@name, stringsAsFactors = FALSE)) else 
      obj@maptable[['mCnsRhsTypeConst']] <- addData(obj@maptable[['mCnsRhsTypeConst']], 
          data.frame(cns = app@name, stringsAsFactors = FALSE))
      for(cc in ccc) {
        if (cc %in% names(app@for.sum)) {
          if (is.null(app@for.sum[[cc]])) ll <- obj@maptable[[cc]]@data[, cc] else
            ll <- app@for.sum[[cc]]
          nn <- paste('mCnsLhs', toupper(substr(cc, 1, 1)), substr(cc, 2, nchar(cc)), sep = '')
          obj@maptable[[nn]] <- addData(obj@maptable[[nn]], data.frame(cns = app@name,
            stringsAsFactors = FALSE))
        } else if (cc %in% names(app@for.each)) {
          if (is.null(app@for.each[[cc]])) ll <- obj@maptable[[cc]]@data[, cc] else
            ll <- app@for.each[[cc]]
          approxim[[cc]] <- ll
        } else stop('Wrong constrain')
        if (cc == 'year') ll <- ll[ll %in% obj@maptable$year@data[, 'year']] 
        nn <- paste('mCns', toupper(substr(cc, 1, 1)), substr(cc, 2, nchar(cc)), sep = '')
        dtt <- data.frame(cns = rep(app@name, length(ll)), ll, stringsAsFactors = FALSE)
        colnames(dtt) <- c('cns', cc)
        obj@maptable[[nn]] <- addData(obj@maptable[[nn]], dtt)
      }
      # Define rhs type
      if (app@eq == '>=') obj@maptable[['mCnsGe']] <- addData(obj@maptable[['mCnsGe']], 
          data.frame(cns = app@name, stringsAsFactors = FALSE))
      if (app@eq == '<=') obj@maptable[['mCnsLe']] <- addData(obj@maptable[['mCnsLe']], 
          data.frame(cns = app@name, stringsAsFactors = FALSE))
    }
    # Define rhs
        year_range <- range(obj@maptable$year@data[, 'year'])
        approxim <- approxim[names(approxim) %in% names(app@for.each)] 
        if (any(colnames(approxim) == 'year')) {
          year_range <- c(max(c(min(approxim$year), year_range[1])), min(c(max(approxim$year), year_range[2]))) 
        }
        rhs <- interpolation(app@rhs, 'rhs', approxim = approxim, year_range = year_range,
            rule = app@rule, default = app@default)
        colnames(rhs)[ncol(rhs)] <- 'Freq'
        rhs <- cbind(cns = rep(app@name, nrow(rhs)), rhs)
        if (any(colnames(rhs) == 'year')) rhs$year <- as.numeric(as.character(rhs$year))
        nn <- paste('pRhs', paste(toupper(substr(ccc[ccc %in% names(app@for.each)], 1, 1)), 
            collapse = ''), sep = '')
      obj@maptable[[nn]] <- addData(obj@maptable[[nn]], rhs)
    #obj@maptable[[nn]] <- 
#    paste(c('L'[any(!(names(app@for.each) %in% ccc))], 
#      toupper(substr(ccc[ccc %in% names(app@for.each)], 1, 1))), collapse = '')
    
    
    # Define sharein & shareout type
  
  }
  obj
})

################################################################################
# Add technology
################################################################################
setMethod('add0', signature(obj = 'CodeProduce', app = 'technology',
  approxim = 'list'), function(obj, app, approxim) {
#  mTechInpComm(tech, comm)       Input commodity
#  mTechOutComm(tech, comm)       Output commodity
#  mTechCapComm(tech, comm)       Capacity fix commodity
#  mTechActComm(tech, comm)       Activity fix commodity
#  mTechUseComm(tech, comm)       Activity fix commodity
#  mTechOneComm(tech, comm)    Single commodity
#  mTechGroupComm(tech, group, comm)  Share (group) commodity connect to group
#  mTechCapGroup(tech, group)         Group connect with capacity
#  mTechUseGroup(tech, group)         Group connect with use
#  mTechActGroup(tech, group)         Group connect with use
#  mTechInpGroup(tech, group)         Group use for input
#  mTechOutGroup(tech, group)         Group use for output
#  mTechStartYear(tech, region, year) Start year
#  mTechEndYear(tech, region, year)   End year
#  mTechDisable(tech, region)     Disable new technology
#  * Emissions
#  mTechEmisComm(tech, comm)
#  mTechEmitedComm(tech, comm)
#  mUpComm(comm)  PRODUCTION <= CONSUMPTION
#  mLoComm(comm)  PRODUCTION >= CONSUMPTION
#  mFxComm(comm)  PRODUCTION = CONSUMPTION
  tech <- upper_case(app)
  tech <- stayOnlyVariable(tech, approxim$region, 'region')
  # Temporary solution for immortality technology
  if (nrow(tech@olife) == 0) {
    tech@olife[1, ] <- NA;
    tech@olife[1, 'olife'] <- 1e3;
  }
#  if (!chec_correct_name(tech@name)) {
#    stop(paste('Incorrect technology name "', tech@name, '"', sep = ''))
#  }
#  if (isTechnology(obj, tech@name)) {
#    warning(paste('There is technology name "', tech@name,
#        '" now, all previous information will be removed', sep = ''))
#    obj <- removePreviousTechnology(obj, tech@name)
#  }
#  obj@maptable[['tech']] <- addData(obj@maptable[['tech']], tech@name)
  # Map
  ctype <- checkInpOut(tech)
  # Need choose comm more accuracy
  approxim_comm <- approxim
  approxim_comm[['comm']] <- rownames(ctype$comm)
  if (length(approxim_comm[['comm']]) != 0)
    obj@maptable[['pTechCvarom']] <- addData(obj@maptable[['pTechCvarom']],
      simple_data_frame_approximation_chk(tech@varom, 'cvarom',
       obj@maptable[['pTechCvarom']], approxim_comm, 'tech', tech@name))
  approxim_comm[['comm']] <- rownames(ctype$comm)
  if (length(approxim_comm[['comm']]) != 0) {
    gg <- data_frame_approximation_chk(tech@ceff, 'afac',
            obj@maptable[['pTechAfac']], approxim_comm, 'tech', tech@name)
    obj@maptable[['pTechAfac']] <- addData(obj@maptable[['pTechAfac']], gg)
    gg <- gg[gg$type == 'up' & gg$Freq != Inf, ]
    if (nrow(gg) != 0) 
      obj@maptable[['defpTechAfacUp']] <- addData(obj@maptable[['defpTechAfacUp']],
            gg[, obj@maptable[['defpTechAfacUp']]@set])

  }
  gg <- data_frame_approximation_chk(tech@afa, 'afa',
            obj@maptable[['pTechAfa']], approxim, 'tech', tech@name)
  obj@maptable[['pTechAfa']] <- addData(obj@maptable[['pTechAfa']], gg)
  gg <- gg[gg$type == 'up' & gg$Freq != Inf, ]
  if (nrow(gg) != 0) 
      obj@maptable[['defpTechAfaUp']] <- addData(obj@maptable[['defpTechAfaUp']],
            gg[, obj@maptable[['defpTechAfaUp']]@set])

  approxim_comm[['comm']] <- rownames(ctype$comm)[ctype$comm$type == 'input']
  if (length(approxim_comm[['comm']]) != 0) {
    obj@maptable[['pTechCinp2use']] <- addData(obj@maptable[['pTechCinp2use']],
      simple_data_frame_approximation_chk(tech@ceff, 'cinp2use',
       obj@maptable[['pTechCinp2use']], approxim_comm, 'tech', tech@name))
  }
  approxim_comm[['comm']] <- rownames(ctype$comm)[ctype$comm$type == 'output']
  if (length(approxim_comm[['comm']]) != 0) {
    obj@maptable[['pTechUse2cact']] <- addData(obj@maptable[['pTechUse2cact']],  
       simple_data_frame_approximation_chk(tech@ceff, 'use2cact',
       obj@maptable[['pTechUse2cact']], approxim_comm, 'tech', tech@name))
    obj@maptable[['pTechCact2cout']] <- addData(obj@maptable[['pTechCact2cout']],
      simple_data_frame_approximation_chk(tech@ceff, 'cact2cout',
       obj@maptable[['pTechCact2cout']], approxim_comm, 'tech', tech@name))
    if (any(!is.na(tech@ceff$cact2cout) & (tech@ceff$cact2cout == 0 | tech@ceff$cact2cout == Inf)))
      stop('cact2cout is not correct ', tech@name)
    if (any(!is.na(tech@ceff$use2cact) & (tech@ceff$use2cact == 0 | tech@ceff$use2cact == Inf)))
      stop('use2cact is not correct ', tech@name)
  }
  approxim_comm[['comm']] <- rownames(ctype$comm)[ctype$comm$type == 'input' & !is.na(ctype$comm[, 'group'])]
  if (length(approxim_comm[['comm']]) != 0) {
    obj@maptable[['pTechCinp2ginp']] <- addData(obj@maptable[['pTechCinp2ginp']],
      simple_data_frame_approximation_chk(tech@ceff, 'cinp2ginp',
       obj@maptable[['pTechCinp2ginp']], approxim_comm, 'tech', tech@name))
  }
  if (tech@early.retirement) 
     obj@maptable[['mTechRetirement']] <- addData(obj@maptable[['mTechRetirement']], data.frame(tech = tech@name))
  if (length(tech@upgrade.technology) != 0)
     obj@maptable[['mTechUpgrade']] <- addData(obj@maptable[['mTechUpgrade']], 
        data.frame(tech = rep(tech@name, length(tech@upgrade.technology)), techp = tech@upgrade.technology))
  cmm <- rownames(ctype$comm)[ctype$comm$type == 'input'] 
  if (length(cmm) != 0)
    obj@maptable[['mTechInpComm']] <- addData(obj@maptable[['mTechInpComm']],
      data.frame(tech = rep(tech@name, length(cmm)), comm = cmm))
  cmm <- rownames(ctype$comm)[ctype$comm$type == 'output']
  if (length(cmm) != 0)
    obj@maptable[['mTechOutComm']] <- addData(obj@maptable[['mTechOutComm']],
      data.frame(tech = rep(tech@name, length(cmm)), comm = cmm))
  cmm <- rownames(ctype$comm)[is.na(ctype$comm$group)] 
  if (length(cmm) != 0)
    obj@maptable[['mTechOneComm']] <- addData(obj@maptable[['mTechOneComm']],
      data.frame(tech = rep(tech@name, length(cmm)), comm = cmm))
  approxim_comm[['comm']] <- rownames(ctype$comm)[!is.na(ctype$comm$group)]
  if (length(approxim_comm[['comm']]) != 0)
    obj@maptable[['pTechShare']] <- addData(obj@maptable[['pTechShare']],
          data_frame_approximation_chk(tech@ceff, 'share',
            obj@maptable[['pTechShare']], approxim_comm, 'tech', tech@name))
  cmm <- rownames(ctype$comm)[ctype$comm$comb]
  if (length(cmm) != 0) {
    obj@maptable[['pTechEmisComm']] <- addData(obj@maptable[['pTechEmisComm']],
      data.frame(tech = rep(tech@name, nrow(ctype$comm)), comm = rownames(ctype$comm),
        Freq = ctype$comm$comb))
  }
  gpp <- rownames(ctype$group)[ctype$group$type == 'input']
  if (length(gpp) != 0)
    obj@maptable[['mTechInpGroup']] <- addData(obj@maptable[['mTechInpGroup']],
      data.frame(tech = rep(tech@name, length(gpp)), group = gpp))
  gpp <- rownames(ctype$group)[ctype$group$type == 'output']
  if (length(gpp) != 0)
    obj@maptable[['mTechOutGroup']] <- addData(obj@maptable[['mTechOutGroup']],
      data.frame(tech = rep(tech@name, length(gpp)), group = gpp))
  approxim_group <- approxim
  approxim_group[['group']] <- rownames(ctype$group)[ctype$group$type == 'input']
  if (length(approxim_group[['group']]) != 0)
      obj@maptable[['pTechGinp2use']] <- addData(obj@maptable[['pTechGinp2use']],
        simple_data_frame_approximation_chk(tech@geff, 'ginp2use',
          obj@maptable[['pTechGinp2use']], approxim_group, 'tech', tech@name))
  if (nrow(ctype$group) > 0)
    obj@maptable[['group']] <- addMultipleSet(obj@maptable[['group']], rownames(ctype$group))
 fl <- !is.na(ctype$comm$group)
  if (any(fl)) {
    gcomm <- data.frame(tech = rep(tech@name, sum(fl)), group = ctype$comm$group[fl], 
        comm = rownames(ctype$comm)[fl], stringsAsFactors = FALSE)
    obj@maptable[['mTechGroupComm']] <- addData(obj@maptable[['mTechGroupComm']], gcomm)
  }
  if (any(ctype$aux$output)) {    
    cmm <- rownames(ctype$aux)[ctype$aux$output]
    obj@maptable[['mTechAOut']] <- addData(obj@maptable[['mTechAOut']],
      data.frame(tech = rep(tech@name, length(cmm)), comm = cmm))
  }
  if (any(ctype$aux$input)) {    
    cmm <- rownames(ctype$aux)[ctype$aux$input]
    obj@maptable[['mTechAInp']] <- addData(obj@maptable[['mTechAInp']],
      data.frame(tech = rep(tech@name, length(cmm)), comm = cmm))
  }
  dd <- data.frame(list = c('pTechUse2AOut', 'pTechAct2AOut', 'pTechCap2AOut', 
       'pTechUse2AInp', 'pTechAct2AInp', 'pTechCap2AInp', 'pTechNCap2AInp', 'pTechNCap2AOut'),
    table = c('use2aout', 'act2aout', 'cap2aout', 'use2ainp', 'act2ainp', 'cap2ainp', 'ncap2ainp', 'ncap2aout'),
    stringsAsFactors = FALSE)
  for(i in 1:nrow(dd)) {
    approxim_comm <- approxim_comm[names(approxim_comm) != 'comm']
    approxim_comm[['acomm']] <- unique(tech@aeff[!is.na(tech@aeff[, dd[i, 'table']]), 'acomm'])
    if (length(approxim_comm[['acomm']]) != 0) {
       obj@maptable[[dd[i, 'list']]] <- addData(obj@maptable[[dd[i, 'list']]],
              simple_data_frame_approximation_chk(tech@aeff, dd[i, 'table'], 
                obj@maptable[[dd[i, 'list']]], approxim_comm, 'tech', tech@name))
    }
  }                
                
    # Single & Double
    obj@maptable[['pTechCap2act']] <- addData(obj@maptable[['pTechCap2act']],
      data.frame(tech = tech@name, Freq = tech@cap2act))
    dd <- data.frame(list = c('pTechOlife', 'pTechFixom', 'pTechInvcost', 'pTechStock',
      'pTechVarom'),
      table = c('olife', 'fixom', 'invcost', 'stock', 'varom'),
      stringsAsFactors = FALSE)
    for(i in 1:nrow(dd)) {
      obj@maptable[[dd[i, 'list']]] <- addData(obj@maptable[[dd[i, 'list']]],
        simple_data_frame_approximation_chk(slot(tech, dd[i, 'table']),
          dd[i, 'table'], obj@maptable[[dd[i, 'list']]], approxim, 'tech', tech@name))
    }
    if (nrow(tech@aeff) != 0) {
        for(i in 1:4) {
          tech@aeff <- tech@aeff[!is.na(tech@aeff$acomm),]
          ll <- c('cinp2ainp', 'cinp2aout', 'cout2ainp', 'cout2aout')[i]
          tbl <- c('pTechCinp2AInp', 'pTechCinp2AOut', 'pTechCout2AInp', 'pTechCout2AOut')[i]          
          tbl2 <- c('mTechCinpAInp', 'mTechCinpAOut', 'mTechCoutAInp', 'mTechCoutAOut')[i]     
          yy <- tech@aeff[!is.na(tech@aeff[, ll]), ]
          if (nrow(yy) != 0) {
            approxim_commp <- approxim
            approxim_commp$acomm <- unique(yy$acomm); 
            approxim_commp$comm <- unique(yy$comm)
            obj@maptable[[tbl]] <- addData(obj@maptable[[tbl]],
            simple_data_frame_approximation_chk(yy, ll, obj@maptable[[tbl]], 
                  approxim_commp, 'tech', tech@name))
          }
#            tech@aeff <- tech@aeff[!is.na(tech@aeff$comm) & !is.na(tech@aeff$commp),]
#            for(cmd in approxim_commp$comm) {
#              cmm <- tech@aeff[tech@aeff$comm == cmd & !is.na(tech@aeff[, ll]), 'commp']
#              obj@maptable[[tbl2]] <- addData(obj@maptable[[tbl2]], 
#                  data.frame(tech = rep(tech@name, length(cmm)), comm = rep(cmd, length(cmm)), commp = cmm))
#           }
        }
    }
  
  # Start / End year
  dd <- data.frame(enable = rep(TRUE, length(approxim$region) * length(approxim$year)),
    tech = rep(tech@name, length(approxim$region) * length(approxim$year)),
    region = rep(approxim$region, length(approxim$year)), 
    year = c(t(matrix(rep(approxim$year, length(approxim$region)), length(approxim$year)))), 
    stringsAsFactors = FALSE)   
  dstart <- data.frame(row.names = approxim$region, region = approxim$region, 
    year = rep(NA, length(approxim$region)), stringsAsFactors = FALSE)
  fl <- is.na(tech@start$region)
  if (any(fl)) {
    if (sum(fl) != 1) stop('Wrong start year for technology ', tech@name)
    dstart[, 'year'] <- tech@start[fl, 'start']
  }
  if (any(!fl)) {
    dstart[tech@start[!fl, 'region'], 'year'] <- tech@start[!fl, 'year']
  }
  dstart <- dstart[!is.na(dstart$year),, drop = FALSE]
  for(rr in dstart$region) {
    if (any(dd$year < dstart[rr, 'year'])) dd[dd$region == rr & dd$year < dstart[rr, 'year'], 'enable'] <- FALSE
  } 
  dd_able <- dd
  ## end 
  dend <- data.frame(row.names = approxim$region, region = approxim$region, 
    year = rep(NA, length(approxim$region)), stringsAsFactors = FALSE)
  fl <- is.na(tech@end$region)
  if (any(fl)) {
    if (sum(fl) != 1) stop('Wrong start year for technology ', tech@name)
    dend[, 'year'] <- tech@end[fl, 'end']
  }
  if (any(!fl)) {
    dend[tech@end[!fl, 'region'], 'year'] <- tech@end[!fl, 'end']
  }
  dend <- dend[!is.na(dend$year),, drop = FALSE]
  for(rr in dend$region) {
    if (any(dd$year >= dend[rr, 'year'])) dd[dd$region == rr & dd$year >= dend[rr, 'year'], 'enable'] <- FALSE
  }  
  dd <- dd[dd$enable, -1, drop = FALSE]
  obj@maptable[['mTechNew']] <- addData(obj@maptable[['mTechNew']], dd)
  ## life 
  dlife <- data.frame(row.names = approxim$region, region = approxim$region, 
    year = rep(NA, length(approxim$region)), stringsAsFactors = FALSE)
  fl <- is.na(tech@olife$region)
  if (any(fl)) {
    if (sum(fl) != 1) stop('Wrong start year for technology ', tech@name)
    dlife[, 'year'] <- tech@olife[fl, 'olife']
  }
  if (any(!fl)) {
    dlife[tech@olife[!fl, 'region'], 'year'] <- tech@olife[!fl, 'olife']
  }
  dlife <- dlife[!is.na(dlife$year),, drop = FALSE]
  for(rr in dlife$region[dlife$region %in% dend$region]) {
    if (any(dd_able$year >= dend[rr, 'year'] + dlife[rr, 'year'])) 
      dd_able[dd_able$region == rr & dd_able$year >= dend[rr, 'year'] + dlife[rr, 'year'], 'enable'] <- FALSE
  }  
  gg <- obj@maptable[["pTechStock"]]@data[!is.na(obj@maptable[["pTechStock"]]@data$tech) & 
     obj@maptable[['pTechStock']]@data$tech == tech@name & 
     obj@maptable[['pTechStock']]@data$Freq != 0,, drop = FALSE] 
  
  if (nrow(gg) != 0 && any(!dd_able$enable)) {
    for(rr in unique(gg$region)) {
      dd_able[dd_able$region == rr & dd_able$year %in% gg[gg$region == rr, 'year'], 'enable'] <- TRUE
    }
  }   
  dd_able <- dd_able[dd_able$enable, -1, drop = FALSE]
#  cat(tech@name, '\n')
  obj@maptable[['mTechSpan']] <- addData(obj@maptable[['mTechSpan']], dd_able)
  if (all(ctype$comm$type != 'output')) 
    stop('Techology "', tech@name, '", there is not activity commodity')   
  obj
})

################################################################################
# Add sysInfo
################################################################################
setMethod('add0', signature(obj = 'CodeProduce', app = 'sysInfo',
  approxim = 'list'), function(obj, app, approxim) {
  obj <- removePreviousSysInfo(obj)
  app <- stayOnlyVariable(app, approxim$region, 'region')
  # Discount
      obj@maptable[['pDiscount']] <- addData(obj@maptable[['pDiscount']],
        simple_data_frame_approximation_chk(app@discount, 'discount',
          obj@maptable[['pDiscount']], approxim))
  approxim_comm <- approxim
  approxim_comm[['comm']] <- obj@maptable$comm@data$comm
  if (length(approxim_comm[['comm']]) != 0) {
    # Dummy import
      obj@maptable[['pDumCost']] <- addData(obj@maptable[['pDumCost']],
        simple_data_frame_approximation_chk(app@DummyImport, 'dummy',
          obj@maptable[['pDumCost']], approxim_comm))
#    # Tax
#      obj@maptable[['pTaxCost']] <- addData(obj@maptable[['pTaxCost']],
#        simple_data_frame_approximation_chk(app@tax, 'tax',
#          obj@maptable[['pTaxCost']], approxim_comm))
#    # Subs
#      obj@maptable[['pSubsCost']] <- addData(obj@maptable[['pSubsCost']],
#        simple_data_frame_approximation_chk(app@subs, 'subs',
#          obj@maptable[['pSubsCost']], approxim_comm))
  }
  if (nrow(app@milestone) == 0) {
    app <- setMileStoneYears(app, start = min(app@year), interval = rep(1, length(app@year)))
  }

  obj@maptable[['mMidMilestone']] <- addData(obj@maptable[['mMidMilestone']], 
    data.frame(year = app@milestone$mid))
  obj@maptable[['mStartMilestone']] <- addData(obj@maptable[['mStartMilestone']], 
    data.frame(year = app@milestone$mid, yearp = app@milestone$start))
  obj@maptable[['mEndMilestone']] <- addData(obj@maptable[['mEndMilestone']], 
    data.frame(year = app@milestone$mid, yearp = app@milestone$end))
  obj@maptable[['mMilestoneLast']] <- addData(obj@maptable[['mMilestoneLast']], 
    data.frame(year = max(app@milestone$mid)))
  obj
})


