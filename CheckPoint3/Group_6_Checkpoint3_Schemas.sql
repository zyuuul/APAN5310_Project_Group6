-- Customers table
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    NumberOfVisits INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20),
    Address VARCHAR(255),
    LoyaltyMember BOOLEAN,
    Country VARCHAR(50),
    Region VARCHAR(50),
    City VARCHAR(50)
);

-- Airlines table
CREATE TABLE Airlines (
    AirlineID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

-- Flights table
CREATE TABLE Flights (
    FlightID SERIAL PRIMARY KEY,
    AirlineID INTEGER NOT NULL,
    Source VARCHAR(255) NOT NULL,
    Destination VARCHAR(255) NOT NULL,
    DepartureTime TIMESTAMP NOT NULL,
    ArrivalTime TIMESTAMP NOT NULL,
    Duration INTERVAL NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
);

-- Locations table
CREATE TABLE Locations (
    LocationID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL,
    PopularAttractions TEXT
);

-- Hotels table
CREATE TABLE Hotels (
    HotelID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    LocationID INTEGER UNIQUE NOT NULL,
    StarRating INTEGER NOT NULL,
    PricePerNight DECIMAL(10, 2) NOT NULL,
    RoomCapacity INT,
    ReviewScore DECIMAL(3, 2),
    ReviewCount INT,
    IsHostel BOOLEAN,
    ZoomType VARCHAR(255),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Car Rental Companies table
CREATE TABLE CarRentalCompanies (
    CompanyID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    ContactInfo VARCHAR(255)
);

-- Car Rentals table
CREATE TABLE CarRentals (
    RentalID SERIAL PRIMARY KEY,
    CompanyID INTEGER NOT NULL,
    CarModel VARCHAR(255) NOT NULL,
    LocationID INTEGER NOT NULL,
    PricePerDay DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CompanyID) REFERENCES CarRentalCompanies(CompanyID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Payment Information table
CREATE TABLE PaymentInformation (
    PaymentID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    CardDetails VARCHAR(19) NOT NULL,
    BillingAddress VARCHAR(255) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Flight Price Trends table
CREATE TABLE FlightPriceTrends (
    TrendID SERIAL PRIMARY KEY,
    Date DATE NOT NULL,
    FlightID INTEGER,
    Price DECIMAL(10, 2),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Hotel Price Trends table
CREATE TABLE HotelPriceTrends (
    TrendID SERIAL PRIMARY KEY,
    Date DATE NOT NULL,
    HotelID INTEGER,
    Price DECIMAL(10, 2),
    FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);

-- Car Rental Price Trends table
CREATE TABLE CarRentalPriceTrends (
    TrendID SERIAL PRIMARY KEY,
    Date DATE NOT NULL,
    RentalID INTEGER,
    Price DECIMAL(10, 2),
    FOREIGN KEY (RentalID) REFERENCES CarRentals(RentalID)
);

-- Travel Times table
CREATE TABLE TravelTimes (
    TimeID SERIAL PRIMARY KEY,
    LocationID INTEGER NOT NULL,
    BestTimeToTravel VARCHAR(255) NOT NULL,
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Flight Bookings table
CREATE TABLE FlightBookings (
    BookingID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    PaymentID INTEGER NOT NULL,
    FlightID INTEGER,
    AdultsCount INT,
    ChildrenCount INT,
    RoomsCount INT,
    BookingMade BOOLEAN,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (PaymentID) REFERENCES PaymentInformation(PaymentID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Hotel Bookings table
CREATE TABLE HotelBookings (
    BookingID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    PaymentID INTEGER NOT NULL,
    HotelID INTEGER,
    AdultsCount INT,
    ChildrenCount INT,
    RoomsCount INT,
    BookingMade BOOLEAN,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (PaymentID) REFERENCES PaymentInformation(PaymentID),
    FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);

-- Car Rental Bookings table
CREATE TABLE CarRentalBookings (
    BookingID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    PaymentID INTEGER NOT NULL,
    RentalID INTEGER,
    AdultsCount INT,
    ChildrenCount INT,
    RoomsCount INT,
    BookingMade BOOLEAN,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (PaymentID) REFERENCES PaymentInformation(PaymentID),
    FOREIGN KEY (RentalID) REFERENCES CarRentals(RentalID)
);
