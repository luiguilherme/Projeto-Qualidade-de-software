public class BrazilianUrbanPropertyAddressTO {
           
    public class BrazilianUrbanPropertyAddress {
        public String id;
        public String freeText;
        public String country;
        public String city;
        public String stateOrProvince;
        public String locality;
        public String postcode;
        public String streetType;
        public String streetName;
        public String streetNrFirst;
        public GeographicLocation geographicLocation;
        public String systemOriginator;
        public String database;
    }
     
     public BrazilianUrbanPropertyAddress brazilianUrbanPropertyAddress;
     
     public class GeographicLocation {
         public GeoJson geoJson;
     }
     
     public class GeoJson {
         public String type;
         public List<String> coordinates;
     } 
 }