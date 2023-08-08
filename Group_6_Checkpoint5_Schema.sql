DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS car_rental_bookings;
DROP TABLE IF EXISTS hotel_bookings;
DROP TABLE IF EXISTS flight_bookings ;
DROP TABLE IF EXISTS user_preferences;
DROP TABLE IF EXISTS payment_information;
DROP TABLE IF EXISTS car_prices;
DROP TABLE IF EXISTS car_types;
DROP TABLE IF EXISTS rental_companies;
DROP TABLE IF EXISTS room_prices;
DROP TABLE IF EXISTS room_types;
DROP TABLE IF EXISTS hotels;
DROP TABLE IF EXISTS flight_prices;
DROP TABLE IF EXISTS airlines;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS locations;


-- locations table
CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255) NOT NULL
);

-- customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone_number CHAR(10),
    loyalty_degree INTEGER CHECK (loyalty_degree BETWEEN 1 AND 5) NOT NULL,
    customer_address INTEGER NOT NULL,
    FOREIGN KEY (customer_address) REFERENCES locations(location_id)
);

-- airlines table
CREATE TABLE airlines (
    airline_id SERIAL PRIMARY KEY,
    airline_name VARCHAR(255) NOT NULL
);

-- flight_price table
CREATE TABLE flight_prices (
    flight_id SERIAL PRIMARY KEY,
    airline_id INTEGER NOT NULL,
    depart_airport CHAR(3) NOT NULL,
    depart_location INTEGER NOT NULL,
    destin_airport CHAR(3) NOT NULL,
    destin_location INTEGER NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    duration INTERVAL NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
	discount_ratio DECIMAL(3, 2) NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    FOREIGN KEY (depart_location) REFERENCES locations(location_id),
    FOREIGN KEY (destin_location) REFERENCES locations(location_id)
);

-- hotels table
CREATE TABLE hotels (
    hotel_id SERIAL PRIMARY KEY,
    hotel_name VARCHAR(255) NOT NULL,
    hotel_address INTEGER NOT NULL,
    star_rating INTEGER NOT NULL,
    FOREIGN KEY (hotel_address) REFERENCES locations(location_id)
);

-- room_type table
CREATE TABLE room_types (
    room_type_id SERIAL PRIMARY KEY,
    room_type VARCHAR(255) NOT NULL UNIQUE,
    capacity INTEGER NOT NULL
);

-- room_price table
CREATE TABLE room_prices (
    hotel_id INTEGER,
    room_type_id INTEGER,
    price DECIMAL(10, 2),
    discount_ratio DECIMAL(3, 2),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id),
    FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id)
);

-- rental_company table
CREATE TABLE rental_companies (
    rental_company_id SERIAL PRIMARY KEY,
    rental_company_name VARCHAR(255) NOT NULL,
    rental_company_address INTEGER NOT NULL,
    FOREIGN KEY (rental_company_address) REFERENCES locations(location_id)
);

-- car_type table
CREATE TABLE car_types (
    car_type_id SERIAL PRIMARY KEY,
    car_type VARCHAR(255) NOT NULL,
    manufacturer VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL
);

CREATE TABLE car_prices (
    rental_company_id INTEGER,
    car_type_id INTEGER,
    price DECIMAL(10, 2),
    discount_ratio DECIMAL(3, 2),
    FOREIGN KEY (rental_company_id) REFERENCES rental_companies(rental_company_id),
    FOREIGN KEY (car_type_id) REFERENCES car_types(car_type_id)
);

-- payment_information table
CREATE TABLE payment_information (
    payment_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    card_details VARCHAR(19) NOT NULL,
    payment DECIMAL(10, 2) NOT NULL,
    billing_address INTEGER NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (billing_address) REFERENCES locations(location_id)
);

-- user_preferences table
CREATE TABLE user_preferences (
    customer_id INTEGER PRIMARY KEY,
    preferred_hotel_id INTEGER,
    preferred_car_model_id INTEGER,
    preferred_airline_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (preferred_hotel_id) REFERENCES hotels(hotel_id),
    FOREIGN KEY (preferred_car_model_id) REFERENCES car_types(car_type_id),
    FOREIGN KEY (preferred_airline_id) REFERENCES airlines(airline_id)
);

-- flight_bookings table
CREATE TABLE flight_bookings (
    booking_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    payment_id INTEGER NOT NULL,
    flight_id INTEGER,
    adults_count INTEGER,
    children_count INTEGER,
    booking_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (payment_id) REFERENCES payment_information(payment_id),
    FOREIGN KEY (flight_id) REFERENCES flight_prices(flight_id)
);

-- hotel_bookings table
CREATE TABLE hotel_bookings (
    booking_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    payment_id INTEGER NOT NULL,
    hotel_id INTEGER,
    room_type INTEGER,
    adults_count INTEGER,
    children_count INTEGER,
    check_in_date DATE,
    check_out_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (payment_id) REFERENCES payment_information(payment_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id),
    FOREIGN KEY (room_type) REFERENCES room_types(room_type_id)
);

-- car_rental_bookings table
CREATE TABLE car_rental_bookings (
    booking_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    payment_id INTEGER NOT NULL,
    rental_company_id INTEGER,
    car_type INTEGER,
    adults_count INTEGER,
    children_count INTEGER,
    booking_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (payment_id) REFERENCES payment_information(payment_id),
    FOREIGN KEY (rental_company_id) REFERENCES rental_companies(rental_company_id),
    FOREIGN KEY (car_type) REFERENCES car_types(car_type_id)
);

-- reviews table
CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    hotel_booking_id INTEGER,
    car_rental_booking_id INTEGER,
    flight_booking_id INTEGER,
    date DATE NOT NULL,
    review_text TEXT,
    review_score DECIMAL(2,1) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (hotel_booking_id) REFERENCES hotel_bookings(booking_id),
    FOREIGN KEY (car_rental_booking_id) REFERENCES car_rental_bookings(booking_id),
    FOREIGN KEY (flight_booking_id) REFERENCES flight_bookings(booking_id)
);