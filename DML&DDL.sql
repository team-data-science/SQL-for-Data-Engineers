CREATE TABLE Band (
ArtistId INT,
LeadSinger TEXT,
YearStart INT,
YearEnd INT
);

INSERT INTO Band VALUES (22, 'Robert Plant', 1968, 1980);

INSERT INTO Band (ArtistId, LeadSinger, YearStart, YearEnd) VALUES
(50,'James Hetfield',1981,2024),
(51,'Freddie Mercury',1970,1991),
(52,'Paul Stanley and Gene Simmons',1973,2024),
(110,'Kurt Cobain',1987,1994),
(120,'David Gilmour and Roger Waters',1965,1995),
(127,'Anthony Kiedis',1983,2024),
(140,'Jim Morrison',1965,1971),
(179,'Klaus Meine',1965,2024),
(187,'Marcelo Camelo',1997,2007);

CREATE table Band_copy (
ArtistId INT,
LeadSinger TEXT,
YearStart INT,
YearEnd INT
);

INSERT INTO Band_copy (ArtistId, LeadSinger, YearStart, YearEnd)
SELECT *
FROM Band;

DROP table Band;

CREATE TABLE Band (
ArtistId INT,
LeadSinger TEXT,
YearStart NOT NULL,
YearEnd INT
);

INSERT INTO Band (ArtistId, LeadSinger, YearEnd) VALUES
(22, 'Robert Plant', 1980),
(50,'James Hetfield',2024),
(51,'Freddie Mercury',1991),
(52,'Paul Stanley and Gene Simmons',2024),
(110,'Kurt Cobain',1994),
(120,'David Gilmour and Roger Waters',1995),
(127,'Anthony Kiedis',2024),
(140,'Jim Morrison',1971),
(179,'Klaus Meine',2024),
(187,'Marcelo Camelo',2007);

DROP table Band;

CREATE TABLE Band (
ArtistId INT,
LeadSinger TEXT UNIQUE,
YearStart INT,
YearEnd INT
);

INSERT INTO Band (ArtistId, LeadSinger, YearStart, YearEnd) VALUES
(22, 'Robert Plant', 1968, 1980),
(50,'Jim Morrison',1981,2024),
(51,'Freddie Mercury',1970,1991),
(52,'Paul Stanley and Gene Simmons',1973,2024),
(110,'Kurt Cobain',1987,1994),
(120,'David Gilmour and Roger Waters',1965,1995),
(127,'Anthony Kiedis',1983,2024),
(140,'Jim Morrison',1965,1971),
(179,'Klaus Meine',1965,2024),
(187,'Marcelo Camelo',1997,2007);

DROP table Band;

CREATE TABLE Band (
ArtistId INT PRIMARY KEY,
LeadSinger TEXT,
YearStart INT,
YearEnd INT
);

INSERT INTO Band (ArtistId, LeadSinger, YearStart, YearEnd) VALUES
(22, 'Robert Plant', 1968, 1980),
(22, 'Robert Plant', 1968, 1980),
(50,'James Hetfield',1981,2024),
(51,'Freddie Mercury',1970,1991),
(52,'Paul Stanley and Gene Simmons',1973,2024),
(110,'Kurt Cobain',1987,1994),
(120,'David Gilmour and Roger Waters',1965,1995),
(127,'Anthony Kiedis',1983,2024),
(140,'Jim Morrison',1965,1971),
(179,'Klaus Meine',1965,2024),
(187,'Marcelo Camelo',1997,2007);

INSERT INTO Band (ArtistId, LeadSinger, YearStart, YearEnd) VALUES
(22, 'Robert Plant', 1968, 1980),
(50,'James Hetfield',1981,2024),
(51,'Freddie Mercury',1970,1991),
(52,'Paul Stanley and Gene Simmons',1973,2024),
(110,'Kurt Cobain',1987,1994),
(120,'David Gilmour and Roger Waters',1965,1995),
(127,'Anthony Kiedis',1983,2024),
(140,'Jim Morrison',1965,1971),
(179,'Klaus Meine',1965,2024),
(187,'Marcelo Camelo',1997,2007);

ALTER TABLE Artist ADD COLUMN BandFlag TEXT;

update Artist set BandFlag='1' where ArtistId=1;
update Artist set BandFlag='1' where ArtistId=22;
update Artist set BandFlag='1' where ArtistId=50;
update Artist set BandFlag='1' where ArtistId=51;
update Artist set BandFlag='1' where ArtistId=52;
update Artist set BandFlag='1' where ArtistId=110;
update Artist set BandFlag='1' where ArtistId=120;
update Artist set BandFlag='1' where ArtistId=127;
update Artist set BandFlag='1' where ArtistId=140;
update Artist set BandFlag='1' where ArtistId=179;
update Artist set BandFlag='1' where ArtistId=187;

DELETE FROM Band
WHERE ArtistId=22; 

CREATE VIEW customer_v as 
SELECT CustomerId,
       FirstName || ' ' || c.LastName AS CustomerName,
       Company,
       Address,
       City,
       State,
       Country,
       PostalCode,
       Phone,
       Fax,
       Email from Customer;