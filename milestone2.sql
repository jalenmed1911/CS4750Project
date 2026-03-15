CREATE TABLE User (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
    )

CREATE TABLE Player (
    playerID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    hometown VARCHAR(255) NOT NULL,
    valuation INT NOT NULL,
    stars INT NOT NULL CHECK (stars >= 0 AND stars <= 5),
    userID INT,
    teamID INT,
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (teamID) REFERENCES Team(teamID)
)

CREATE TABLE Running_Back(
    playerID INT PRIMARY KEY,
    receptions INT NOT NULL,
    touchdowns INT NOT NULL,
    carries INT NOT NULL,
    yards FLOAT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
)

CREATE TABLE Quarterback(
    playerID INT PRIMARY KEY,
    passing_yards FLOAT NOT NULL,
    completion_rate FLOAT NOT NULL,
    touchdowns INT NOT NULL,
    interceptions INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
)

CREATE TABLE Wide_Receiver(
    playerID INT PRIMARY KEY,
    receptions INT NOT NULL,
    receiving_yards FLOAT NOT NULL,
    touchdowns INT NOT NULL,
    yards_after_catch FLOAT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
)

CREATE TABLE Linebacker(
    playerID INT PRIMARY KEY,
    sacks INT NOT NULL,
    tackles_for_loss INT NOT NULL,
    total_tackles INT NOT NULL,
    solo_tackles INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
)

CREATE TABLE Safety(
    playerID INT PRIMARY KEY,
    solo_tackles INT NOT NULL,
    total_tackles INT NOT NULL,
    interceptions INT NOT NULL,
    passes_defended INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
)

CREATE TABLE Kicker(
    playerID INT PRIMARY KEY,
    longest_field_goal INT NOT NULL,
    field_goals_attempted INT NOT NULL,
    field_goals_made INT NOT NULL,
    points INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
)

CREATE TABLE Coach(
    coachID INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    teamID INT,
    FOREIGN KEY (teamID) REFERENCES Team(teamID)
)

CREATE TABLE Team(
    teamID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    valuation_threshold INT NOT NULL,
    description VARCHAR(255) NOT NULL
)

CREATE TABLE Offers(
    coachID INT,
    playerID INT,
    amount INT NOT NULL,
    status VARCHAR(255) NOT NULL CHECK (status IN ('pending', 'accepted', 'rejected')),
    PRIMARY KEY (coachID, playerID)
    FOREIGN KEY (coachID) REFERENCES Coach(coachID),
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
)

--Add Data to db here, or in php, and then update it to make sure it matches how we need it to.