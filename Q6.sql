SELECT
    P.PatientID,
    P.FirstName,
    P.LastName,
    T.TreatmentID,
    T.TreatmentName,
    T.Cost AS TreatmentCost,
    AVG(T.Cost) OVER
    (
        PARTITION BY P.PatientID
    ) AS AverageTreatmentCostForPatient
FROM Patients AS P
INNER JOIN Appointments AS A
    ON P.PatientID = A.PatientID
INNER JOIN Treatments AS T
    ON A.AppointmentID = T.AppointmentID
ORDER BY
    P.PatientID,
    T.TreatmentDate;