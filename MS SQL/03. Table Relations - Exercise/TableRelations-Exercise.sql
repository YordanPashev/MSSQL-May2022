--1--
CREATE TABLE [Persons](
			 [PersonID] INT NOT NULL
			 , [FirstName] NVARCHAR (50) NOT NULL
			 , [Salary] DECIMAL NOT NULL
			 , [PassportID] INT UNIQUE NOT NULL
)

CREATE TABLE [Passports](
			 [PassportID] INT NOT NULL
			 , [PassportNumber] NVARCHAR (20) NOT NULL
)
	ALTER TABLE [Persons]
 ADD CONSTRAINT PK_PersonID 
    PRIMARY KEY ([PersonID]) 

	ALTER TABLE [Passports]
 ADD CONSTRAINT PK_PassportID 
    PRIMARY KEY ([PassportID])

	ALTER TABLE [Persons]
 ADD CONSTRAINT FK_PassportID
    FOREIGN KEY ([PassportID])
	 REFERENCES [Passports]([PassportID])

INSERT INTO [Passports]([PassportID], [PassportNumber])
	 VALUES
			(101, 'N34FG21B')
			, (102, 'K65LO4R7')
			, (103, 'ZE657QP2')
		

INSERT INTO [Persons]([PersonID], [FirstName], [Salary], PassportID)
	 VALUES	
			(1, 'Roberto', ROUND(43300, 2), '102')
			, (2, 'Tom', ROUND(56100, 2), '103')			
			, (3, 'Yana', ROUND(60200, 2), '101')

--2--

CREATE TABLE [Manufacturers](
			 [ManufacturerID] INT NOT NULL
			 , [Name] NVARCHAR (50)
			 , [EstablishedOn]  DATE
)

CREATE TABLE [Models](
			 [ModelID] INT UNIQUE NOT NULL
			 , [Name] NVARCHAR (50)
			 , [ManufacturerID]  INT NOT NULL
)

INSERT INTO [Manufacturers]([ManufacturerID],[Name], [EstablishedOn])
	 VALUES
			(1, 'BMW', '07/03/1916')
			, (2, 'Tesla', '01/01/2003')
			, (3, 'Lada', '01/05/1966')

INSERT INTO [Models](ModelID, [Name], [ManufacturerID])
	 VALUES
			(101, 'X1', 1)
			, (102, 'i6', 1)
			, (103, 'Model S', 2)
			, (104, 'Model X', 2)
			, (105, 'Model 3', 2)
			, (106, 'Nova', 3)

	ALTER TABLE [Manufacturers]
 ADD CONSTRAINT PK_ManufacturerID
    PRIMARY KEY ([ManufacturerID]) 

		ALTER TABLE [Models]
 ADD CONSTRAINT PK_ModelID
    PRIMARY KEY ([ModelID]) 

	ALTER TABLE [Models]
 ADD CONSTRAINT FK_ModelManufacturers
	FOREIGN KEY ([ManufacturerID]) REFERENCES [Manufacturers]([ManufacturerID])
--3--

CREATE TABLE [Students](
			 [StudentID] INT PRIMARY KEY IDENTITY (1, 1) 
			 , [Name] NVARCHAR (50)
)

CREATE TABLE [Exams](
			 [ExamID] INT PRIMARY KEY IDENTITY (101, 1)
			 , [Name] NVARCHAR (50)
)

CREATE TABLE [StudentsExams](
			 [StudentID] INT 
			 , [ExamID] INT
			 , PRIMARY KEY ([StudentID], [ExamID])
			 , FOREIGN KEY ([StudentID]) REFERENCES [Students]([StudentID])
			 , FOREIGN KEY ([ExamID]) REFERENCES [Exams]([ExamID])
)

INSERT INTO [Students]([Name])
	 VALUES
			('Mila')
			, ('Toni')
			, ('Rom')

INSERT INTO [Exams]([Name])
	 VALUES
			('SpringMVC')
			, ('Neo4j')
			, ('Oracle 11g')

INSERT INTO [StudentsExams]([StudentID], [ExamID])
	 VALUES
			(1, 101)
			, (1, 102)
			, (2, 101)
			, (3, 103)
			, (2, 102)
			, (2, 103)
--4--

  CREATE TABLE [Teachers](
			   [TeacherID] INT PRIMARY KEY IDENTITY (101, 1)
			   , [Name] NVARCHAR (50) NOT NULL
			   , [ManagerID] INT FOREIGN KEY ([ManagerID]) REFERENCES [Teachers]([TeacherID])
)

   INSERT INTO [Teachers]([Name], [ManagerID])
	    VALUES
			   ('John', NULL)
			   , ('Maya', 106)
			   , ('Silvia', 106)
			   , ('Ted', 105)
			   , ('Mark', 101)
			   , ('Greta', 101)
--5--

CREATE TABLE [Cities](
			 [CityID] INT PRIMARY KEY
			 , [Name] NVARCHAR (50) NOT NULL
)

CREATE TABLE [Customers](
			 [CustomerID] INT PRIMARY KEY
			 , [Name] NVARCHAR (50) NOT NULL
			 , [Birthday] DATE
			 , [CityID] INT FOREIGN KEY ([CityID]) REFERENCES [Cities]([CityID]) NOT NULL
)

CREATE TABLE [ItemTypes](
			 [ItemTypeID] INT PRIMARY KEY
			 , [Name] NVARCHAR (50)
)

CREATE TABLE [Items](
			 [ItemID] INT PRIMARY KEY
			 , [Name] NVARCHAR (50) 
			 , [ItemTypeID] INT FOREIGN KEY ([ItemTypeID]) REFERENCES [ItemTypes]([ItemTypeID])
)

CREATE TABLE [Orders](
			 [OrderID] INT PRIMARY KEY 
			 , [CustomerID] INT FOREIGN KEY ([CustomerID]) REFERENCES [Customers]([CustomerID])
)

CREATE TABLE [OrderItems](
			 [OrderID] INT  FOREIGN KEY ([OrderID]) REFERENCES [Orders]([OrderID])
			 , [ItemID] INT FOREIGN KEY ([ItemID]) REFERENCES [Items]([ItemID])
			 , PRIMARY KEY ([OrderID], [ItemID])
)

--6--

CREATE TABLE [Majors](
			 [MajorID] INT PRIMARY KEY
			 , [Name] NVARCHAR (50) NOT NULL
) 

CREATE TABLE [Subjects](
			 [SubjectID] INT PRIMARY KEY
			 , [SubjectName] NVARCHAR (50) NOT NULL
)

CREATE TABLE [Students](
			 [StudentID] INT PRIMARY KEY
			 , [StudentNumber] INT NOT NULL
			 , [StudentName] NVARCHAR (50) NOT NULL
			 , [MajorID] INT FOREIGN KEY REFERENCES [Majors]([MajorID])
)

CREATE TABLE [Agenda](
			 [StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID])
			 , [SubjectID] INT FOREIGN KEY REFERENCES [Subjects]([SubjectID])
			 , PRIMARY KEY ([StudentID], [SubjectID])
)

CREATE TABLE [Payments](
			 [PaymentID] INT PRIMARY KEY
			 , [PaymentDate] DATE
			 , [PaymentAmount] DECIMAL (6, 2)
			 , [StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID])
)

--9--

  SELECT m.[MountainRange]
	     , p.[PeakName]
	     , p.[Elevation]
    FROM [Peaks] AS p 
    JOIN [Mountains] as m ON m.[Id] = p.[MountainId]
     AND m.MountainRange = 'Rila'
ORDER BY p.[Elevation] DESC
