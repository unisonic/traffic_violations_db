ALTER TRIGGER new_violation
ON Violation 
AFTER INSERT 
AS
BEGIN
	DECLARE @car INT, @violation INT;
	DECLARE @driver INT, @cost INT, @reduct INT, @time DATE, @duration INT;

	SELECT @car = ID_Car FROM inserted;
	SELECT @violation = ID_ViolationType FROM inserted;
	SELECT @cost = Cost FROM ViolationType WHERE ID_ViolationType = @violation;

	SELECT @driver = ID_Driver FROM Car where ID_Car = @car;
	SELECT @reduct = SUM(Reduction) FROM InsuranceReduction INNER JOIN CarInsurance
		ON CarInsurance.ID_Insurance = InsuranceReduction.ID_Insurance AND
			InsuranceReduction.ID_ViolationType = @violation AND 
			CarInsurance.ID_Car = @car;

	SELECT @time = Date FROM inserted;
	SELECT @duration = Duration FROM ViolationType WHERE ID_ViolationType = @violation;

	INSERT INTO Penalty (ID_Driver, Amount, Expiration) VALUES (@driver, @cost - @reduct, DATEADD(MONTH, @duration, @time));
END
GO