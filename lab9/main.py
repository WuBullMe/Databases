import psycopg2
from login_req import *
from geopy.geocoders import Nominatim


def main():
    con = psycopg2.connect(database=DATABASE_NAME, user=USER,
                       password=PASSWORD, host=HOST, port=PORT)
    cursor = con.cursor()
    cursor.callproc('get_addresses_with_11')
    rows = cursor.fetchall()

    geolocator = Nominatim(user_agent="lab")
    for row in rows:
        address_id, city, address = row
        try:
            location = geolocator.geocode(f'{address}')
            lat, lon = (location.latitude, location.longitude)
        except:
            lat, lon = 0, 0

        cursor.execute(
            "UPDATE address SET latitude = %s, longitude = %s WHERE address_id = %s",
            (lat, lon, address_id)
        )

        print(address_id, '|',  address, (lat, lon))

    con.commit()
    cursor.close()
    con.close()

if __name__ == '__main__':
    main()