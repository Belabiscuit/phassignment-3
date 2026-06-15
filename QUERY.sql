create table users (
  user_id int primary key not null,
  full_name varchar(50) not null,
  email varchar(50) unique not null,
  role varchar(20) check (role in ('Ticket Manager','Football Fan')),
  phone_number varchar(25)
);


create table matches (
  match_id int primary key not null,
  fixture varchar(50) not null,
  tournament_category varchar(100) not null,
  base_ticket_price decimal(10,2) not null check(base_ticket_price>=0) ,
  match_status varchar(20) not null 
  check(
  match_status in (
  'Available',
  'Selling Fast',
  'Sold Out',
  'Postponed'
  )
  )
);


create table bookings (
  booking_id int primary key,
  user_id int not null references users (user_id),
  match_id int not null  references matches (match_id),
  seat_number varchar(20),
  payment_status varchar(50) check (payment_status in ('Pending','Confirmed','Cancelled','Refunded')),
  total_cost decimal(10,2) not null check(total_cost >= 0)
);

insert into
  users (user_id, full_name, email, role, phone_number)
values
  (
    1,
    'Tanvir Rahman',
    'tanvir@mail.com',
    'Football Fan',
    '+8801711111111'
  ),
  (
    2,
    'Asif Haque',
    'asif@mail.com',
    'Football Fan',
    '+8801722222222'
  ),
  (
    3,
    'Sajjad Rahman',
    'sajjad@mail.com',
    'Ticket Manager',
    '+8801733333333'
  ),
  (
    4,
    'Jannat Ara',
    'jannat@mail.com',
    'Football Fan',
    NULL
  );

insert into
  matches (
    match_id,
    fixture,
    tournament_category,
    base_ticket_price,
    match_status
  )
values
  (
    101,
    'Real Madrid vs Barcelona',
    'Champions League',
    150.00,
    'Available'
  ),
  (
    102,
    'Man City vs Liverpool',
    'Premier League',
    120.00,
    'Selling Fast'
  ),
  (
    103,
    'Bayern Munich vs PSG',
    'Champions League',
    130.00,
    'Available'
  ),
  (
    104,
    'AC Milan vs Inter Milan',
    'Serie A',
    90.00,
    'Sold Out'
  ),
  (
    105,
    'Juventus vs Roma',
    'Serie A',
    80.00,
    'Available'
  );

insert into
  bookings (
    booking_id,
    user_id,
    match_id,
    seat_number,
    payment_status,
    total_cost
  )
values
  (501, 1, 101, 'A-12', 'Confirmed', 150.00),
  (502, 1, 102, 'B-04', 'Confirmed', 120.00),
  (503, 2, 101, 'A-13', 'Confirmed', 150.00),
  (504, 2, 101, NULL, NULL, 150.00),
  (505, 3, 102, 'C-20', 'Pending',120.00);


select
  match_id,
  fixture,
  round(base_ticket_price)
from
  matches
where
  tournament_category = 'Champions League'
  and match_status = 'Available'

select
  user_id,
  full_name,
  email
from
  users
where
  full_name ilike 'tanvir%'
  or full_name ilike '%haque';

select
  booking_id,
  user_id,
  match_id,
  coalesce(payment_status, 'Action Required') as systematic_status
from
  bookings
where
  payment_status is null

select
  booking_id,
  full_name,
  fixture,
  round(total_cost) as total_cost
from
  bookings
  inner join users on users.user_id = bookings.user_id
  inner join matches on matches.match_id = bookings.match_id

select
  users.user_id,
  full_name,
  booking_id
from
  users
  left join bookings using (user_id)


select
  booking_id,
  match_id,
  round(total_cost) as total_cost
from
  bookings
where
  total_cost > (
    select
      avg(total_cost)
    from
      bookings
  )

select
  match_id,
  fixture,
  round(base_ticket_price) as base_ticket_price
from
  matches
order by
  base_ticket_price desc
offset
  1
limit
  2




