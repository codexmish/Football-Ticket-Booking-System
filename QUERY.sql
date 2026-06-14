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


-- data inset
INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);


INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);





--query 1
select match_id, fixture, base_ticket_price from matches
where tournament_category = 'Champions League' and match_status = 'Available'



--query 2
select user_id, full_name, email from users
where full_name ilike 'Tanvir%' or full_name ilike '%Haque%'


--query 3
select booking_id, user_id, match_id, coalesce(payment_status, 'Action Required') as systematic_status from bookings
where payment_status is null


--query 4
select booking_id, full_name, fixture, total_cost from bookings as b
inner join users as u on b.user_id = u.user_id
inner join matches as m on b.match_id = m.match_id