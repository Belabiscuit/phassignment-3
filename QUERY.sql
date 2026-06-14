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
