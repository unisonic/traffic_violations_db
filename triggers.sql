USE GIBDD;
GO

CREATE TRIGGER update_violation ON Violation
AFTER INSERT, UPDATE AS
BEGIN
	INSERT INTO Penalty SELECT (SELECT ID_Driver FROM Car WHERE ID_Car = a.ID_Car), ID_Violation, 0, '01.01.2000' FROM inserted a WHERE a.ID_Violation NOT IN (SELECT (ID_Violation) FROM Penalty);
	UPDATE Penalty
	SET
		ID_Driver = (SELECT ID_Driver FROM Car WHERE ID_Car = b.ID_Car),
		Amount = (SELECT Cost FROM ViolationType WHERE ID_ViolationType = b.ID_ViolationType) - 
				(SELECT ISNULL(SUM(Reduction), 0) FROM InsuranceReduction INNER JOIN CarInsurance
				ON CarInsurance.ID_Insurance = InsuranceReduction.ID_Insurance AND 
					InsuranceReduction.ID_ViolationType = b.ID_ViolationType AND
					CarInsurance.ID_Car = b.ID_Car),
		Expiration = DATEADD(MONTH, (SELECT Duration FROM ViolationType WHERE ID_ViolationType = b.ID_ViolationType), b.Date)
	FROM Penalty a INNER JOIN inserted b ON a.ID_Violation = b.ID_Violation;
END
GO

CREATE TRIGGER del_violation on Violation
AFTER DELETE AS
BEGIN 
    DELETE FROM Penalty WHERE ID_Violation IN (SELECT ID_Violation FROM deleted);
END
GO

CREATE TRIGGER change_penalty ON Penalty
AFTER INSERT, UPDATE, DELETE AS
BEGIN
    UPDATE Overall
        SET cnt = cnt - tmp.fieldcount, debt = debt - tmp.fieldsum
		FROM Overall INNER JOIN (SELECT ID_Driver, ISNULL(COUNT(ID_Driver), 0) AS fieldcount, ISNULL(SUM(Amount), 0) AS fieldsum FROM deleted GROUP BY ID_Driver)
			AS tmp ON Overall.ID_Driver = tmp.ID_Driver;
    UPDATE Overall
        SET cnt = cnt + tmp.fieldcount, debt = debt + tmp.fieldsum
		FROM Overall INNER JOIN (SELECT ID_Driver, ISNULL(COUNT(ID_Driver), 0) AS fieldcount, ISNULL(SUM(Amount), 0) AS fieldsum FROM inserted GROUP BY ID_Driver)
			AS tmp ON Overall.ID_Driver = tmp.ID_Driver;
END
GO

CREATE TRIGGER new_driver ON Driver
AFTER INSERT AS 
BEGIN 
	INSERT INTO Overall (ID_Driver) SELECT (ID_Driver) FROM inserted;
END