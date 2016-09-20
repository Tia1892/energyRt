get_technology_default_value  <- function() data.frame(#region     = character(),
                        inp2use    = as.numeric(1),
                        inp2cap    = as.numeric(1),
                        out2use    = as.numeric(1),
                        out2cap    = as.numeric(1),
                        #share.fx  = character('back.inter.forth'),
                        share.lo   = as.numeric(0),
                        share.up   = as.numeric(1),
                        elceff    = as.numeric(1),
                        #ceff       = as.numeric(1), There isn't exist, replace by cinp2ginp gout2cout
                        cinp2ginp  = as.numeric(1),
                        gout2cout  = as.numeric(1),
                        cinp2use   = as.numeric(1),
                        use2cout   = as.numeric(1),
                        cinpcap    = as.numeric(1),
                        coutcap    = as.numeric(1),
                        ginp2use   = as.numeric(1),
                        use2gout   = as.numeric(1),
                        ginpcap    = as.numeric(1),
                        goutcap    = as.numeric(1),
                        #af.fx     = character('back.inter.forth'),
                        afa.lo     = as.numeric(0),
                        afa.up     = as.numeric(1),
                        ceh        = as.numeric(1),
                        #chpr.fx   = character('back.inter.forth'),
                        chpr.lo    = as.numeric(1),
                        chpr.up    = as.numeric(1),
                        fixom      = as.numeric(0),
                        varom      = as.numeric(0),
                        cvarom     = as.numeric(0),
                        invcost    = as.numeric(0),
                        #start     = character(),
                        #end       = character(),
                        olife      = as.numeric(Inf),
                        #rlife     = character(),
                        stock      = as.numeric(0),
                        #act.fx    = character(),
                        actbnd.lo  = as.numeric(0),
                        actbnd.up  = as.numeric(1),
                        #cum       = character(),
                        afac.lo    = as.numeric(0),
                        afac.up    = as.numeric(Inf),
                        stringsAsFactors = FALSE)
get_technology_interpolation  <- function() data.frame(#region     = character(),
                        inp2use    = as.character('back.inter.forth'),
                        inp2cap    = as.character('back.inter.forth'),
                        out2use    = as.character('back.inter.forth'),
                        out2cap    = as.character('back.inter.forth'),
                        #share.fx  = character('back.inter.forth'),
                        share.lo   = as.character('back.inter.forth'),
                        share.up   = as.character('back.inter.forth'),
                        elceff    = as.character('back.inter.forth'),
                        # ceff       = as.character('back.inter.forth'),
                        cinp2ginp  = as.character('back.inter.forth'),
                        gout2cout  = as.character('back.inter.forth'),
                        cinp2use   = as.character('back.inter.forth'),
                        use2cout   = as.character('back.inter.forth'),
                        cinpcap    = as.character('back.inter.forth'),
                        coutcap    = as.character('back.inter.forth'),
                        ginp2use   = as.character('back.inter.forth'),
                        use2gout   = as.character('back.inter.forth'),
                        ginpcap    = as.character('back.inter.forth'),
                        goutcap    = as.character('back.inter.forth'),
                        #af.fx     = character('back.inter.forth'),
                        afa.lo      = as.character('back.inter.forth'),
                        afa.up      = as.character('back.inter.forth'),
                        ceh        = as.character('back.inter.forth'),
                        #chpr.fx   = character('back.inter.forth'),
                        chpr.lo    = as.character('back.inter.forth'),
                        chpr.up    = as.character('back.inter.forth'),
                        fixom      = as.character('back.inter.forth'),
                        varom      = as.character('back.inter.forth'),
                        cvarom     = as.character('back.inter.forth'),
                        invcost    = as.character('back.inter.forth'),
                        #start     = character(),
                        #end       = character(),
                        olife      = as.character('back.inter.forth'),
                        #rlife     = character(),
                        stock      = as.character('back.inter.forth'),
                        #act.fx    = character(),
                        actbnd.lo  = as.character('back.inter.forth'),
                        actbnd.up  = as.character('back.inter.forth'),
                        #cum       = character(),
                        afac.lo    = as.character('back.inter.forth'),
                        afac.up    = as.character('back.inter.forth'),
                        stringsAsFactors = FALSE)