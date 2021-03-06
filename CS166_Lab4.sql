--University Library Database--

DROP TABLE IF EXISTS Students CASCADE;
CREATE TABLE Students (stid NUMERIC (9, 0),
			stname CHAR(20),
			major CHAR(20),
			age INTEGER,
			PRIMARY KEY(stid));

INSERT INTO Students (stid, stname, major, age)
VALUES (862342342, 'Lauren Sinclair', 'CS', 22);
INSERT INTO Students (stid, stname, major, age)
VALUES (862324567, 'Kieran White', 'Art', 24);
INSERT INTO Students (stid, stname, major, age)
VALUES (862789789, 'William Hawkes', 'CS', 23);
INSERT INTO Students (stid, stname, major, age)
VALUES (862456678, 'Oda Sakunosuke', 'Forensics', 32);

DROP TABLE IF EXISTS Books CASCADE;
CREATE TABLE Books (docid NUMERIC (9, 0),
			title CHAR(40),
			publisher CHAR(20),
			year INTEGER,
			PRIMARY KEY(docid));

INSERT INTO Books (docid, title, publisher, year)
VALUES (225200414, 'No Longer Human', 'McGraw-Hill', 1948);
INSERT INTO Books (docid, title, publisher, year)
VALUES (225200928, 'Beast Under the Moonlight', 'Penguin', 1956);
INSERT INTO Books (docid, title, publisher, year)
VALUES (225200972, 'How to Math', 'McGraw-Hill', 2010);

DROP TABLE IF EXISTS Authors CASCADE;
CREATE TABLE Authors (aname CHAR(20),
			address CHAR(40),
			PRIMARY KEY(aname));

INSERT INTO Authors (aname, address)
VALUES ('Dazai Osamu', '1123 Kyoto, Japan');
INSERT INTO Authors (aname, address)
VALUES ('Atsushi', '2357 Davis, California');
INSERT INTO Authors (aname, address)
VALUES ('Jones', '7121 Davis, California');

DROP TABLE IF EXISTS Descriptions CASCADE;
CREATE TABLE Descriptions (keyword CHAR(10),
				PRIMARY KEY(keyword));

INSERT INTO Descriptions (keyword)
VALUES ('math');
INSERT INTO Descriptions (keyword)
VALUES ('health');
INSERT INTO Descriptions (keyword)
VALUES ('moon');
INSERT INTO Descriptions (keyword)
VALUES ('database');


DROP TABLE IF EXISTS borrows CASCADE;
CREATE TABLE borrows (docid NUMERIC (9, 0),
			stid NUMERIC (9, 0),
			bdate CHAR(10),
			PRIMARY KEY(docid, stid),
			FOREIGN KEY (docid) REFERENCES Books(docid),
			FOREIGN KEY (stid) REFERENCES Students(stid));

INSERT INTO borrows (docid, stid, bdate)
VALUES (225200414, 862456678, '09/31/1988');
INSERT INTO borrows (docid, stid, bdate)
VALUES (225200928, 862342342, '12/25/1980');

DROP TABLE IF EXISTS has_written CASCADE;
CREATE TABLE has_written (docid NUMERIC (9, 0),
			aname CHAR(20),
			PRIMARY KEY (docid, aname),
			FOREIGN KEY (docid) REFERENCES Books(docid),
			FOREIGN KEY (aname) REFERENCES Authors(aname));

INSERT INTO has_written (docid, aname)
VALUES (225200414, 'Dazai Osamu');
INSERT INTO has_written (docid, aname)
VALUES (225200928, 'Jones'); --'Atsushi');
INSERT INTO has_written (docid, aname)
VALUES (225200972, 'Jones');

DROP TABLE IF EXISTS describes CASCADE;
CREATE TABLE describes (docid NUMERIC (9, 0),
			keyword CHAR(10),
			PRIMARY KEY (docid, keyword),
			FOREIGN KEY (docid) REFERENCES Books(docid),
			FOREIGN KEY (keyword) REFERENCES Descriptions(keyword));


INSERT INTO describes (docid, keyword)
VALUES (225200972, 'math');
INSERT INTO describes (docid, keyword)
VALUES (225200414, 'health');
INSERT INTO describes (docid, keyword)
VALUES (225200928, 'database');

--1--
SELECT B.year, B.title
FROM Books B;

--2--
SELECT *
FROM Students S
WHERE S.major='CS';

--3--
SELECT *
FROM Books B, Students S;

--4--
SELECT B.publisher, B.year
FROM Books B
WHERE B.publisher='McGraw-Hill' AND B.year<1990;

--5--
SELECT A.aname
FROM Authors A
WHERE A.Address LIKE '%Davis%';

--6--
SELECT S.stname
FROM Students S
WHERE S.age>30 AND S.major!='CS';

--7--
SELECT A.aname AS name
FROM Authors A;

--8--
SELECT S.stname
FROM Students S, borrows B
WHERE S.stid = B.stid AND S.major='CS';

--9--
SELECT B.title
FROM Books B, has_written H
WHERE B.docid = H.docid AND H.aname='Jones';

--10--
SELECT B.title
FROM Books B, has_written H, describes D
WHERE B.docid = H.docid AND B.docid = D.docid AND H.aname='Jones' AND D.keyword!='database';

--11--
SELECT S.stname
FROM Students S
WHERE S.age = (SELECT MIN(S2.age)
		FROM Students S2);

--12--
SELECT B.title
FROM Books B
WHERE B.year = (SELECT MIN(B2.year)
		FROM Books B2);

