Class python.geo
{

ClassMethod MarkGeoDetails(addr As %String, filepath As %String) As %Status [ Language = python ]
{
    import folium
    from geopy.geocoders import Nominatim
    
    geolocator = Nominatim(user_agent="IrisGeoMap")
    #split address in order to mark on the map
    locs = addr.split(",")
    if len(locs) == 0:
    	print("Please enter address")
    elif len(locs) == 1:
    	location = geolocator.geocode(locs[0])
    	point = location.point
    	m = folium.Map(location=[point.latitude,point.longitude], tiles="OpenStreetMap", zoom_start=10)
    else:
    	m = folium.Map(location=[20,0], tiles="OpenStreetMap", zoom_start=3)
    
    for loc in locs:
    	try:
    		location = geolocator.geocode(loc)
    		point = location.point
    		folium.Marker(
	    			location=[point.latitude,point.longitude],
	    	  		popup=addr,
	    		).add_to(m)    		
    	except:
    		print("Not able to find location : ",loc) 
    		  
    map_html = m._repr_html_()
    iframe = m.get_root()._repr_html_()
    fullHtml = """
      	     <!DOCTYPE html>
        	    <html>
        	        <head></head>
        	        <body> """
    fullHtml = fullHtml + iframe            
    fullHtml = fullHtml + """                                             
       	        </body>
        	    </html>
    """
    
    try:
    	f = open(filepath, "w")
    	f.write(fullHtml)
    	f.close()
    except:
    	print("Not able to write to a file")
}

}
