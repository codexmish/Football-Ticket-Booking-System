-- table create
CREATE TABLE Users (
    user_id serial primary key,
    full_name varchar(100),
    email varchar(100) unique not null,
    role varchar(20) CHECK (role IN ('Ticket Manager', 'Football Fan')),
    phone_number varchar(15)
);



CREATE TABLE Matches (
    match_id serial primary key,
    fixture varchar(100),
    tournament_category varchar(100),
    base_ticket_price decimal(10,2) CHECK (base_ticket_price >= 0),
    match_status varchar(20) CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);


CREATE TABLE Bookings (
    booking_id serial primary key,
    user_id int references users(user_id),
    match_id int references matches(match_id),
    seat_number varchar(20),
    payment_status varchar(20) CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost decimal(10,2) CHECK (total_cost >= 0)
);