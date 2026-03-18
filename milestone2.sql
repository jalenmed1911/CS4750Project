CREATE TABLE User (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE Team(
    teamID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    valuation_threshold INT NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE Player (
    playerID INT PRIMARY KEY, --use ID from CFBD.com
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL,
    hometown VARCHAR(255) NOT NULL,
    valuation INT NOT NULL,
    stars INT NOT NULL CHECK (stars >= 0 AND stars <= 5)
);

CREATE TABLE Running_Back(
    playerID INT PRIMARY KEY,
    long INT NOT NULL,
    td INT NOT NULL,
    car INT NOT NULL,
    yds INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Quarterback(
    playerID INT PRIMARY KEY,
    yds INT NOT NULL,
    pct FLOAT NOT NULL,
    td INT NOT NULL,
    int INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Wide_Receiver(
    playerID INT PRIMARY KEY,
    rec INT NOT NULL,
    yds INT NOT NULL,
    td INT NOT NULL,
    long INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Linebacker(
    playerID INT PRIMARY KEY,
    sacks FLOAT NOT NULL,
    tfl FLOAT NOT NULL,
    tot INT NOT NULL,
    solo INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Safety(
    playerID INT PRIMARY KEY,
    solo INT NOT NULL,
    tot INT NOT NULL,
    int INT NOT NULL,
    pd INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Kicker(
    playerID INT PRIMARY KEY,
    long INT NOT NULL,
    fga INT NOT NULL,
    fgm INT NOT NULL,
    pts INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Coach(
    coachID INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    teamID INT,
    FOREIGN KEY (teamID) REFERENCES Team(teamID)
);

CREATE TABLE Offers(
    coachID INT,
    playerID INT,
    amount INT NOT NULL,
    status VARCHAR(255) NOT NULL CHECK (status IN ('pending', 'accepted', 'rejected')),
    PRIMARY KEY (coachID, playerID),
    FOREIGN KEY (coachID) REFERENCES Coach(coachID),
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

-- Add Data to db here, or in php, and then update it to make sure it matches how we need it to.