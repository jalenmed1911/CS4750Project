DELIMITER $$

CREATE TRIGGER trg_quarterback_after_update
AFTER UPDATE ON Quarterback
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;

    -- Check if any stat column changed
    IF (OLD.yards <> NEW.yards OR
        OLD.percentage <> NEW.percentage OR
        OLD.touchdowns <> NEW.touchdowns OR
        OLD.interceptions <> NEW.interceptions) THEN

        SET @valuation = FLOOR(NEW.yards *  0.656 + NEW.percentage * 262 + NEW.touchdowns * 26 - NEW.interceptions * 26);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

    END IF;
END$$

CREATE TRIGGER trg_running_back_after_update
AFTER UPDATE ON Running_Back
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;

    -- Check if any stat column changed
    IF (OLD.yards <> NEW.yards OR
        OLD.carries <> NEW.carries OR
        OLD.touchdowns <> NEW.touchdowns OR
        OLD.longest <> NEW.longest) THEN

        SET @valuation = FLOOR(NEW.yards + NEW.carries * 4 + NEW.touchdowns * 35 + NEW.longest * 9);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

    END IF;
END$$

CREATE TRIGGER trg_wide_receiver_after_update
AFTER UPDATE ON Wide_Receiver
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;

    -- Check if any stat column changed
    IF (OLD.yards <> NEW.yards OR
        OLD.receptions <> NEW.receptions OR
        OLD.touchdowns <> NEW.touchdowns OR
        OLD.longest <> NEW.longest) THEN

        SET @valuation = FLOOR(NEW.yards + NEW.receptions * 5 + NEW.touchdowns * 40 + NEW.longest * 10);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

    END IF;
END$$

CREATE TRIGGER trg_linebacker_after_update
AFTER UPDATE ON Linebacker
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;

    -- Check if any stat column changed
    IF (OLD.sacks <> NEW.sacks OR
        OLD.solo_tackles <> NEW.solo_tackles OR
        OLD.total_tackles <> NEW.total_tackles OR
        OLD.tackles_for_loss <> NEW.tackles_for_loss) THEN

        SET @valuation = FLOOR(NEW.sacks *  73 + NEW.solo_tackles * 24 + NEW.total_tackles * 12 + NEW.tackles_for_loss * 48);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

    END IF;
END$$

CREATE TRIGGER trg_safety_after_update
AFTER UPDATE ON Safety
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;

    -- Check if any stat column changed
    IF (OLD.solo_tackles <> NEW.solo_tackles OR
        OLD.total_tackles <> NEW.total_tackles OR
        OLD.passes_defended <> NEW.passes_defended OR
        OLD.interceptions <> NEW.interceptions) THEN

        SET @valuation = FLOOR(NEW.solo_tackles *  30 + NEW.total_tackles * 15 + NEW.interceptions * 119 + NEW.passes_defended * 30);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

    END IF;
END$$

CREATE TRIGGER trg_kicker_after_update
AFTER UPDATE ON Kicker
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;

    -- Check if any stat column changed
    IF (OLD.fg_attempted <> NEW.fg_attempted OR
        OLD.fg_made <> NEW.fg_made OR
        OLD.longest <> NEW.longest OR
        OLD.points <> NEW.points) THEN

        SET @valuation = FLOOR(NEW.fg_attempted *  3 + NEW.fg_made * 10 + NEW.longest * 10 + NEW.points * 5);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

    END IF;
END$$

CREATE TRIGGER trg_quarterback_after_insert
AFTER INSERT ON Quarterback
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;

    
        SET @valuation = FLOOR(NEW.yards *  0.656 + NEW.percentage * 262 + NEW.touchdowns * 26 - NEW.interceptions * 26);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

END$$

CREATE TRIGGER trg_running_back_after_insert
AFTER INSERT ON Running_Back
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;



        SET @valuation = FLOOR(NEW.yards + NEW.carries * 4 + NEW.touchdowns * 35 + NEW.longest * 9);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

END$$

CREATE TRIGGER trg_wide_receiver_after_insert
AFTER INSERT ON Wide_Receiver
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;

    

        SET @valuation = FLOOR(NEW.yards + NEW.receptions * 5 + NEW.touchdowns * 40 + NEW.longest * 10);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

END$$

CREATE TRIGGER trg_linebacker_after_insert
AFTER INSERT ON Linebacker
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;

    

        SET @valuation = FLOOR(NEW.sacks *  73 + NEW.solo_tackles * 24 + NEW.total_tackles * 12 + NEW.tackles_for_loss * 48);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

END$$

CREATE TRIGGER trg_safety_after_insert
AFTER INSERT ON Safety
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;

    

        SET @valuation = FLOOR(NEW.solo_tackles *  30 + NEW.total_tackles * 15 + NEW.interceptions * 119 + NEW.passes_defended * 30);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

END$$

CREATE TRIGGER trg_kicker_after_insert
AFTER INSERT ON Kicker
FOR EACH ROW
BEGIN

    DECLARE stars INT;
    DECLARE valuation INT;

    

        SET @valuation = FLOOR(NEW.fg_attempted *  3 + NEW.fg_made * 10 + NEW.longest * 10 + NEW.points * 5);

        SET @stars = 1 + FLOOR( @valuation / 300 );

        IF (@stars > 5)
            THEN SET @stars = 5;
        END IF;

        IF (@stars < 1)
            THEN SET @stars = 1;
        END IF;

        -- Update Player table
        UPDATE Player
        SET valuation = @valuation,
            stars = @stars
        WHERE playerID = NEW.playerID;

END$$


DELIMITER ;