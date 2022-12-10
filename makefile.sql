
/*
DROP TABLE IF EXISTS InsuranceReduction;
DROP TABLE IF EXISTS CarInsurance;
DROP TABLE IF EXISTS Penalty;
DROP TABLE IF EXISTS Violation;
DROP TABLE IF EXISTS ViolationType;
DROP TABLE IF EXISTS Car;
DROP TABLE IF EXISTS Driver;
DROP TABLE IF EXISTS Insurance;
*/

DROP DATABASE IF EXISTS GIBDD;
CREATE DATABASE GIBDD;
go

use GIBDD;

CREATE TABLE Driver(
    ID_Driver INT NOT NULL IDENTITY (1, 1), 
    Fullname NVARCHAR(50) NOT NULL, 
    Gender NVARCHAR(6) NOT NULL, 
    Age INT NOT NULL,
    CONSTRAINT PK_Driver PRIMARY KEY (ID_Driver)
);

CREATE TABLE Car(
    ID_Car INT NOT NULL IDENTITY (1, 1), 
    ID_Driver INT NOT NULL,
    Mark NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Car PRIMARY KEY (ID_Car),
    CONSTRAINT FK_Car_Driver FOREIGN KEY (ID_Driver) REFERENCES Driver(ID_Driver) ON DELETE CASCADE
);

CREATE TABLE Insurance(
    ID_Insurance INT NOT NULL IDENTITY (1, 1),
    Company NVARCHAR(10) NOT NULL,
    CONSTRAINT PK_Insurance PRIMARY KEY (ID_Insurance)
);

CREATE TABLE Penalty(
    ID_Penalty INT NOT NULL IDENTITY (1, 1),
    ID_Driver INT NOT NULL,
    Amount INT NOT NULL,
    Expiration DATE NOT NULL DEFAULT '01.01.2022',
    CONSTRAINT PK_Penalty PRIMARY KEY (ID_Penalty),
    CONSTRAINT FK_Penalty_Driver FOREIGN KEY (ID_Driver) REFERENCES Driver(ID_Driver) ON DELETE CASCADE
);

CREATE TABLE ViolationType(
    ID_ViolationType INT NOT NULL IDENTITY (1, 1), 
    Description NVARCHAR(100) NOT NULL, 
    Cost INT NOT NULL,
    CONSTRAINT PK_ViolationType PRIMARY KEY (ID_ViolationType)
);

CREATE TABLE Violation(
    ID_Violation INT NOT NULL IDENTITY (1, 1),    
    ID_Car INT NOT NULL,
    ID_ViolationType INT NOT NULL, 
    Date DATE NOT NULL DEFAULT '01.01.2000', 
    Location NVARCHAR(50) NOT NULL DEFAULT 'Tverskaya Street', 
    CONSTRAINT PK_Violation PRIMARY KEY(ID_Violation),
    CONSTRAINT FK_Violation_Car FOREIGN KEY (ID_Car) REFERENCES Car(ID_Car) ON DELETE CASCADE,
    CONSTRAINT FK_Violation_ViolationType FOREIGN KEY (ID_ViolationType) REFERENCES ViolationType(ID_ViolationType) ON DELETE CASCADE
);

CREATE TABLE CarInsurance(
    ID_Car INT NOT NULL,
    ID_Insurance INT NOT NULL,
    CONSTRAINT FK_CarInsurance_Car FOREIGN KEY (ID_Car) REFERENCES Car(ID_Car) ON DELETE CASCADE,
    CONSTRAINT FK_CarInsurance_Company FOREIGN KEY (ID_Insurance) REFERENCES Insurance(ID_Insurance) ON DELETE CASCADE
);

CREATE TABLE InsuranceReduction(
    ID_Insurance INT NOT NULL,
    ID_ViolationType INT NOT NULL,
    Reduction INT NOT NULL,
    CONSTRAINT FK_InsuranceReduction_Insurance FOREIGN KEY (ID_Insurance) REFERENCES Insurance(ID_Insurance) ON DELETE CASCADE,
    CONSTRAINT FK_InsuranceReduction_ViolationType FOREIGN KEY (ID_ViolationType) REFERENCES ViolationType(ID_ViolationType) ON DELETE CASCADE,
);