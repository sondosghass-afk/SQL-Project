SELECT
    P.PatientID,
    P.FirstName,
    P.LastName,
    COUNT(DISTINCT A.DoctorID) AS NumberOfDoctors
FROM Patients AS P
INNER JOIN Appointments AS A
    ON P.PatientID = A.PatientID
GROUP BY
    P.PatientID,
    P.FirstName,
    P.LastName
HAVING COUNT(DISTINCT A.DoctorID) > 1;