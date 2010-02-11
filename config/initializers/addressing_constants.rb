module Addressing
  STATES = {"Alabama"=>"AL", "Alaska"=>"AK", "American Samoa"=>"AS", "Arizona"=>"AZ", "Arkansas"=>"AR", "California"=>"CA", "Colorado"=>"CO", "Connecticut"=>"CT", "Delaware"=>"DE", "District Of Columbia"=>"DC", "Federated States Of Micronesia"=>"FM", "Florida"=>"FL", "Georgia"=>"GA", "Guam"=>"GU", "Hawaii"=>"HI", "Idaho"=>"ID", "Illinois"=>"IL", "Indiana"=>"IN", "Iowa"=>"IA", "Kansas"=>"KS", "Kentucky"=>"KY", "Louisiana"=>"LA", "Maine"=>"ME", "Marshall Islands"=>"MH", "Maryland"=>"MD", "Massachusetts"=>"MA", "Michigan"=>"MI", "Minnesota"=>"MN", "Mississippi"=>"MS", "Missouri"=>"MO", "Montana"=>"MT", "Nebraska"=>"NE", "Nevada"=>"NV", "New Hampshire"=>"NH", "New Jersey"=>"NJ", "New Mexico"=>"NM", "New York"=>"NY", "North Carolina"=>"NC", "North Dakota"=>"ND", "Northern Mariana Islands"=>"MP", "Ohio"=>"OH", "Oklahoma"=>"OK", "Oregon"=>"OR", "Palau"=>"PW", "Pennsylvania"=>"PA", "Puerto Rico"=>"PR", "Rhode Island"=>"RI", "South Carolina"=>"SC", "South Dakota"=>"SD", "Tennessee"=>"TN", "Texas"=>"TX", "Utah"=>"UT", "Vermont"=>"VT", "Virgin Islands"=>"VI", "Virginia"=>"VA", "Washington"=>"WA", "West Virginia"=>"WV", "Wisconsin"=>"WI", "Wyoming"=>"WY", "Armed Forces Africa"=>"AE", "Armed Forces Americas"=>"AA", "Armed Forces Canada"=>"AE", "Armed Forces Europe"=>"AE", "Armed Forces Middle East"=>"AE", "Armed Forces Pacific"=>"AP"}
  
  STREET_ABBREVIATIONS = Hash[
  %w[ alley, aly ] => /al(y|l(e(y|e)|y))/, # alley, aly, allee, ally
  %w[ annex, anx ] => /an(ne|e|n)?x/, # annex, anx, anex, annx
  %w[ arcade, arc ] => /arc(ade)?/, # arcade, arc
  %w[ avenue, ave ] => /av(e?(n(ue?)?)?)?/, # avenue, ave, av, aven, avenu, avn, avnue
  %w[ bayoo, byu ] => /ba?yo?(o|u)/, # bayoo, byu, bayou
  %w[ beach, bch ] => /b(ea)?ch/, # beach, bch
  %w[ bend, bnd ] => /be?nd/, # bend, bnd
  %w[ bluff, blf ] => /bl(u?f)?f/, # bluff, blf, bluf
  %w[ bluffs, blfs ] => /bl(u?f)?fs/, # bluffs, blfs
  %w[ bottom, btm ] => /b(ot(to?m)?|tm)/, # bottom, btm, bot, bottm
  %w[ boulevard, blvd ] => /b(oul(evard|v)?|lvd)/, # boulevard, blvd, boul, boulv
  %w[ branch, br ] => /br(a?nch)?/, # branch, br, brnch
  %w[ bridge, brg ] => /br(i?dge|g)/, # bridge, brg, brdge
  %w[ brook, brk ] => /br(oo)?k/, # brook, brk
  %w[ brooks, brks ] => /br(oo)?ks/, # brooks, brks
  %w[ burg, bg ] => /b(ur)?g/, # burg, bg
  %w[ burgs, bgs ] => /b(ur)?gs/, # burgs, bgs
  %w[ bypass, byp ] => /byp(a(ss?)?|s)?/, # bypass, byp, bypa, bypas, byps
  %w[ camp, cp ] => /c(a?m)?p/, # camp, cp, cmp
  %w[ canyon, cyn ] => /c(a?n)?yo?n/, # canyon, cyn, canyn, cnyn
  %w[ cape, cpe ] => /ca?pe/, # cape, cpe
  %w[ causeway, cswy ] => /causeway|cswy|causway/, # causeway, cswy, causway
  %w[ center, ctr ] => /center|ctr|cen|cent|centr|centre|cnter|cntr/, # center, ctr, cen, cent, centr, centre, cnter, cntr
  %w[ centers, ctrs ] => /centers|ctrs/, # centers, ctrs
  %w[ circle, cir ] => /circle|cir|circ|circl|crcl|crcle/, # circle, cir, circ, circl, crcl, crcle
  %w[ circles, cirs ] => /circles|cirs/, # circles, cirs
  %w[ cliff, clf ] => /cliff|clf/, # cliff, clf
  %w[ cliffs, clfs ] => /cliffs|clfs/, # cliffs, clfs
  %w[ club, clb ] => /club|clb/, # club, clb
  %w[ common, cmn ] => /common|cmn/, # common, cmn
  %w[ corner, cor ] => /corner|cor/, # corner, cor
  %w[ corners, cors ] => /corners|cors/, # corners, cors
  %w[ course, crse ] => /course|crse/, # course, crse
  %w[ court, ct ] => /court|ct|crt/, # court, ct, crt
  %w[ courts, cts ] => /courts|cts|ct/, # courts, cts, ct
  %w[ cove, cv ] => /cove|cv/, # cove, cv
  %w[ coves, cvs ] => /coves|cvs/, # coves, cvs
  %w[ creek, crk ] => /creek|crk|ck|cr/, # creek, crk, ck, cr
  %w[ crescent, cres ] => /crescent|cres|crecent|cresent|crscnt|crsent|crsnt/, # crescent, cres, crecent, cresent, crscnt, crsent, crsnt
  %w[ crest, crst ] => /crest|crst/, # crest, crst
  %w[ crossing, xing ] => /crossing|xing|crssing|crssng/, # crossing, xing, crssing, crssng
  %w[ crossroad, xrd ] => /crossroad|xrd/, # crossroad, xrd
  %w[ curve, curv ] => /curve|curv/, # curve, curv
  %w[ dale, dl ] => /dale|dl/, # dale, dl
  %w[ dam, dm ] => /dam|dm/, # dam, dm
  %w[ divide, dv ] => /divide|dv|div|dvd/, # divide, dv, div, dvd
  %w[ drive, dr ] => /drive|dr|driv|drv/, # drive, dr, driv, drv
  %w[ drives, drs ] => /drives|drs/, # drives, drs
  %w[ estate, est ] => /estate|est/, # estate, est
  %w[ estates, ests ] => /estates|ests/, # estates, ests
  %w[ expressway, expy ] => /expressway|expy|exp|expr|express|expw/, # expressway, expy, exp, expr, express, expw
  %w[ extension, ext ] => /extension|ext|extn|extnsn/, # extension, ext, extn, extnsn
  %w[ extensions, exts ] => /extensions|exts/, # extensions, exts
  %w[ fall ] => /fall/, # fall
  %w[ falls, fls ] => /falls|fls/, # falls, fls
  %w[ ferry, fry ] => /ferry|fry|frry/, # ferry, fry, frry
  %w[ field, fld ] => /field|fld/, # field, fld
  %w[ fields, flds ] => /fields|flds/, # fields, flds
  %w[ flat, flt ] => /flat|flt/, # flat, flt
  %w[ flats, flts ] => /flats|flts/, # flats, flts
  %w[ ford, frd ] => /ford|frd/, # ford, frd
  %w[ fords, frds ] => /fords|frds/, # fords, frds
  %w[ forest, frst ] => /forest|frst|forests/, # forest, frst, forests
  %w[ forge, frg ] => /forge|frg|forg/, # forge, frg, forg
  %w[ forges, frgs ] => /forges|frgs/, # forges, frgs
  %w[ fork, frk ] => /fork|frk/, # fork, frk
  %w[ forks, frks ] => /forks|frks/, # forks, frks
  %w[ fort, ft ] => /fort|ft|frt/, # fort, ft, frt
  %w[ freeway, fwy ] => /freeway|fwy|freewy|frway|frwy/, # freeway, fwy, freewy, frway, frwy
  %w[ garden, gdn ] => /garden|gdn|gardn|grden|grdn/, # garden, gdn, gardn, grden, grdn
  %w[ gardens, gdns ] => /gardens|gdns|grdns/, # gardens, gdns, grdns
  %w[ gateway, gtwy ] => /gateway|gtwy|gatewy|gatway|gtway/, # gateway, gtwy, gatewy, gatway, gtway
  %w[ glen, gln ] => /glen|gln/, # glen, gln
  %w[ glens, glns ] => /glens|glns/, # glens, glns
  %w[ green, grn ] => /green|grn/, # green, grn
  %w[ greens, grns ] => /greens|grns/, # greens, grns
  %w[ grove, grv ] => /grove|grv|grov/, # grove, grv, grov
  %w[ groves, grvs ] => /groves|grvs/, # groves, grvs
  %w[ harbor, hbr ] => /harbor|hbr|harb|harbr|hrbor/, # harbor, hbr, harb, harbr, hrbor
  %w[ harbors, hbrs ] => /harbors|hbrs/, # harbors, hbrs
  %w[ haven, hvn ] => /haven|hvn|havn/, # haven, hvn, havn
  %w[ heights, hts ] => /heights|hts|height|hgts|ht/, # heights, hts, height, hgts, ht
  %w[ highway, hwy ] => /highway|hwy|highwy|hiway|hiwy|hway/, # highway, hwy, highwy, hiway, hiwy, hway
  %w[ hill, hl ] => /hill|hl/, # hill, hl
  %w[ hills, hls ] => /hills|hls/, # hills, hls
  %w[ hollow, holw ] => /hollow|holw|hllw|hollows|holws/, # hollow, holw, hllw, hollows, holws
  %w[ inlet, inlt ] => /inlet|inlt/, # inlet, inlt
  %w[ island, is ] => /island|is|islnd/, # island, is, islnd
  %w[ islands, iss ] => /islands|iss|islnds/, # islands, iss, islnds
  %w[ isle ] => /isle|isles/, # isle, isles
  %w[ junction, jct ] => /junction|jct|jction|jctn|junctn|juncton/, # junction, jct, jction, jctn, junctn, juncton
  %w[ junctions, jcts ] => /junctions|jcts|jctns/, # junctions, jcts, jctns
  %w[ key, ky ] => /key|ky/, # key, ky
  %w[ keys, kys ] => /keys|kys/, # keys, kys
  %w[ knoll, knl ] => /knoll|knl|knol/, # knoll, knl, knol
  %w[ knolls, knls ] => /knolls|knls/, # knolls, knls
  %w[ lake, lk ] => /lake|lk/, # lake, lk
  %w[ lakes, lks ] => /lakes|lks/, # lakes, lks
  %w[ land ] => /land/, # land
  %w[ landing, lndg ] => /landing|lndg|lndng/, # landing, lndg, lndng
  %w[ lane, ln ] => /lane|ln|la|lanes/, # lane, ln, la, lanes
  %w[ light, lgt ] => /light|lgt/, # light, lgt
  %w[ lights, lgts ] => /lights|lgts/, # lights, lgts
  %w[ loaf, lf ] => /loaf|lf/, # loaf, lf
  %w[ lock, lck ] => /lock|lck/, # lock, lck
  %w[ locks, lcks ] => /locks|lcks/, # locks, lcks
  %w[ lodge, ldg ] => /lodge|ldg|ldge|lodg/, # lodge, ldg, ldge, lodg
  %w[ loop ] => /loop|loops/, # loop, loops
  %w[ mall ] => /mall/, # mall
  %w[ manor, mnr ] => /manor|mnr/, # manor, mnr
  %w[ manors, mnrs ] => /manors|mnrs/, # manors, mnrs
  %w[ meadow, mdw ] => /meadow|mdw/, # meadow, mdw
  %w[ meadows, mdws ] => /meadows|mdws|medows/, # meadows, mdws, medows
  %w[ mews ] => /mews/, # mews
  %w[ mill, ml ] => /mill|ml/, # mill, ml
  %w[ mills, mls ] => /mills|mls/, # mills, mls
  %w[ mission, msn ] => /mission|msn|missn|mssn/, # mission, msn, missn, mssn
  %w[ motorway, mtwy ] => /motorway|mtwy/, # motorway, mtwy
  %w[ mount, mt ] => /mount|mt|mnt/, # mount, mt, mnt
  %w[ mountain, mtn ] => /mountain|mtn|mntain|mntn|mountin|mtin/, # mountain, mtn, mntain, mntn, mountin, mtin
  %w[ mountains, mtns ] => /mountains|mtns|mntns/, # mountains, mtns, mntns
  %w[ neck, nck ] => /neck|nck/, # neck, nck
  %w[ orchard, orch ] => /orchard|orch|orchrd/, # orchard, orch, orchrd
  %w[ oval ] => /oval|ovl/, # oval, ovl
  %w[ overpass, opas ] => /overpass|opas/, # overpass, opas
  %w[ park ] => /park|pk|prk/, # park, pk, prk
  %w[ parks, park ] => /parks|park/, # parks, park
  %w[ parkway, pkwy ] => /parkway|pkwy|parkwy|pkway|pky/, # parkway, pkwy, parkwy, pkway, pky
  %w[ parkways, pkwy ] => /parkways|pkwy|pkwys/, # parkways, pkwy, pkwys
  %w[ pass ] => /pass/, # pass
  %w[ passage, psge ] => /passage|psge/, # passage, psge
  %w[ path ] => /path|paths/, # path, paths
  %w[ pike ] => /pike|pikes/, # pike, pikes
  %w[ pine, pne ] => /pine|pne/, # pine, pne
  %w[ pines, pnes ] => /pines|pnes/, # pines, pnes
  %w[ place, pl ] => /place|pl/, # place, pl
  %w[ plain, pln ] => /plain|pln/, # plain, pln
  %w[ plains, plns ] => /plains|plns|plaines/, # plains, plns, plaines
  %w[ plaza, plz ] => /plaza|plz|plza/, # plaza, plz, plza
  %w[ point, pt ] => /point|pt/, # point, pt
  %w[ points, pts ] => /points|pts/, # points, pts
  %w[ port, prt ] => /port|prt/, # port, prt
  %w[ ports, prts ] => /ports|prts/, # ports, prts
  %w[ prairie, pr ] => /prairie|pr|prarie|prr/, # prairie, pr, prarie, prr
  %w[ radial, radl ] => /radial|radl|rad|radiel/, # radial, radl, rad, radiel
  %w[ ramp ] => /ramp/, # ramp
  %w[ ranch, rnch ] => /ranch|rnch|ranches|rnchs/, # ranch, rnch, ranches, rnchs
  %w[ rapid, rpd ] => /rapid|rpd/, # rapid, rpd
  %w[ rapids, rpds ] => /rapids|rpds/, # rapids, rpds
  %w[ rest, rst ] => /rest|rst/, # rest, rst
  %w[ ridge, rdg ] => /ridge|rdg|rdge/, # ridge, rdg, rdge
  %w[ ridges, rdgs ] => /ridges|rdgs/, # ridges, rdgs
  %w[ river, riv ] => /river|riv|rivr|rvr/, # river, riv, rivr, rvr
  %w[ road, rd ] => /road|rd/, # road, rd
  %w[ roads, rds ] => /roads|rds/, # roads, rds
  %w[ route, rte ] => /route|rte/, # route, rte
  %w[ row ] => /row/, # row
  %w[ rue ] => /rue/, # rue
  %w[ run ] => /run/, # run
  %w[ shoal, shl ] => /shoal|shl/, # shoal, shl
  %w[ shoals, shls ] => /shoals|shls/, # shoals, shls
  %w[ shore, shr ] => /shore|shr|shoar/, # shore, shr, shoar
  %w[ shores, shrs ] => /shores|shrs|shoars/, # shores, shrs, shoars
  %w[ skyway, skwy ] => /skyway|skwy/, # skyway, skwy
  %w[ spring, spg ] => /spring|spg|spng|sprng/, # spring, spg, spng, sprng
  %w[ springs, spgs ] => /springs|spgs|spngs|sprngs/, # springs, spgs, spngs, sprngs
  %w[ spur ] => /spur/, # spur
  %w[ spurs, spur ] => /spurs|spur/, # spurs, spur
  %w[ square, sq ] => /square|sq|sqr|sqre|squ/, # square, sq, sqr, sqre, squ
  %w[ squares, sqs ] => /squares|sqs|sqrs/, # squares, sqs, sqrs
  %w[ station, sta ] => /station|sta|statn|stn/, # station, sta, statn, stn
  %w[ stravenue, stra ] => /stravenue|stra|strav|strave|straven|stravn|strvn|strvnue/, # stravenue, stra, strav, strave, straven, stravn, strvn, strvnue
  %w[ stream, strm ] => /stream|strm|streme/, # stream, strm, streme
  %w[ street, st ] => /street|st|str|strt/, # street, st, str, strt
  %w[ streets, sts ] => /streets|sts/, # streets, sts
  %w[ summit, smt ] => /summit|smt|sumit|sumitt/, # summit, smt, sumit, sumitt
  %w[ terrace, ter ] => /terrace|ter|terr/, # terrace, ter, terr
  %w[ throughway, trwy ] => /throughway|trwy/, # throughway, trwy
  %w[ trace, trce ] => /trace|trce|traces/, # trace, trce, traces
  %w[ track, trak ] => /track|trak|tracks|trk|trks/, # track, trak, tracks, trk, trks
  %w[ trafficway, trfy ] => /trafficway|trfy/, # trafficway, trfy
  %w[ trail, trl ] => /trail|trl|tr|trails|trls/, # trail, trl, tr, trails, trls
  %w[ tunnel, tunl ] => /tunnel|tunl|tunel|tunls|tunnels|tunnl/, # tunnel, tunl, tunel, tunls, tunnels, tunnl
  %w[ turnpike, tpke ] => /turnpike|tpke|tpk|trnpk|trpk|turnpk/, # turnpike, tpke, tpk, trnpk, trpk, turnpk
  %w[ underpass, upas ] => /underpass|upas/, # underpass, upas
  %w[ union, un ] => /union|un/, # union, un
  %w[ unions, uns ] => /unions|uns/, # unions, uns
  %w[ valley, vly ] => /valley|vly|vally|vlly/, # valley, vly, vally, vlly
  %w[ valleys, vlys ] => /valleys|vlys/, # valleys, vlys
  %w[ viaduct, via ] => /viaduct|via|vdct|viadct/, # viaduct, via, vdct, viadct
  %w[ view, vw ] => /view|vw/, # view, vw
  %w[ views, vws ] => /views|vws/, # views, vws
  %w[ village, vlg ] => /village|vlg|vill|villag|villg|villiage/, # village, vlg, vill, villag, villg, villiage
  %w[ villages, vlgs ] => /villages|vlgs/, # villages, vlgs
  %w[ ville, vl ] => /ville|vl/, # ville, vl
  %w[ vista, vis ] => /vista|vis|vist|vst|vsta/, # vista, vis, vist, vst, vsta
  %w[ walk ] => /walk/, # walk
  %w[ walks, walk ] => /walks|walk/, # walks, walk
  %w[ wall ] => /wall/, # wall
  %w[ way ] => /way|wy/, # way, wy
  %w[ ways ] => /ways/, # ways
  %w[ well, wl ] => /well|wl/, # well, wl
  %w[ wells, wls ] => /wells|wls/ # wells, wls
]

  STREET_PATTERN = /^\d{1,5}(?:\ 1\/[234])?\s+(?:[\w\s.]+)|(?i:P\.?O\.? Box \d{1,5})$/
  SECONDARY_UNIT_PATTERN =
  /^(?:(?:AP(?:ARTMEN)?T|B(?:UILDIN|LD)G|DEP(?:ARTMEN)?T|FL(?:OOR)?|H(?:ANGA|NG)R|LOT|PIER|R(?:OO)?M|SLIP|SP(?:ACE|C)|STOP|S(?:UI)?TE|TR(?:AILE|L)R|UNIT) \w{1,5})|(?:B(?:ASEMEN|SM)T|FRO?NT|LO?BBY|LOWE?R|OF(?:FICE|C)|P(?:ENTHOUSE|H)|REAR|SIDE|UPPE?R)\.?$/i

  CITY_PATTERN = /([[:alpha:]](?:(?:\.? |-)?[[:alpha:]]+)*)/ # Starts with a letter, followed by words seperated by space, hyphen, or period-space
  STATE_PATTERN = /(?:(A[AELKSZRP]|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEHINOPST]|N[CDEHJMVY]|O[HKR]|P[ARW]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY])|((?:[[:alpha:]]+ ){0,3}[[:alpha:]]{4,12}))/ # Matches all legal U.S. state two-letter abbreviation or, failing that, a few words which will later be checked with an enum to be a valid state name. TODO Put state names in this expression. They are constant and can be defined here. Should also keep the above hash (STATES) for translation to the respective abbreviation or the full name.
  ZIP_PATTERN = /(?!0{5})(\d{5}(?:-?\d{4})?)/ # matches any legal U.S. ZIP Code
  ADDRESS_LAST_LINE_PATTERN = /#{CITY_PATTERN.source}, #{STATE_PATTERN.source} #{ZIP_PATTERN.source}/

  EMAIL_USER_CHARS = "[:alnum:]!$%&'*+\/=?^_`{|}~-" # all legal characters for email mailbox name (excluding the \.)
  EMAIL_USER_PATTERN = /[#{EMAIL_USER_CHARS}]+(?:\.?[#{EMAIL_USER_CHARS}])*|".+?"/ # limit mailbox id to EMAIL_USER_CHARS unless it's wrapped in double quotes
  TLD_PATTERN = /a(?:ero|(?:rp|si)a|[cdefgilmnoqrstuwxz])|b(?:iz|[abdefghijmnorstwyz])|c(?:at|o(?:m|op)|[acdfghiklmnoruvxyz])|d[ejkmoz]|e(?:du|[cegrstu])|f[ijkmor]|g(?:ov|[adefghilmnpqrstuwy])|h[kmnrtu]|i(?:n(?:fo|t|[delmnoqrst]))|j(?:obs|[emop])|k[eghimnprwyz]|l[abcikrstuvy]|m(?:il|obi|useum|[acdeghklmnopqrstuvwxyz])|n(?:ame|et|[acefgilopruz])|o(?:m|rg)|p(?:ro|[aefghklmnrstwy])|qa|r[eosuw]|s[abcdeghiklmnrtuvyz]|t(?:(?:rav)?el|[cdfghjklmnoprtvwz])|u[agksyz]|v[aceginu]|w[fs]|y[etu]|z[amw]/ # this expression defines all current legal TLDs
  DOMAIN_PATTERN = /(?:[[:alnum:]](?:\-?[[:alnum:]]){0,62}\.)+(?:#{TLD_PATTERN.source})/ # this matches any legal domain name
  IP_ADDRESS_PATTERN = /(?:2(?:5[0-5]|[0-4][0-9])|[01]?[0-9]{1,2})(?:\.(?:2(?:5[0-5]|[0-4][0-9])|[01]?[0-9]{1,2})){3}/ # this matches any legal ip address
  EMAIL_PATTERN = /^(#{EMAIL_USER_PATTERN.source})@(#{DOMAIN_PATTERN.source}|\[#{IP_ADDRESS_PATTERN.source}\])$/ # this matches any legal email address  
  
  PHONE_PATTERN = /\A(?:\(\d{3}\)|\d{3})[-.\s]?(?!555)\d{3}[-.\s]?\d{4}(?:\s*(?:x|ext?\.?)\s*[-\s\dP*#]*)?\Z/
end

