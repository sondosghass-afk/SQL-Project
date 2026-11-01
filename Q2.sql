SELECT TOP 1
    D.DoctorID,
    D.FirstName,
    D.LastName,
    AVG(T.Cost) AS AverageTreatmentCost
FROM Doctors AS D
INNER JOIN Appointments AS A
    ON D.DoctorID = A.DoctorID
INNER JOIN Treatments AS T
    ON A.AppointmentID = T.AppointmentID
GROUP BY
    D.DoctorID,
    D.FirstName,
    D.LastName
ORDER BY AVG(T.Cost) DESC;