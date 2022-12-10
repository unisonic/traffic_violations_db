INSERT INTO Driver
VALUES ('Artem Levshin', 'male', 20),
		('Anna Karenina', 'female', 30),
		('Alexander Pushkin', 'male', 40);

INSERT INTO Car
VALUES (1, 'Toyota'), (2, 'Nissan'), (3, 'Reno'),
		(1, 'Honda'), (3, 'Mazda'), (2, 'Ferrari');

INSERT INTO Insurance
VALUES ('Casco'), ('Osago'), ('Indigo'), ('Cian');

INSERT INTO CarInsurance
VALUES (1, 1), (1, 2), (1, 3),
		(2, 2), (2, 3), (2, 4),
		(3, 1), (3, 2), (3, 4);

INSERT INTO ViolationType
VALUES ('overspeed', 500, 6), ('crosslane', 700, 4), ('nolicense', 2000, 2);

INSERT INTO InsuranceReduction
VALUES (1, 1, 250), (1, 2, 150), (1, 3, 100), 
		(2, 1, 123), (2, 2, 435), (2, 3, 50), 
		(3, 1, 203), (3, 2, 143), (3, 3, 32), 
		(4, 1, 134), (4, 2, 321), (4, 3, 113); 

insert into Violation (ID_Car, ID_ViolationType) values 
	(1, 1);

insert into Violation (ID_Car, ID_ViolationType) values 
	(1, 3);

insert into Violation (ID_Car, ID_ViolationType) values 
	(2, 1);

insert into Violation (ID_Car, ID_ViolationType) values 
	(2, 3);

insert into Violation (ID_Car, ID_ViolationType) values 
	(3, 1);

insert into Violation (ID_Car, ID_ViolationType) values 
	(3, 3);

delete from Violation;

select * from Violation
select * from Penalty
select * from Overall