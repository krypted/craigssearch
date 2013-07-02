output=ads
#Input cities array
cities=( losangeles dallas seattle portland sandiego minneapolis atlanta sanfrancisco abilene akron albany albuquerque detroit austin baltimore boston bend boise boulder denver buffalo charleston charlotte chattanooga chicago cleveland duluth eauclaire fargo fresno fairbanks anchorage eugene flagstaff flint gainesville honolulu houston indianapolis philadelphia ithaca jerseyshore jacksonville miami orlando tampa iowacity orangecounty lacrosse lubbock mankato louisville cincinnati littlerock lakeland lansing lasvegas phoenix maine nashville madison milwaukee neworleans newyork omaha pensacola ocala oregoncoast peoria prescott reno salem salina sanantonio slo roswell roseburg richmond rockford santabarbara savannah syracuse tallahassee toledo tucson tuscaloosa tyler valdosta vermont york yuma wausau wnatchee wichita wyoming ventura )
#Look Up Xsan
for city in ${cities[@]}
do
curl --silent "http://${city}.craigslist.org/search/cpg?query=xsan&catAbbreviation=cpg&addThree=&format=rss" | grep "item rdf:about=" | cut -c 18-100 | sed -e "s/\"//g" | sed -e "s/\>//g" >> /tmp/temp.txt
done
#Look Up Final Cut Server
for city in ${cities[@]}
do
curl --silent "http://${city}.craigslist.org/search/cpg?query=%22Final+Cut+Server%22&catAbbreviation=cpg&addThree=&format=rss" | grep "item rdf:about=" | cut -c 18-100 | sed -e "s/\"//g" | sed -e "s/\>//g" >> /tmp/temp.txt
done
#Look Up FileMaker
for city in ${cities[@]}
do
curl --silent "http://${city}.craigslist.org/search/cpg?query=FileMaker&catAbbreviation=cpg&addThree=&format=rss" | grep "item rdf:about=" | cut -c 18-100 | sed -e "s/\"//g" | sed -e "s/\>//g" >> /tmp/temp.txt
done
#Open lines in a browser
awk '{
#New clean up method
if ($0 in stored_lines)
   x=1
else
   print
   stored_lines[$0]=1
}' /temp/temp.txt > /temp/tempnew.txt
while read line; do open "$line"; done < /tmp/tempnew.txt
#Old clean up method
#sed '/pattern/d'