# sudo pip install csvkit
mkdir csv
mkdir ingegi
cd ingegi

# mapbox auth production XXXXXX
# aws s3 cp s3://gis-data/inegi/inegi_data.zip

unzip inegi_data.zip;

for f in inegi_data/*.zip; do
	unzip $f;
done;

rm *.zip;

counter=0
for f in *; do
	counter=$((counter+1))
	output='../csv/'$f'.csv';
	ogr2ogr -t_srs EPSG:4326 -f CSV $output $f/*T.shp -lco GEOMETRY=AS_XY;
	echo $counter' done'
done;

# csvstack ../csv/* > mx.csv # needs utf-8 and the csvs apparently aren't??? 
