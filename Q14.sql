WITH DepartmentDoctorRevenue AS
(
    SELECT
        Dep.DepartmentID,
        Dep.DepartmentName,
        D.DoctorID,
        D.FirstName,
        D.LastName,
        COALESCE(SUM(T.Cost), 0) AS RevenueAmount
    FROM Departments AS Dep
    INNER JOIN DoctorDepartments AS DD
        ON Dep.DepartmentID = DD.DepartmentID
    INNER JOIN Doctors AS D
        ON DD.DoctorID = D.DoctorID
    LEFT JOIN Appointments AS A
        ON D.DoctorID = A.DoctorID
    LEFT JOIN Treatments AS T
        ON A.AppointmentID = T.AppointmentID
    GROUP BY
        Dep.DepartmentID,
        Dep.DepartmentName,
        D.DoctorID,
        D.FirstName,
        D.LastName
),
RankedDoctors AS
(
    SELECT
        *,
        ROW_NUMBER() OVER
        (
            PARTITION BY DepartmentID
            ORDER BY RevenueAmount DESC, DoctorID
        ) AS DoctorRank
    FROM DepartmentDoctorRevenue
)
SELECT
    DepartmentName,
    FirstName + ' ' + LastName AS DoctorName,
    RevenueAmount
FROM RankedDoctors
WHERE DoctorRank = 1
ORDER BY DepartmentName;