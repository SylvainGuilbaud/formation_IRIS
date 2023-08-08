Class python.geo
{

// Parameter ADDRESSES = "Kortenberg,Helmond,Ratingen,Sevilla,London,18 RUE JACQUELINE AURIOL 78280 GUYANCOURT,San Martino In Rio,Prague, Hvidovre, Gdansk, Bucharest, Shangai,Taipei, Gyeonggi-do, Adelaide,Canada,Roseville,Santiago,Sao Paolo";

// Parameter ADDRESSES = "20 avenue Andre Prothin 92400 Courbevoie,Abidjan,Kortenberg,Helmond,Ratingen,Sevilla,London,18 RUE JACQUELINE AURIOL 78280 GUYANCOURT,San Martino In Rio,Prague, Hvidovre, Gdansk, Bucharest, Shangai,Taipei, Gyeonggi-do, Adelaide,Canada,Roseville,Santiago,Sao Paolo";

Parameter ADDRESSES = "20 avenue Andre Prothin 92400 Courbevoie";

Parameter LOCATIONMAP = "/data/locations_map.html";

ClassMethod test() As %Status
{
        Set sc = $$$OK
        
        set sc = ..MarkGeoDetails(..#ADDRESSES,..#LOCATIONMAP)

        write "Look at results in "_..#LOCATIONMAP,!

        Return sc
}

ClassMethod MarkGeoDetails(addr As %String, filepath As %String) As %Status [ Language = python ]
{
    import folium
    import sys
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
    	print("Not able to write to a file Unexpected error:", sys.exc_info()[0])
}

ClassMethod getAddress(addr As %String) As %String [ Language = python ]
{
    import geopy
    geolocator = geopy.Nominatim(user_agent="Embedded Python")
    address = geolocator.geocode(addr)
    #; print(flatiron.address)
    return address.address
}

/// Description
ClassMethod distance() As %Numeric [ Language = python ]
{
    from geopy import distance
    newport_ri = (41.49008, -71.312796)
    cleveland_oh = (41.499498, -81.695391)
    return distance.distance(newport_ri, cleveland_oh).miles
}

/// Description
ClassMethod distanceOS() As %String
{
    Set sc = $$$OK 
    set builtins = ##class(%SYS.Python).Builtins()
    
    set newport = builtins.list()
    
    do newport.append(41.49008)
    
    do newport.append(-71.312796)
    
    set cleveland = builtins.list()
    
    do cleveland.append(41.499498)
    
    do cleveland.append(-81.695391)

    #; zwrite newport
    #; newport=11@%SYS.Python  ; [41.49008, -71.312796]  ; <OREF>

    #; zwrite cleveland
    #; cleveland=11@%SYS.Python  ; [41.499498, -81.695391]  ; <OREF>

    set distance = $system.Python.Import("geopy.distance")
    
    set route = distance.distance(newport, cleveland)

    write $num(route.miles,4) _ " miles between Newport and Cleveland" 
    #; 538.3904453677205311
    Return sc
}

}
