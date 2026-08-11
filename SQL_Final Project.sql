#Stored Procedure for the OTT Platform
-- use ott_project
show tables;

DELIMITER //

CREATE PROCEDURE GetEligibleUsersForUpgrade()
BEGIN
    SELECT 
        u.UserID,
        u.Username,
        u.Email,
        SUM(wh.DurationMinutes) AS TotalWatchTime,
        COUNT(r.RatingID) AS TotalRatings
    FROM 
        UserTable u
    JOIN 
        SubscriptionTable s ON u.UserID = s.UserID
    JOIN 
        WatchHistoryTable wh ON u.UserID = wh.UserID
    LEFT JOIN 
        RatingTable r ON u.UserID = r.UserID
    WHERE 
        s.SubscriptionType = 'Free'
        AND s.SubscriptionStatus = 'Active'
        AND wh.WatchDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        AND (r.RatingDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) OR r.RatingDate IS NULL)
    GROUP BY 
        u.UserID, u.Username, u.Email
    HAVING 
        SUM(wh.DurationMinutes) > 1000 
        AND COUNT(r.RatingID) >= 5;
END //

DELIMITER //

CREATE PROCEDURE GetEligibleUsersForUpgrade()
BEGIN
    SELECT 
        u.UserID,
        u.Username,
        u.Email,
        SUM(wh.DurationMinutes) AS TotalWatchTime,
        COUNT(r.RatingID) AS TotalRatings
    FROM 
        UserTable u
    JOIN 
        SubscriptionTable s ON u.UserID = s.UserID
    JOIN 
        WatchHistoryTable wh ON u.UserID = wh.UserID
    LEFT JOIN 
        RatingTable r ON u.UserID = r.UserID
    WHERE 
        s.SubscriptionType = 'Free'
        AND s.SubscriptionStatus = 'Active'
        AND wh.WatchDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        AND (r.RatingDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) OR r.RatingDate IS NULL)
    GROUP BY 
        u.UserID, u.Username, u.Email
    HAVING 
        SUM(wh.DurationMinutes) > 1000 
        AND COUNT(r.RatingID) >= 5;
END //

#Triggers

CREATE TRIGGER set_feedback_category
BEFORE INSERT ON OTT_Platform
FOR EACH ROW
BEGIN
    IF NEW.Numeric_Rating >= 4 THEN
        SET NEW.Feedback_Category = 'Positive';
    ELSEIF NEW.Numeric_Rating >= 2 THEN
        SET NEW.Feedback_Category = 'Neutral';
    ELSE
        SET NEW.Feedback_Category = 'Negative';
    END IF;
END;



