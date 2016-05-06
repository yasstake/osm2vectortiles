#
#	japan.latest.pbf
#		-> japan.land.pbf
#		-> japan.sea.osm
#
#	japan.sea.osm + /ORG/japan.sea.osm -> sea.osm -> smfilter -> sea.pbf
#	
#	imposm land.pbf
#	imposm sea.pbf
#
#

DATADIR=/import/

WORKDIR = $(DATADIR)/WORK

ORGPBF=$(WORKDIR)/japan.latest.pbf
RAWPBF=$(WORKDIR)/japan.org.pbf

JAPAN_LAND_PBF=$(DATADIR)/japan.land.pbf

JAPAN_SEA_PBF=$(WORKDIR)/japan.sea.pbf
ORG_SEA_PBF=$(WORKDIR)/seafilter.pbf
MERGE_SEA_OSM=$(WORKDIR)/japan.mergesea.osm
JAPAN_FILTER_OSM=$(WORKDIR)/japan.mergefilter.osm
FISH_RIGHT_OSM=$(WORKDIR)/fish.osm

FISH_RIGHT_PBF=$(DATADIR)/fish.pbf
JAPAN_FILTER_PBF=$(DATADIR)/japan.mergefilter.pbf

all: $(JAPAN_FILTER_PBF) $(JAPAN_LAND_PBF) $(FISH_RIGHT_PBF) $(WORKDIR) 

$(WORKDIR):
	mkdir -p $(WORKDIR)

$(ORGPBF):
	wget  http://download.geofabrik.de/asia/japan-latest.osm.pbf -O $(ORGPBF)

clipdata: $(ORGPBF) 
	osmosis --read-pbf $(ORGPBF) --bounding-box bottom=35 top=36 left=139 right=140 --write-pbf $(RAWPBF)

alldata: $(ORGPBF)
	cp $(ORGPBF) $(RAWPBF)

$(RAWPBF): clipdata

$(JAPAN_SEA_PBF):	$(RAWPBF) $(WORKDIR)
	osmosis --read-pbf $(RAWPBF) \
		--tf accept-ways seamark:type=*	\
		--tf accept-node seamark:type=*	\
		--tf accept-relations seamark:type=* \
		--write-pbf file=$(JAPAN_SEA_PBF)

$(JAPAN_LAND_PBF):	$(RAWPBF) $(WORKDIR) 
	osmosis --read-pbf $(RAWPBF) \
		--tf reject-ways seamark:type=*	\
		--tf reject-node seamark:type=*	\
		--tf reject-relations seamark:type=* \
		--write-pbf file=$(JAPAN_LAND_PBF)

$(MERGE_SEA_OSM): $(ORG_SEA_PBF) $(JAPAN_SEA_PBF) $(WORKDIR)
	osmosis --read-pbf $(ORG_SEA_PBF) \
		--read-pbf $(JAPAN_SEA_PBF)\
		--merge \
		--write-xml file=$(MERGE_SEA_OSM)

$(ORG_SEA_PBF): $(WORKDIR)
	wget https://github.com/yasstake/osmlight/raw/master/SEAMAPDATA/seafilter.pbf -O $(ORG_SEA_PBF)

$(JAPAN_FILTER_PBF): $(MERGE_SEA_OSM)
	smrender -r /rules.osm -i $(MERGE_SEA_OSM) -G -M -w /dev/stdout | osmosis --read-xml file=- --write-pbf $(JAPAN_FILTER_PBF)

$(FISH_RIGHT_OSM):
	wget https://github.com/yasstake/ksj2osm/raw/master/fish.osm -O $(FISH_RIGHT_OSM)


$(FISH_RIGHT_PBF): $(FISH_RIGHT_OSM)
#	python ../ksj2osm/fish.py $(FISH_RIGHT_KJS2) $(FISH_RIGHT_OSM)
	osmosis --read-xml file=$(FISH_RIGHT_OSM) --write-pbf $(FISH_RIGHT_PBF)

