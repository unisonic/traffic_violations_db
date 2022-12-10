USE GIBDD;
GO

CREATE TRIGGER new_violation ON Violation 
AFTER INSERT, UPDATE AS
BEGIN
	DECLARE @car INT, @vio_type INT, @vio_id INT;
	DECLARE @driver INT, @cost INT, @reduct INT, @time DATE, @duration INT;

    SELECT @vio_id = ID_Violation FROM inserted;
	SELECT @car = ID_Car FROM inserted;
	SELECT @vio_type = ID_ViolationType FROM inserted;
	SELECT @cost = Cost FROM ViolationType WHERE ID_ViolationType = @vio_type;

	SELECT @driver = ID_Driver FROM Car where ID_Car = @car;
	SELECT @reduct = ISNULL(SUM(Reduction), 0) FROM InsuranceReduction INNER JOIN CarInsurance
		ON CarInsurance.ID_Insurance = InsuranceReduction.ID_Insurance AND
			InsuranceReduction.ID_ViolationType = @vio_type AND 
			CarInsurance.ID_Car = @car;

	SELECT @time = Date FROM inserted;
	SELECT @duration = Duration FROM ViolationType WHERE ID_ViolationType = @vio_type;

    IF((SELECT COUNT(*) FROM Penalty WHERE ID_Violation = @vio_id) = 0)
	    INSERT INTO Penalty (ID_Driver, ID_Violation, Amount, Expiration) VALUES (@driver, @vio_id, @cost - @reduct, DATEADD(MONTH, @duration, @time));
    ELSE BEGIN
        UPDATE Penalty
            SET 
                ID_Driver = @driver, 
                Amount = @cost - @reduct, 
                Expiration = DATEADD(MONTH, @duration, @time)
            WHERE ID_Violation = @vio_id;
    END
END
GO