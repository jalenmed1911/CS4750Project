CREATE TABLE Portal_User (
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
    playerID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL,
    hometown VARCHAR(255) NOT NULL,
    valuation INT NOT NULL,
    stars INT NOT NULL CHECK (stars >= 0 AND stars <= 5)
);

CREATE TABLE Running_Back(
    playerID INT PRIMARY KEY,
    longest INT NOT NULL,
    touchdowns INT NOT NULL,
    carries INT NOT NULL,
    yards INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Quarterback(
    playerID INT PRIMARY KEY,
    yards INT NOT NULL,
    percentage FLOAT NOT NULL,
    touchdowns INT NOT NULL,
    interceptions INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Wide_Receiver(
    playerID INT PRIMARY KEY,
    receptions INT NOT NULL,
    yards INT NOT NULL,
    touchdowns INT NOT NULL,
    longest INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Linebacker(
    playerID INT PRIMARY KEY,
    sacks FLOAT NOT NULL,
    tackles_for_loss FLOAT NOT NULL,
    total_tackles INT NOT NULL,
    solo_tackles INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Safety(
    playerID INT PRIMARY KEY,
    solo_tackles INT NOT NULL,
    total_tackles INT NOT NULL,
    interceptions INT NOT NULL,
    passes_defended INT NOT NULL,
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Kicker(
    playerID INT PRIMARY KEY,
    longest INT NOT NULL,
    fg_attempted INT NOT NULL,
    fg_made INT NOT NULL,
    points INT NOT NULL,
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

CREATE TABLE User_Player(
    userID INT,
    playerID INT,
    PRIMARY KEY (userID, playerID),
    FOREIGN KEY (userID) REFERENCES Portal_User(userID),
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE Player_Team(
    playerID INT,
    teamID INT,
    PRIMARY KEY (playerID, teamID),
    FOREIGN KEY (playerID) REFERENCES Player(playerID),
    FOREIGN KEY (teamID) REFERENCES Team(teamID)
);

-- Add Data to db
INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4362263, 'Jalynn Williams', 'RB', 'St. Petersburg', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4362263, 23, 5, 0, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4379471, 'Tyler Brown', 'WR', 'Macon', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4379471, 191, 22, 0, 23);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4426931, 'Antonio Clary', 'S', 'Jacksonville', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4426931, 10, 27, 1, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4428993, 'Haynes King', 'QB', 'Longview', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4428993, 0.698, 2951, 14, 6);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4429162, 'Jaiden Francois', 'LB', 'Florida City', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4429162, 1.0, 30, 73, 7.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4429173, 'Bryce Farrell', 'WR', 'Thousand Oaks', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4429173, 447, 28, 2, 68);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4430185, 'Caullin Lacy', 'WR', 'Mobile', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4430185, 635, 60, 2, 48);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4430565, 'Will Nixon', 'RB', 'Waco', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4430565, 432, 107, 3, 28);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4430604, 'Mohamed Toure', 'LB', '', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4430604, 2.0, 38, 84, 3.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4430841, 'Carson Beck', 'QB', 'Jacksonville', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4430841, 0.722, 3813, 30, 12);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4430894, 'Caziah Holmes', 'RB', 'Titusville', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4430894, 89, 18, 2, 16);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4431114, 'Ben Gulbranson', 'QB', 'Newbury Park', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4431114, 0.569, 1813, 9, 10);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4431197, 'Romello Brinson', 'WR', 'Miami', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4431197, 638, 43, 3, 75);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4431209, 'Dacari Collins', 'WR', 'Atlanta', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4431209, 219, 13, 1, 36);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4431292, 'Devin Neal', 'S', 'Lawrence', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4431292, 41, 88, 7, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4431454, 'Tyler Venables', 'S', 'Clemson', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4431454, 5, 6, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4431505, 'Kobe Paysour', 'WR', 'Kings Mountain', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4431505, 438, 35, 1, 44);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4431580, 'Miller Moss', 'QB', 'Los Angeles', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4431580, 0.642, 2679, 16, 7);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4431600, 'Jayden Thomas', 'WR', 'Paulding County', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4431600, 9, 3, 0, 6);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4432506, 'Sawyer Racanelli', 'WR', 'Brush Prairie', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4432506, 315, 18, 1, 62);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4432718, 'LJ Johnson Jr.', 'RB', 'Cypress', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4432718, 108, 33, 2, 12);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4565318, 'Terion Stewart', 'RB', 'Memphis', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4565318, 469, 82, 0, 85);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4567033, 'Donavon Greene', 'WR', 'Mount Airy', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4567033, 267, 16, 2, 37);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4567707, 'Grayson James', 'QB', 'Duncanville', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4567707, 0.576, 1196, 7, 5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4569001, 'Cameron Ross', 'WR', 'Las Vegas', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4569001, 543, 53, 2, 46);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4570645, 'Owen McGowan', 'LB', 'Canton', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4570645, 1.0, 31, 54, 5.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4576294, 'Harrison Waylee', 'RB', 'Johnston', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4576294, 556, 118, 6, 97);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4587701, 'Andrel Anthony Jr.', 'WR', 'Lansing', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4587701, 246, 26, 5, 35);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4589233, 'Dylan Goffney', 'WR', 'Cypress', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4589233, 16, 1, 0, 16);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4595022, 'Hunter Barth', 'LB', 'Chandler', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4595022, 2.0, 20, 32, 4.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4595341, 'Caleb Hood', 'RB', 'Rockingham', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4595341, 44, 16, 1, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4596666, 'Bryce Steele', 'LB', 'Raleigh', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4596666, 0.0, 9, 16, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4597250, 'Will Johnson', 'LB', 'Collingswood', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4597250, 0.0, 1, 3, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4597253, 'Isaiah Nwokobia', 'S', 'Dallas', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4597253, 41, 80, 7, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4602646, 'Dylan Hazen', 'LB', 'The Woodlands', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4602646, 0.0, 30, 73, 9.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4602927, 'Mitch Leigber', 'S', 'Laguna Hills', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4602927, 21, 36, 2, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4603746, 'Malik Rutherford', 'WR', 'Miami', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4603746, 523, 46, 3, 71);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4604004, 'Keelan Marion', 'WR', 'Atlanta', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4604004, 746, 57, 2, 61);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4605951, 'C.J. Daniels', 'WR', 'Lilburn', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4605951, 557, 50, 7, 47);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4608755, 'Anson Pulsipher', 'LB', 'Temecula', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4608755, 0.0, 6, 6, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4608922, 'Braydon Bennett', 'RB', 'Greenville', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4608922, 8, 4, 1, 3);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4611995, 'Jamal Haynes', 'RB', 'Loganville', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4611995, 531, 124, 5, 47);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4612246, 'Sahmir Hagans', 'WR', 'Philadelphia', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4612246, 512, 44, 6, 35);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4612406, 'Anwar Sparrow', 'LB', 'Virginia Beach', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4612406, 1.0, 22, 31, 4.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4612558, 'Anderson Castle', 'RB', 'Boone', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4612558, 488, 115, 12, 66);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4612846, 'Jackson Hamilton', 'LB', 'Houston', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4612846, 0.0, 1, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4643646, 'Matthew Dennis', 'PK', 'Charlotte', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (4643646, 0, 0, 0, 3);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4678010, 'Kyron Drones', 'QB', 'Pearland', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4678010, 0.565, 1919, 17, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4682490, 'Chase Smith', 'LB', 'Eldridge', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4682490, 0.0, 15, 31, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4683096, 'Caden Fordham', 'LB', 'Ponte Vedra', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4683096, 3.5, 60, 143, 9.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4683154, 'Mikai Gbayor', 'LB', 'Irvington', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4683154, 1.0, 16, 36, 2.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4683159, 'Lewis Bond', 'WR', 'Chicago', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4683159, 1010, 89, 1, 54);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4683201, 'Andrew Simpson', 'LB', 'Norwalk', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4683201, 5.0, 30, 59, 9.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4683205, 'Quincy Bryant', 'LB', 'Lilburn', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4683205, 0.0, 16, 57, 2.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4683224, 'Derek Mcdonald', 'LB', 'Atlanta', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4683224, 0.0, 4, 6, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4683886, 'Jahmal Edrine', 'WR', 'Fort Lauderdale', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4683886, 564, 46, 1, 37);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4684030, 'TJ Quinn', 'LB', 'Valdosta', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4684030, 3.0, 45, 95, 8.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4684139, 'Sean Brown', 'LB', 'Winston-Salem', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4684139, 0.0, 18, 44, 3.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4684956, 'Stefon Thompson', 'LB', 'Long Island', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4684956, 3.5, 13, 37, 3.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685113, 'Jaylin Alderman', 'LB', 'Valdosta', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4685113, 0.0, 5, 7, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685243, 'Jeremiah Alexander', 'LB', 'Alabaster', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4685243, 1.0, 11, 36, 1.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685245, 'Wilfredo Aybar', 'LB', 'Fall River', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4685245, 0.0, 6, 21, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685252, 'Henry Belin IV', 'QB', 'New York', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4685252, 0.4, 22, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685275, 'Wesley Bissainthe', 'LB', 'Miami', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4685275, 1.0, 39, 71, 3.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685308, 'Ernest Cooper', 'LB', 'Arlington', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4685308, 3.0, 12, 23, 5.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685316, 'Sherrod Covil', 'S', 'Chesapeake', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4685316, 1, 1, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685364, 'Andre Greene Jr.', 'WR', 'Richmond', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4685364, 7, 1, 0, 7);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685409, 'Jordan Hudson', 'WR', 'Garland', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4685409, 766, 61, 6, 70);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685413, 'Cade Klubnik', 'QB', 'Austin', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4685413, 0.656, 2943, 16, 6);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685429, 'Melvin Jordan IV', 'LB', 'St. Petersburg', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4685429, 0.5, 5, 18, 0.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685526, 'Adam Randall', 'RB', 'Myrtle Beach', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4685526, 814, 168, 10, 46);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685544, 'Tevarua Tafiti', 'LB', 'Waipahu', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4685544, 2.0, 15, 32, 7.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685545, 'Gavin Sawchuk', 'RB', 'Littleton', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4685545, 486, 109, 8, 40);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685691, 'Brady Allen', 'QB', 'Fort Branch', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4685691, 0.667, 75, 1, 2);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685694, 'Steven Angeli', 'QB', 'Westfield', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4685694, 0.626, 1317, 10, 2);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685723, 'Roydell Williams', 'RB', 'Hueytown', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4685723, 46, 15, 0, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4685740, 'Max Johnson', 'QB', 'Watkinsville', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4685740, 0.621, 437, 2, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4686028, 'James Jackson', 'LB', 'Cutler Bay', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4686028, 0.0, 24, 66, 2.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4686769, 'Ashaad Clayton', 'RB', 'New Orleans', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4686769, 88, 12, 2, 50);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4688216, 'Chevy Brenson', 'WR', 'St. Louis', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4688216, 83, 3, 1, 41);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4688541, 'Kyion Grayes', 'WR', 'Chandler', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4688541, 10, 1, 0, 10);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4688609, 'Alec Marenco', 'LB', 'El Paso', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4688609, 0.0, 2, 4, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4688759, 'Isaiah Cash', 'S', 'Mineola', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4688759, 20, 41, 2, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4689578, 'Luke DelGaudio', 'LB', 'Shavertown', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4689578, 0.0, 2, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4691868, 'Quinn Castner', 'PK', 'Fort Mill', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (4691868, 0, 0, 0, 3);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4692530, 'Chandler Morris', 'QB', 'Highland Park', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4692530, 0.647, 3000, 16, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4695709, 'Devin Brown', 'QB', 'Miami', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4695709, 0.571, 48, 1, 1);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4696686, 'Deuce Spann', 'WR', 'St. Petersburg', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4696686, 142, 13, 1, 30);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4697495, 'Kyle Lowe', 'PK', 'Midlothian', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (4697495, 0, 0, 0, 1);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4697512, 'Robby Ashford', 'QB', 'Hoover', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4697512, 0.593, 2472, 12, 8);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4700756, 'Jaden Keller', 'LB', 'Bristol', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4700756, 0.5, 22, 50, 2.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4701943, 'Elijah Herring', 'LB', 'Murfreesboro', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4701943, 1.0, 20, 41, 3.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4701953, 'Kenzy Paul', 'S', 'Laprairie', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4701953, 0, 1, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4702789, 'Justin Medlock', 'LB', 'Missouri City', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4702789, 1.0, 12, 25, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4702822, 'Curlee Thomas', 'LB', 'Keller', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4702822, 0.0, 0, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4703030, 'Jaiven Plummer', 'WR', 'Sacramento', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4703030, 86, 2, 1, 51);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4705557, 'Quaron Adams', 'WR', 'Phoenix', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4705557, 273, 20, 1, 39);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4707209, 'Nick Morris Jr.', 'LB', 'Austin', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4707209, 0.0, 12, 18, 3.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4708487, 'Jaquez Moore', 'RB', 'Live Oak', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4708487, 201, 41, 1, 32);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4709788, 'Vaughn Pemberton', 'LB', 'Lake Forest', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4709788, 0.0, 1, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4710334, 'Ese Dubre', 'LB', 'Powder Springs', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4710334, 0.5, 4, 13, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4713118, 'J''mari Taylor', 'RB', 'Charlotte', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4713118, 1062, 222, 14, 78);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4713277, 'Eric Rivers', 'WR', 'Chattanooga', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4713277, 671, 47, 2, 68);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4715349, 'Ahmaad Moses', 'S', 'Arlington', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4715349, 54, 104, 3, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4773919, 'Thomas Castellanos', 'QB', 'Waycross', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4773919, 0.583, 2760, 15, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4781742, 'Trey McDonald', 'LB', 'Kinnelon', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4781742, 0.0, 2, 4, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4794150, 'Kylon Griffin', 'S', 'Montgomery', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4794150, 5, 7, 1, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4804878, 'Cooper Barkate', 'WR', 'Newport Beach', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4804878, 1106, 72, 7, 77);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4808743, 'Omar Graham Jr.', 'LB', 'Fort Lauderdale', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4808743, 0.0, 24, 38, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4812339, 'Kobe McCloud', 'LB', 'Tampa', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4812339, 1.0, 10, 26, 2.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4819256, 'Matt Rose', 'LB', 'Forsyth', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4819256, 3.0, 49, 106, 8.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4824124, 'Alex Broome', 'RB', 'Nashville', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4824124, 10, 7, 1, 6);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4832042, 'Kenny Soares Jr.', 'LB', 'Trumbull', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4832042, 0.5, 35, 80, 4.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4832846, 'Demond Claiborne', 'RB', 'Aylett', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4832846, 905, 179, 10, 85);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4837206, 'A.J. Cottrill', 'LB', 'Tampa', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4837206, 1.5, 4, 15, 2.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4837258, 'Travis Bates', 'RB', 'Tomball', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4837258, 57, 9, 0, 39);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4837267, 'Daveon Crouch', 'LB', 'Tampa', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4837267, 1.0, 7, 12, 1.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4837286, 'Wade Woodaz', 'LB', 'Tampa', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4837286, 0.5, 43, 70, 7.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4837327, 'Christian Ellis', 'S', 'Chicago', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4837327, 5, 7, 3, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4837385, 'Jordan Mcdonald', 'RB', 'Scottsdale', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4837385, 397, 94, 4, 17);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4837472, 'E.J. Lightsey', 'LB', 'Fitzgerald', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4837472, 0.0, 39, 76, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4838276, 'Antonio Watts', 'LB', 'Columbus', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4838276, 2.5, 22, 42, 7.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4838514, 'Kyle Efford', 'LB', 'Dacula', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4838514, 1.5, 33, 77, 2.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4839483, 'Zakye Barker', 'LB', 'Norcross', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4839483, 0.0, 11, 27, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4840118, 'Tucker Holloway', 'WR', 'Andrews', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4840118, 82, 5, 0, 33);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4868171, 'Tate Carney', 'RB', 'Mocksville', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4868171, 9, 1, 0, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4868249, 'Davis Lane', 'RB', 'Lynchburg', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4868249, 39, 9, 0, 11);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4869961, 'Chris Bell', 'WR', 'Forney', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4869961, 917, 72, 6, 64);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870232, 'Tyson Flowers', 'S', 'Fort Worth', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4870232, 27, 48, 2, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870590, 'Raul Aguirre Jr.', 'LB', 'Fayetteville', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4870590, 0.0, 22, 43, 2.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870623, 'Malik Bryant', 'LB', 'Orlando', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4870623, 0.0, 1, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870645, 'Rickie Collins', 'QB', 'Baton Rouge', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4870645, 0.536, 1042, 6, 10);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870656, 'Johntay Cook II', 'WR', 'Desoto', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4870656, 559, 47, 2, 59);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870664, 'Stanquan Clark', 'LB', 'Miami', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4870664, 0.0, 9, 19, 1.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870682, 'Dee Crayton', 'LB', 'Alpharetta', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4870682, 0.0, 2, 5, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870719, 'Daemon Fagan', 'S', 'Fort Lauderdale', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4870719, 1, 1, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870736, 'Mark Fletcher Jr.', 'RB', 'Fort Lauderdale', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4870736, 1192, 216, 12, 57);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870767, 'James Heard Jr.', 'LB', '', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4870767, 0.0, 8, 12, 0.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870770, 'Nathaniel Joseph', 'WR', 'Miami', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4870770, 25, 2, 0, 18);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870802, 'Sedrick Irvin', 'RB', 'Miami', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4870802, 118, 41, 1, 15);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870819, 'Eli Holstein', 'QB', 'Zachary', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4870819, 0.616, 1081, 12, 6);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870826, 'Micah Mays Jr.', 'WR', 'Palm Beach Gardens', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4870826, 302, 18, 2, 52);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870900, 'Dylan Lonergan', 'QB', 'Snellville', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4870900, 0.669, 2025, 12, 5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870922, 'Duce Robinson', 'WR', 'Phoenix', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4870922, 1074, 56, 6, 82);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870929, 'Noah Rogers', 'WR', 'Rolesville', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4870929, 413, 31, 2, 48);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870941, 'Cameron Seldon', 'WR', 'Browns Store', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4870941, 165, 23, 2, 22);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4870955, 'Samuel Singleton', 'RB', 'Charleston', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4870955, 360, 51, 4, 53);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4871001, 'Jaedn Skeete', 'WR', 'Hyde Park', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4871001, 140, 13, 3, 22);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4871030, 'Jayden Wayne', 'LB', 'Tacoma', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4871030, 3.0, 9, 26, 4.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4871053, 'Daylan Smothers', 'RB', 'Charlotte', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4871053, 939, 160, 6, 65);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4871148, 'Jaylin Lucas', 'RB', 'Houma', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4871148, 160, 27, 0, 26);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4871220, 'Will Bettridge', 'PK', 'Miami', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (4871220, 30, 24, 47, 121);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4871708, 'Luke McLaughlin', 'WR', 'Coeur d''Alene', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4871708, 72, 5, 0, 39);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4873276, 'Zach Jackson', 'WR', 'Smyrna', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4873276, -3, 1, 0, -3);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4873284, 'Tre Freeman', 'LB', 'Durham', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4873284, 1.0, 23, 52, 4.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4873442, 'Xavier Brown', 'RB', 'Lexington', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4873442, 241, 51, 1, 20);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4873609, 'Daylon Gordon', 'RB', 'Eastman', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4873609, 63, 4, 1, 47);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4875128, 'Lex Thomas', 'QB', 'Wake Forest', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4875128, 0.286, 18, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4875272, 'Trond Grizzell', 'WR', 'Park City', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4875272, 788, 55, 1, 35);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4875315, 'Emmet Kenney', 'PK', 'Fargo', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (4875315, 21, 16, 46, 69);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4875613, 'Dean Patterson', 'WR', 'Lutz', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4875613, 150, 8, 2, 84);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4876144, 'Tuna Altahir', 'RB', 'Kennewick', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4876144, 55, 15, 0, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4876720, 'Aidan Birr', 'PK', 'Kennedale', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (4876720, 29, 25, 55, 120);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4877558, 'Raphael Williams', 'WR', 'Fort Lauderdale', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4877558, 741, 52, 7, 67);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4879499, 'Tony Johnson', 'WR', 'Ocala', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4879499, 162, 7, 0, 51);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4880227, 'Nick Lapi', 'LB', 'Upper Saddle River', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4880227, 1.0, 11, 16, 3.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4880273, 'Kyle Louis', 'LB', 'East Orange', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4880273, 3.0, 43, 79, 8.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4880279, 'P.J. Prioleau', 'RB', 'Radford', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4880279, 59, 13, 0, 16);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4880347, 'Bert Auburn', 'PK', 'Flower Mound', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (4880347, 1, 1, 31, 11);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4880893, 'John Love', 'PK', 'Burlington', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (4880893, 20, 15, 56, 70);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4882122, 'Sterling Berkhalter', 'WR', 'Cincinnati', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4882122, 416, 30, 2, 51);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4888723, 'Wesley Grimes', 'WR', 'Raleigh', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4888723, 458, 31, 3, 48);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4891194, 'Palaie Faoa', 'LB', 'Ewa Beach', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4891194, 0.0, 3, 3, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4893815, 'JaMario Clements', 'RB', 'Lafayette', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4893815, 63, 22, 0, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4896021, 'Chris Victor', 'LB', 'Jacksonville', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4896021, 3.0, 10, 24, 5.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4897443, 'Harrison Taggart', 'LB', 'Draper', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4897443, 0.0, 14, 38, 2.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4899368, 'Kendrick Raphael', 'RB', 'Naples', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4899368, 952, 233, 13, 33);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4899369, 'Christopher Vizzina', 'QB', 'Birmingham', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4899369, 0.634, 406, 4, 1);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4899472, 'Chris Culliver', 'WR', 'Maiden', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4899472, 100, 5, 1, 51);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4899480, 'Blake Nichelson', 'LB', 'Ripon', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4899480, 1.0, 24, 43, 6.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4899704, 'Jordan King', 'WR', 'Fort Wayne', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4899704, 267, 22, 2, 38);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4910239, 'Justus Ross-Simmons', 'WR', 'Rochester', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4910239, 312, 20, 5, 53);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4912130, 'Trell Harris', 'WR', 'La Grange', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4912130, 847, 59, 5, 75);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4914482, 'Charlie Mirer', 'QB', 'Rancho Santa Fe', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4914482, 0.667, 22, 1, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4914980, 'Cole Turner', 'WR', 'Dacula', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4914980, 144, 16, 0, 23);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4917046, 'Jaivion Green', 'S', 'Houston', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4917046, 24, 38, 6, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4917119, 'Devin Alves', 'WR', 'Melbourne', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4917119, 45, 3, 1, 19);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4917372, 'Antwone Santiago', 'LB', 'Meriden', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4917372, 0.0, 4, 9, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4917620, 'T.J. Bush', 'LB', 'Woodbridge', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4917620, 4.5, 16, 39, 10.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4917622, 'Brandon Miyazono', 'LB', 'Frisco', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4917622, 2.0, 22, 44, 4.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4918417, 'Ayden Greene', 'WR', 'Sammamish', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4918417, 516, 31, 3, 67);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4918434, 'Justin Cryer', 'LB', 'Katy', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4918434, 1.0, 15, 43, 5.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4920140, 'Nathan Leacock', 'WR', 'Rolesville', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4920140, 48, 5, 0, 18);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4920148, 'Robert Billings', 'S', 'Marietta', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4920148, 2, 3, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4920153, 'William Watson III', 'QB', 'Springfield', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4920153, 0.5, 77, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4920158, 'Brock Glenn', 'QB', 'Covington', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4920158, 0.6, 69, 2, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4920227, 'Giovanni Lopez', 'QB', 'Madison', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (4920227, 0.651, 1747, 10, 5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4921269, 'Kaleb Spencer', 'LB', 'Gloucester', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4921269, 0.5, 31, 67, 9.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4921271, 'Tyler Thompson', 'LB', 'Cary', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4921271, 7.0, 17, 26, 7.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4921322, 'Zion Taylor', 'WR', 'Missouri City', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4921322, 129, 11, 1, 45);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4921501, 'Jaden Milliner-Jones', 'S', 'Desoto', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4921501, 12, 17, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4922981, 'Rasheem Biles', 'LB', 'Pickerington', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4922981, 4.5, 39, 100, 17.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4922987, 'Takye Heath', 'WR', 'Richmond', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4922987, 200, 22, 3, 44);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4923043, 'Jamal Anderson', 'LB', 'Buford', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4923043, 0.0, 3, 5, 2.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4923044, 'Jordan Bass', 'S', 'Hampton', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4923044, 10, 21, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4923046, 'Keyjuan Brown', 'RB', 'Atlanta', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4923046, 704, 96, 6, 67);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4923059, 'Jeremiah Coney', 'RB', 'Richmond', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4923059, 47, 8, 0, 21);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4923278, 'Leon Griffin III', 'S', 'Virginia Beach', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4923278, 0, 1, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4923294, 'Kendall Johnson', 'LB', 'Gaithersburg', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4923294, 1.0, 20, 37, 3.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4923295, 'Kenny Johnson', 'WR', 'York', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (4923295, 658, 47, 5, 42);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4923298, 'Peyton Jones', 'RB', 'Norfolk', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (4923298, 34, 10, 1, 8);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4941016, 'Zyian Moultrie-Goddard', 'LB', 'Bronx', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4941016, 0.0, 7, 10, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4941019, 'Abdul Muhammad', 'S', 'Omaha', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4941019, 7, 8, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4954453, 'Cade Uluave', 'LB', 'South Jordan', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4954453, 3.0, 42, 97, 12.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4954505, 'Tre Williams', 'LB', 'Calhoun', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4954505, 0.0, 1, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4954509, 'Caleb Woodson', 'LB', 'Haymarket', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (4954509, 0.0, 26, 57, 2.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (4972253, 'Zack Myers', 'S', 'Arden', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (4972253, 3, 4, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5008017, 'Benjamin Hall', 'RB', 'Acworth', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5008017, 274, 71, 2, 18);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5031157, 'Reed Harris', 'WR', 'Great Falls', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5031157, 673, 39, 5, 57);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5070545, 'Serigne Tounkara', 'LB', 'Houston', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5070545, 0.0, 0, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5075566, 'Kelvon Mcbride', 'LB', 'Mobile', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5075566, 0.0, 2, 5, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5075800, 'Emory Williams', 'QB', 'Milton', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5075800, 0.684, 156, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5076108, 'Alex Kilgore', 'LB', 'Katy', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5076108, 0.0, 31, 60, 3.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5077204, 'Michael Short', 'LB', 'Charlotte', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5077204, 1.0, 7, 22, 4.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5077248, 'Braylan Lovelace', 'LB', 'Leechburg', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5077248, 1.0, 41, 79, 5.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5077267, 'Luke Mergott', 'LB', 'Berlin', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5077267, 1.5, 48, 91, 7.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5078098, 'Kamal Bonner', 'LB', 'Moultrie', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5078098, 0.0, 0, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5078110, 'Noah Vaughn', 'RB', 'Maryville', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5078110, 174, 23, 0, 54);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5078250, 'Khalil Barnes', 'S', 'Athens', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5078250, 24, 40, 2, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5078422, 'Brandon High', 'RB', 'Spring', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5078422, 98, 23, 1, 22);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5078423, 'Kamren Robinson', 'LB', 'Tappahannock', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5078423, 2.0, 20, 64, 4.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079301, 'CJ Bailey', 'QB', 'Miami', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5079301, 0.688, 3105, 25, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079315, 'Brody Barnhardt', 'S', 'Cornelius', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5079315, 11, 23, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079318, 'Elijah Brown', 'QB', 'Los Angeles', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5079318, 0.583, 829, 4, 2);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079330, 'T.J. Capers', 'LB', 'Miami', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5079330, 0.0, 23, 46, 3.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079342, 'Sammy Brown', 'LB', 'Commerce', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5079342, 5.5, 51, 107, 14.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079349, 'Isaac Brown', 'RB', 'Union', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5079349, 884, 101, 7, 78);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079351, 'Caden Brown', 'LB', 'Queens', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5079351, 0.0, 0, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079364, 'Kam Davis', 'RB', 'Albany', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5079364, 51, 8, 1, 24);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079374, 'Ny Carr', 'WR', 'Stow', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5079374, 45, 3, 0, 25);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079375, 'Noah Dixon', 'S', 'LaGrange', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5079375, 1, 1, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079408, 'Fatim Diggs', 'LB', 'Camden', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5079408, 0.0, 2, 3, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079411, 'Sterling Dixon', 'LB', 'Spanish Fort', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5079411, 0.0, 0, 1, 0.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079438, 'David Eziomume', 'RB', 'Acworth', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5079438, 71, 16, 0, 19);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079468, 'Davion Gause', 'RB', 'Opa Locka', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5079468, 258, 61, 3, 25);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079495, 'Jahide Lesaine Jr.', 'LB', 'Newark', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5079495, 0.0, 2, 3, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079523, 'Derrick McFall', 'RB', 'Tyler', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5079523, 189, 35, 4, 48);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079524, 'Keenan Jackson', 'WR', 'Haltom City', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5079524, 281, 28, 2, 33);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079539, 'Elijah Moore', 'WR', 'Oxon Hill', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5079539, 52, 3, 0, 19);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079544, 'Ricardo Jones', 'S', 'Warner Robins', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5079544, 25, 39, 3, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079579, 'Cameron Lindsey', 'LB', 'Aliquippa', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5079579, 2.0, 20, 32, 5.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079591, 'Jordan Lyle', 'RB', 'Fort Lauderdale', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5079591, 108, 35, 1, 17);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079599, 'Dylan Stephenson', 'LB', 'Miami', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5079599, 0.0, 4, 6, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079610, 'Jayden Moore', 'WR', 'Sykesville', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5079610, 42, 7, 0, 15);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079666, 'Ronnie Royal III', 'S', 'Gulf Shores', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5079666, 28, 49, 1, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079687, 'Jordan Shipp', 'WR', 'Charlotte', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5079687, 671, 60, 6, 55);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079704, 'Emanuel Ross', 'WR', 'Jackson', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5079704, 110, 10, 1, 20);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079736, 'Alex Taylor', 'WR', 'Greensboro', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5079736, 27, 3, 0, 15);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079740, 'Gabe Williams', 'LB', 'Bowie', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5079740, 0.0, 1, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079745, 'Joshisa Trader', 'WR', 'Hollywood', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5079745, 178, 13, 1, 44);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5079749, 'Yasin Willis', 'RB', 'Newark', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5079749, 553, 129, 4, 41);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081159, 'Nick Keller', 'PK', 'null', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5081159, 4, 2, 57, 7);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081205, 'Robbie Engelberg', 'S', 'Alexandria', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5081205, 0, 3, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081209, 'Eli Wood', 'WR', 'Lynchburg', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5081209, 205, 16, 2, 38);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081368, 'Squirrel White', 'WR', 'Birmingham', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5081368, 52, 5, 0, 40);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081395, 'Kalib Perry', 'LB', 'Georgetown', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5081395, 0.0, 29, 55, 1.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081432, 'Antonio Williams', 'WR', 'Irmo', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5081432, 604, 55, 4, 64);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081434, 'Trent Pearman', 'QB', 'Clemson', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5081434, 0.4, 35, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081435, 'Keith Adams Jr.', 'RB', 'St. George', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5081435, 71, 14, 1, 12);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081438, 'Fletcher Cothran', 'LB', 'Anderson', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5081438, 0.5, 4, 9, 3.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081694, 'Scotty Edwards', 'S', 'Holladay', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5081694, 32, 54, 1, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081777, 'Tra Thomas', 'LB', 'Glen Burnie', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5081777, 4.0, 7, 24, 6.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081845, 'Ashton Locklear', 'WR', 'Apex', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5081845, 4, 1, 0, 4);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5081852, 'Kanoah Vinesett', 'PK', 'Rock Hill', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5081852, 6, 5, 51, 63);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5082015, 'Carter Davis', 'PK', 'Eagle', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5082015, 24, 17, 53, 103);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5082438, 'Jeremiah Johnson', 'S', 'Tallahassee', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5082438, 6, 17, 1, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5082559, 'Rece Verhoff', 'PK', 'Columbus Grove', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5082559, 23, 19, 57, 77);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5082662, 'Cole Boscia', 'WR', 'Danville', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5082662, 85, 7, 1, 23);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5083711, 'Caleb Weaver', 'S', 'Houston', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5083711, 42, 89, 1, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5084084, 'Kevin Jennings', 'QB', 'Oak Cliff', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5084084, 0.661, 3641, 26, 13);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5084086, 'Charlie Fiser', 'QB', 'Little Rock', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5084086, 1.0, 30, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5084094, 'Keaton Cheves', 'WR', 'Dallas', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5084094, 4, 1, 0, 4);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5084095, 'Collin Rogers', 'PK', 'Prattville', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5084095, 3, 1, 43, 15);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5084425, 'Chase Meyer', 'PK', 'Los Angeles', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5084425, 13, 10, 45, 69);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5084658, 'Terrell Anderson', 'WR', 'Greensboro', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5084658, 629, 39, 5, 75);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5084847, 'Josh Kubala', 'LB', 'Syracuse', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5084847, 0.0, 1, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5084905, 'Jaylan Hornsby', 'WR', 'Winslow', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5084905, 103, 8, 1, 25);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5084906, 'Jaden Hart', 'RB', 'Michigan City', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5084906, 53, 15, 0, 14);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5085024, 'CJ Williams', 'WR', 'Amityville', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5085024, 757, 60, 6, 36);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5085246, 'Tylyric Coleman', 'WR', 'Danville', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5085246, 29, 2, 0, 23);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5085351, 'Abram Murray', 'PK', 'Shreveport', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5085351, 6, 4, 49, 12);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5085609, 'Treyshun Hurry', 'WR', 'Palmdale', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5085609, 122, 15, 1, 17);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5085761, 'Jahsiah Galvan', 'LB', 'West Liberty', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5085761, 0.0, 30, 50, 2.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5086027, 'TJ Harden', 'RB', 'Los Angeles', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5086027, 787, 171, 9, 53);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5086051, 'Vincent Wilkins', 'WR', 'Pfafftown', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5086051, 113, 4, 0, 56);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5086096, 'Lawayne McCoy', 'WR', 'Miami', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5086096, 403, 27, 3, 34);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5086842, 'DaShawn Stone', 'S', 'Asheville', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5086842, 46, 86, 3, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5088153, 'Micahi Danzy', 'WR', 'Tallahassee', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5088153, 571, 27, 3, 66);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5088414, 'Gary Bryant III', 'LB', 'Baltimore', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5088414, 1.0, 39, 53, 4.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5089535, 'Desmond Reid', 'RB', 'Miami Gardens', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5089535, 278, 60, 2, 53);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5089539, 'Censere Lee', 'WR', 'Clearwater', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5089539, 86, 5, 0, 31);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5089540, 'Cole Gonzales', 'QB', 'Gainesville', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5089540, 0.5, 118, 1, 1);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5091758, 'Tim Hays', 'LB', 'Concord', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5091758, 0.0, 1, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5091763, 'Juan Zubal', 'LB', 'Mexico City', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5091763, 0.0, 1, 4, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5091783, 'Jason Hewlett', 'LB', 'Youngstown', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5091783, 0.0, 4, 9, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5092271, 'Buom Jock', 'LB', 'Mankato', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5092271, 0.0, 1, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5092976, 'Todd Pelino', 'PK', 'Cornelius', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5092976, 19, 14, 49, 97);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5092977, 'George Wright', 'S', 'Dallas', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5092977, 2, 4, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5092978, 'Dawson Andrew', 'LB', 'Flowery Branch', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5092978, 0.0, 2, 3, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5099305, 'Antonio Meeks', 'WR', 'Lilburn', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5099305, 189, 17, 1, 23);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5101129, 'Darius Jones', 'LB', 'Woodruff', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5101129, 0.0, 1, 4, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5102556, 'Cataurus Hicks', 'WR', 'Miami', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5102556, 422, 24, 4, 84);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5103639, 'Trelain Maddox', 'RB', 'Stone Mountain', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5103639, 38, 11, 1, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5105335, 'Aiden Hall', 'LB', 'San Bernardino', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5105335, 0.0, 26, 73, 8.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5106061, 'Landon Danley', 'LB', 'Irmo', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5106061, 0.0, 23, 48, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5107875, 'Cole Tabb', 'RB', 'Fort Walton Beach', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5107875, 445, 114, 3, 28);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5112674, 'Bryant Wesco Jr.', 'WR', 'Midlothian', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5112674, 537, 31, 6, 73);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5113180, 'Caleb Hardy', 'S', 'Mcdonough', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5113180, 5, 17, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5114313, 'Jordan Onovughe', 'WR', 'Pomona', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5114313, 17, 2, 0, 12);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5114331, 'Suderian Harrison', 'WR', 'McCormick', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5114331, 62, 2, 0, 56);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5119662, 'Nolan Hauser', 'PK', 'Cornelius', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5119662, 21, 17, 50, 89);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5120971, 'Aziah Johnson', 'WR', 'Richmond', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5120971, 6, 1, 0, 6);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5121169, 'Darian Mensah', 'QB', 'San Luis Obispo', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5121169, 0.668, 3973, 34, 6);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5121471, 'Tyshawn Russell', 'WR', 'Harrisburg', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5121471, 84, 8, 0, 28);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5121750, 'Yamir Knight', 'WR', 'Smyrna', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5121750, 637, 54, 5, 61);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5122404, 'Abe Ibrahim', 'LB', 'Bridgeville', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5122404, 0.0, 10, 16, 1.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5123219, 'Jake Weinberg', 'PK', 'Boynton Beach', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5123219, 19, 12, 46, 82);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5124975, 'Juelz Goff', 'RB', 'York', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5124975, 270, 69, 5, 17);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5125076, 'Evan Bennett', 'LB', 'Eatonton', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5125076, 0.0, 1, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5125153, 'Che Ojarikre', 'S', 'Alpharetta', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5125153, 15, 30, 2, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5125580, 'Chad Alexander', 'RB', 'Lawrenceville', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5125580, 3, 2, 0, 2);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5125593, 'Bailey Stockton', 'WR', 'Bogart', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5125593, 233, 21, 0, 33);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5125819, 'Darrell Gill Jr.', 'WR', 'Atascocita', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5125819, 506, 32, 5, 43);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5126464, 'Deuce Adams', 'QB', 'Austin', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5126464, 0.714, 112, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5126471, 'Daniel Kaelin', 'QB', 'Elkhorn', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5126471, 0.577, 339, 1, 1);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5126513, 'Jayden Scott', 'RB', 'New Orleans', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5126513, 595, 106, 4, 69);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5126850, 'Whittman Whaley', 'LB', 'Sevierville', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5126850, 0.0, 1, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5127045, 'Drew Woodaz', 'LB', 'Wesley Chapel', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5127045, 0.0, 0, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5127807, 'Jaylen''Dai Sumlin', 'S', 'Castaic', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5127807, 2, 2, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5132253, 'Isiah Canion', 'WR', 'Warner Robins', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5132253, 467, 32, 4, 42);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5132631, 'Cam Pruitt', 'LB', 'Theodore', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5132631, 0.5, 5, 10, 0.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5132812, 'Aaron Philo', 'QB', 'Bogart', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5132812, 0.75, 373, 1, 1);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5136049, 'Duke Watson', 'RB', 'Forsyth', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5136049, 158, 49, 1, 15);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5138131, 'Deshawn Purdie', 'QB', 'Baltimore', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5138131, 0.5, 618, 6, 3);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5139079, 'Daniel Anderson', 'LB', 'Alexander', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5139079, 0.0, 0, 3, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5139080, 'Ethan Minter', 'S', 'Chester', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5139080, 23, 47, 3, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5139216, 'Luke Ferrelli', 'LB', 'Carlsbad', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5139216, 1.0, 38, 91, 5.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5139664, 'Jayden Parrish', 'LB', 'Delray Beach', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5139664, 0.0, 0, 3, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141351, 'Josiah Abdullah', 'WR', 'Columbus', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5141351, 9, 2, 0, 11);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141362, 'Jordan Allen', 'WR', 'Clarksdale', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5141362, 304, 22, 0, 78);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141412, 'Brett Clatterbaugh', 'LB', 'Culpeper', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5141412, 0.0, 2, 2, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141422, 'Gideon Davidson', 'RB', 'Lynchburg', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5141422, 260, 60, 0, 28);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141487, 'Ty Hawkins', 'QB', 'San Antonio', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5141487, 1.0, 9, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141551, 'Gabe Kaminski', 'LB', 'Riverside', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5141551, 0.0, 1, 7, 0.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141560, 'Ousmane Kromah', 'RB', 'Leesburg', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5141560, 408, 72, 0, 23);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141569, 'Ezekiel Marcelin Jr.', 'LB', 'Miami', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5141569, 0.0, 0, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141593, 'Joshua Moore', 'WR', 'Miami', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5141593, 210, 17, 2, 39);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141601, 'Shamarius Peterkin', 'WR', 'Winston-Salem', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5141601, 62, 2, 1, 57);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141605, 'Luke Nickel', 'QB', 'Alpharetta', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5141605, 0.0, 0, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141619, 'Sael Reyes', 'S', 'East Saint Louis', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5141619, 1, 2, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141634, 'Steele Pizzella', 'QB', 'Simi Valley', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5141634, 0.0, 0, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141639, 'Tyren Polley', 'S', '', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5141639, 16, 20, 2, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141640, 'Cam Sapp', 'WR', 'Miami', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5141640, 7, 1, 0, 7);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141653, 'Daylon Singleton', 'WR', 'Desoto', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5141653, -1, 1, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141657, 'Isaiah Robinson', 'WR', 'Chester', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5141657, 28, 3, 0, 15);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141661, 'Kevin Sperry', 'QB', 'Denton', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5141661, 0.706, 194, 2, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5141677, 'Ja''Kyrian Turner', 'RB', 'Wildwood', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5141677, 747, 140, 7, 56);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5142227, 'Brandon Booker', 'LB', 'Desoto', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5142227, 0.5, 26, 69, 3.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5142238, 'Tyler Mason', 'RB', 'Mount Airy', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5142238, 20, 3, 0, 13);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5142321, 'Chris Wheatley-Humphrey', 'RB', 'Dania Beach', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5142321, 108, 22, 0, 19);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5142603, 'Mark Iheanachor', 'LB', 'Los Angeles', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5142603, 1.0, 4, 4, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5142694, 'Tah''j Butler', 'LB', 'New Orleans', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5142694, 0.0, 18, 34, 3.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5143191, 'Micah Ford', 'RB', 'Toms River', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5143191, 643, 145, 4, 75);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5143595, 'Shaun Boykins', 'WR', 'Radcliff', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5143595, 5, 1, 0, 5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5144083, 'Davin Brewton', 'LB', 'Neptune', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5144083, 0.0, 3, 5, 0.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5144685, 'Ma''Khi Jones', 'S', 'Newark', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5144685, 14, 34, 1, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5145453, 'Jeremiah Melvin', 'WR', 'Fayetteville', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5145453, 39, 3, 1, 27);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5145593, 'Trent Carter', 'LB', 'Jacksonville', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5145593, 1.0, 1, 2, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5145789, 'Cole Geer', 'QB', 'Griswold', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5145789, 1.0, 8, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5146425, 'Quentin Reddish', 'S', 'Charlotte', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5146425, 9, 15, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5146575, 'Graham Knowles', 'QB', 'Southlake', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5146575, 1.0, 84, 1, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5146681, 'Eze Osondu', 'LB', 'Trophy Club', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5146681, 0.0, 1, 6, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5146724, 'Turbo Richard', 'RB', 'Hickory', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5146724, 749, 145, 9, 71);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5146747, 'Javarius Green', 'WR', 'Shelby', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5146747, 150, 13, 0, 39);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5146821, 'Kemori Dixon', 'LB', 'Danville', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5146821, 1.0, 3, 4, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5147109, 'Darrius Davis', 'S', 'Metairie', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5147109, 18, 26, 2, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5147145, 'Khmori House', 'LB', 'Pasadena', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5147145, 1.0, 42, 73, 2.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5147183, 'Sam Mattingly', 'LB', 'Magnolia', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5147183, 0.0, 16, 23, 1.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5147203, 'Chase Tyler', 'WR', 'Powder Springs', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5147203, 120, 4, 0, 62);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5147376, 'Kameron Courtney', 'WR', 'Manassas', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5147376, 234, 25, 0, 34);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5147735, 'Zane Williams', 'LB', 'Plano', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5147735, 0.0, 5, 13, 2.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5148414, 'Frank Cusano', 'LB', 'Granite Bay', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5148414, 0.5, 18, 45, 1.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5148611, 'Will Wilson', 'QB', 'Columbia', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5148611, 0.6, 16, 0, 1);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5148822, 'Chris Barnes', 'WR', 'Houston', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5148822, 547, 39, 3, 70);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5149828, 'Jonathan Agumadu', 'LB', 'Dallas', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5149828, 0.0, 7, 10, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5150563, 'Tristan Martinez', 'WR', 'Honolulu', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5150563, 2, 1, 0, 2);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5150835, 'Michael Grant', 'QB', 'Hackensack', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5150835, 1.0, 14, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5150840, 'Ashton Bracewell', 'LB', 'Palm Coast', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5150840, 0.0, 2, 2, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5150861, 'Jayden Dixon-Veal', 'WR', 'Rancho Cucamonga', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5150861, 47, 4, 1, 24);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5150880, 'George Ballance', 'LB', 'Virginia Beach', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5150880, 0.0, 6, 10, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5151024, 'Jaedon King', 'WR', 'Columbus', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5151024, -3, 1, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5151811, 'Coleson Fields', 'RB', 'Wake Forest', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5151811, 19, 11, 0, 7);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5152839, 'Jaylen King', 'QB', 'Folkston', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5152839, 0.0, 0, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5153074, 'Carlos Hernandez', 'WR', 'Alhambra', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5153074, 611, 40, 3, 93);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5153257, 'Maddox Marcellus', 'LB', 'Miami', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5153257, 1.5, 17, 49, 2.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5153665, 'Cian Slone', 'LB', 'Rocklin', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5153665, 1.5, 24, 62, 7.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5153762, 'Cayman Spaulding', 'LB', 'Lithonia', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5153762, 2.5, 24, 41, 3.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5154303, 'Zion Fowler-El', 'WR', 'Jersey City', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5154303, 60, 7, 1, 18);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5154304, 'Caleb Williams', 'RB', 'Canton', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5154304, 10, 7, 0, 4);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5154317, 'Samuel Carpenter', 'PK', 'Foxboro', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5154317, 3, 1, 24, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5154413, 'Isaiah Spencer', 'WR', 'Flora', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5154413, 194, 14, 0, 38);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5155011, 'Jaylen Moses', 'S', 'Carrollton', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5155011, 10, 13, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5155073, 'David Omopariola', 'LB', 'Baltimore', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5155073, 0.0, 24, 34, 8.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5155179, 'Jacob De Jesus', 'WR', 'Manteca', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5155179, 1022, 107, 6, 41);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5155366, 'Malachi Hosley', 'RB', 'Columbus', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5155366, 697, 98, 7, 55);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5155981, 'AJ Richardson', 'LB', 'Indianapolis', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5155981, 0.0, 6, 12, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5156056, 'Caleb Hampton', 'RB', 'Ooltewah', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5156056, 29, 11, 0, 8);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5156057, 'Myles Libman', 'WR', 'Las Vegas', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5156057, 84, 7, 1, 20);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5156116, 'Juju Preston', 'WR', 'Alexandria', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5156116, 4, 1, 0, 4);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5156440, 'Jamarice Wilder', 'RB', 'Sarasota', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5156440, 15, 4, 0, 7);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5156998, 'CharMar Brown', 'RB', 'Omaha', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5156998, 460, 122, 7, 13);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5159175, 'Malachi Toney', 'WR', 'Miami', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5159175, 1211, 109, 10, 61);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5159453, 'Darius Johnson', 'RB', 'Carol City', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5159453, 10, 3, 0, 7);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5159876, 'Myles Forristall', 'LB', 'Cartersville', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5159876, 0.0, 1, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5159884, 'Chuma Okoye', 'LB', 'Dacula', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5159884, 0.0, 0, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5159944, 'Kris Hughes', 'WR', 'Morganfield', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5159944, 109, 8, 1, 33);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5159945, 'Jaxon Panariello', 'LB', 'Louisville', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5159945, 0.0, 1, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5159948, 'Chris Johnson Jr.', 'RB', 'Fort Lauderdale', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5159948, 479, 67, 4, 87);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5160640, 'Anthony Ferrucci', 'RB', 'Fishers', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5160640, 14, 4, 0, 5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5161137, 'Dean-Taylor Chapman', 'RB', 'San Leandro', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5161137, 5, 1, 0, 5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5161140, 'Ryan McCulloch', 'LB', 'Duarte', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5161140, 1.5, 6, 11, 2.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5161638, 'Tyler Chandler', 'RB', 'Plantation', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5161638, 5, 1, 0, 5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5161644, 'Brody Jones', 'LB', 'Bristol', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5161644, 0.0, 1, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5161835, 'Jaylen McGill', 'RB', 'Spartanburg', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5161835, 19, 7, 0, 7);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5164313, 'Jaron-Keawe Sagapolutele', 'QB', 'Ewa Beach', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5164313, 0.642, 3446, 18, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5164317, 'Shaker Reisig', 'QB', 'Tulsa', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5164317, 0.526, 141, 1, 2);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5164327, 'Anthony League', 'RB', 'Long Beach', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5164327, 38, 11, 1, 8);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5164331, 'Girard Pringle Jr.', 'RB', 'Tampa', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5164331, 375, 62, 4, 38);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5164332, 'Nate Sheppard', 'RB', 'Mandeville', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5164332, 1132, 200, 11, 60);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5164350, 'Jayvan Boggs', 'WR', 'Cocoa', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5164350, 103, 9, 1, 31);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5164352, 'Carterrious Brown', 'WR', 'Monroe', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5164352, 25, 3, 0, 12);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5164365, 'Daylyn Upshaw', 'WR', 'Columbus', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5164365, 105, 7, 0, 41);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5165113, 'Zach Johnson', 'LB', 'Ocala', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5165113, 2.0, 17, 28, 3.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5165117, 'Mark Hamper', 'WR', 'West Linn', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5165117, 202, 17, 0, 35);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5165482, 'Luca Lombardo', 'PK', 'null', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5165482, 17, 16, 52, 83);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5170143, 'Will Rocha', 'PK', 'Mandeville', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5170143, 0, 0, 0, 1);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5173414, 'Antoine Deslauriers', 'LB', 'Montreal', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5173414, 1.0, 28, 48, 3.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5176070, 'Myles Brown', 'LB', 'Columbia', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5176070, 0.0, 1, 8, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5178083, 'Noah Chambers', 'LB', 'Prince George County', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5178083, 1.0, 17, 43, 2.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5181309, 'Gregory Smith', 'LB', 'Riverview', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5181309, 0.0, 14, 20, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5186586, 'Ty Clark III', 'RB', 'Nashville', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5186586, 323, 75, 3, 15);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5188318, 'Kevin Chadwick Jr.', 'S', 'Vienna', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5188318, 1, 1, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5192420, 'Cooper Ranvier', 'PK', 'Lexington', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5192420, 25, 21, 51, 102);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5193390, 'C.J. Kubah-Taylor', 'LB', 'Frederick', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5193390, 0.0, 0, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5195479, 'Corey Costner', 'S', 'Baltimore', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5195479, 13, 27, 3, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5197158, 'Malachi James', 'RB', 'Burlington', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5197158, -2, 2, 0, 3);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5197251, 'Will Felder Jr.', 'LB', 'Willingboro', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5197251, 0.0, 2, 3, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5199946, 'Gabe Daniels', 'WR', 'Atlanta', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5199946, 29, 2, 1, 17);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5203590, 'Madrid Tucker', 'WR', 'Lehigh Acres', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5203590, 45, 9, 0, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5204646, 'Griffin Collins', 'LB', 'Longmeadow', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5204646, 0.0, 8, 15, 0.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5206061, 'Darien Williams', 'WR', 'Syracuse', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5206061, 112, 9, 1, 35);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5207842, 'Jalen Cooper', 'WR', 'Cibolo', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5207842, 321, 19, 2, 75);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5207855, 'Kevon Carter', 'LB', 'San Antonio', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5207855, 0.0, 4, 7, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5207927, 'Dramekco Green', 'RB', 'Conroe', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5207927, 90, 25, 1, 15);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5208095, 'Mason Heintschel', 'QB', 'Oregon', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5208095, 0.636, 2357, 16, 8);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5208138, 'Luke Carney', 'QB', 'Mesquite', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5208138, 0.714, 22, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5208592, 'Bo MacCormack III', 'RB', 'Westford', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5208592, 43, 15, 1, 14);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5209161, 'Malachi Coleman', 'RB', 'Roanoke', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5209161, 31, 9, 0, 8);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5209263, 'Asher Wasserman', 'LB', 'Hamden', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5209263, 0.0, 1, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5209709, 'Teriq Mallory', 'WR', 'New Haven', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5209709, 14, 1, 0, 14);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5209762, 'Shane Marshall', 'RB', 'Ocilla', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5209762, 10, 2, 0, 8);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5210003, 'Chris Denson', 'QB', 'Plant City', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5210003, 1.0, 22, 1, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5210164, 'Bryce Yates', 'WR', 'Ettrick', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5210164, 202, 11, 1, 68);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5210729, 'Xay Davis', 'RB', 'Richmond', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5210729, 86, 23, 0, 8);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5211163, 'Mekhi Dodd', 'RB', 'Mattapan', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5211163, 12, 7, 0, 4);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5211398, 'Tristan Teasdell', 'S', 'Leesburg', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5211398, 9, 23, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5211422, 'Donte Utu', 'S', 'Manoa', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5211422, 1, 1, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5212231, 'Dillon Newton-Short', 'WR', 'Matoaca', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5212231, 39, 3, 0, 16);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5212611, 'Tony Kinsler', 'WR', 'Daytona Beach', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5212611, 4, 1, 0, 4);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5212990, 'Darius Johnson', 'WR', 'Carol City', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5212990, 48, 6, 0, 25);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5213239, 'Au''Tori Newkirk', 'QB', 'Norfolk', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5213239, 0.5, 23, 1, 1);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5213303, 'Sheldon Robinson', 'S', 'Woodberry Forest', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5213303, 11, 21, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5213306, 'Emmanuel Taylor', 'LB', 'Virginia Beach', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5213306, 0.0, 2, 5, 0.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5213307, 'Justin Thompson', 'LB', 'Bowie', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5213307, 0.0, 0, 0, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5214409, 'Jeffrey Overton Jr.', 'RB', 'Woodbridge', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5214409, 146, 25, 1, 38);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5214566, 'Dawson Pough', 'WR', 'Leesburg', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5214566, 197, 13, 1, 52);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5214935, 'Elliott Schaper', 'LB', 'Austin', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5214935, 2.0, 5, 16, 2.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5215011, 'J.P. Powell', 'RB', 'Colquitt', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5215011, 72, 5, 1, 61);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5215542, 'Bradley Gompers', 'LB', 'Pittsburgh', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5215542, 0.0, 8, 14, 1.5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5215547, 'Jakarrion Kenan', 'S', 'Bennettsville', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5215547, 1, 2, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5215579, 'Zacari Thomas', 'LB', 'Haddock', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5215579, 0.0, 5, 6, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5216505, 'Jamar Searcy', 'RB', 'Pittsburg', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5216505, 39, 5, 0, 21);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5217872, 'Cameron White', 'LB', 'Tampa', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5217872, 0.0, 1, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218242, 'Zay Parks', 'RB', 'Crestview', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5218242, 95, 15, 1, 22);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218243, 'Jeremiah Johnson', 'RB', 'Tallahassee', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5218243, 54, 10, 0, 16);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218244, 'Gav Holman', 'LB', 'Uniondale', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5218244, 0.0, 0, 3, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218248, 'Timir Hickman-Collins', 'LB', 'Fort Mill', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5218248, 0.0, 5, 9, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218249, 'Willy Suarez', 'WR', 'Tampa', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5218249, 5, 1, 0, 5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218741, 'Jayden Parker', 'RB', 'Oakland', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5218741, 3, 1, 0, 3);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218742, 'Isaac Torres', 'WR', 'Santa Rosa', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5218742, 9, 1, 0, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218746, 'Aaron Hampton', 'LB', 'Anchorage', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5218746, 1.0, 21, 41, 1.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218753, 'T.J. Moore', 'WR', 'Key West', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5218753, 837, 52, 4, 75);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218756, 'Clark Sanderson', 'WR', 'Birmingham', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5218756, 40, 2, 0, 31);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218757, 'Chase Byrd', 'WR', 'Greenville', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5218757, 17, 2, 0, 9);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218761, 'Joseph Roberto II', 'LB', 'Helena', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5218761, 0.0, 0, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218787, 'Que''Sean Brown', 'WR', 'Winston-Salem', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5218787, 842, 63, 5, 69);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218791, 'Cosme Salas', 'PK', 'Miami', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5218791, 0, 0, 0, 1);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5218933, 'Tripp Woody', 'PK', 'Waxhaw', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5218933, 14, 12, 49, 58);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5219169, 'Charleston French', 'RB', 'Amory', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5219169, 3, 1, 0, 3);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5219225, 'Zach Hernandez', 'RB', 'Dallas', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5219225, 9, 2, 0, 5);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5219230, 'Xavier Wright', 'LB', 'Garland', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5219230, 0.0, 2, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5219233, 'Sam Keltner', 'PK', 'Keller', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5219233, 20, 14, 51, 78);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5219242, 'Marcus Brown', 'WR', 'Richton Park', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5219242, 86, 12, 1, 21);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5219244, 'Charlie Eckhardt', 'S', 'Centennial', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5219244, 22, 34, 3, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5219251, 'AJ Seidler', 'PK', 'Appleton', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5219251, 0, 0, 0, 1);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5219291, 'Keke Adams', 'S', 'Hartford', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5219291, 1, 1, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5220007, 'Tank Boston', 'WR', 'Anderson', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5220007, 11, 2, 0, 6);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5220012, 'Logan Foust', 'LB', 'Graham', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5220012, 0.0, 0, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5220013, 'Nick Koniecznski', 'PK', 'Matthews', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5220013, 3, 1, 29, 6);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5225740, 'Tristan Smith', 'WR', 'LaGrange', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5225740, 239, 24, 1, 23);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5228152, 'Connor Calvert', 'PK', 'Bend', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5228152, 22, 18, 50, 86);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5228607, 'Demon June', 'RB', 'Jacksonville', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5228607, 464, 84, 2, 50);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5231354, 'Caden High', 'WR', 'Atlanta', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5231354, 414, 37, 1, 34);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5236220, 'Kellen Wiley Jr.', 'LB', 'Tampa', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5236220, 0.0, 3, 6, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5239156, 'Jack Foley', 'WR', 'Bend', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5239156, 64, 1, 1, 64);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5239158, 'Brennan Johnson', 'S', 'Richmond', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5239158, 4, 17, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5257397, 'Andrew Pellicciotta', 'S', 'Malvern', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5257397, 14, 26, 2, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5260847, 'Marcellous Hawkins', 'RB', 'Oklahoma City', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5260847, 749, 118, 1, 40);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5261613, 'Tylik Hill', 'RB', 'Asbury Park', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5261613, 129, 24, 0, 15);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5263574, 'LaCorian Hodge', 'LB', 'Arlington', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5263574, 0.0, 2, 5, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5265128, 'Shanard Clower', 'WR', 'Lakeland', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5265128, 98, 12, 0, 31);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5294114, 'Owen Gardner', 'RB', 'Cassopolis', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5294114, 4, 2, 0, 3);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5294115, 'Montino Williams', 'S', 'Chesterfield', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5294115, 2, 7, 1, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5294561, 'Austin Alexander', 'LB', 'Burlington', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5294561, 0.0, 1, 3, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5295336, 'Link Rhodes', 'WR', 'Las Vegas', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5295336, 30, 3, 0, 12);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5295338, 'Ka''Davion Dotson-Walker', 'S', 'Duncanville', 0, 0);
INSERT INTO Safety (playerID, solo_tackles, total_tackles, passes_defended, interceptions) VALUES (5295338, 2, 3, 0, 0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5295339, 'Kyle Ferm', 'LB', 'Glendora', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5295339, 0.0, 1, 1, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5296066, 'Ethan Dowdy', 'WR', 'Powhatan', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5296066, 25, 3, 0, 11);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5296067, 'Teddy Hoffmann', 'WR', 'Delray Beach', 0, 0);
INSERT INTO Wide_Receiver (playerID, yards, receptions, touchdowns, longest) VALUES (5296067, 349, 25, 3, 55);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5296107, 'Odera Okaka', 'LB', 'Antioch', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5296107, 0.0, 2, 6, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5296136, 'Braxton Jennings', 'RB', 'Ashland', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5296136, 200, 37, 1, 22);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5296232, 'Justin Cook', 'RB', 'Tampa', 0, 0);
INSERT INTO Running_Back (playerID, yards, carries, touchdowns, longest) VALUES (5296232, 31, 9, 0, 13);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5296243, 'Trey Butkowski', 'PK', 'Orlando', 0, 0);
INSERT INTO Kicker (playerID, fg_attempted, fg_made, longest, points) VALUES (5296243, 23, 20, 47, 103);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5296818, 'Will Straka', 'LB', 'Mineral Point', 0, 0);
INSERT INTO Linebacker (playerID, sacks, solo_tackles, total_tackles, tackles_for_loss) VALUES (5296818, 0.0, 1, 2, 0.0);

INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (5297026, 'Joseph Filardi', 'QB', 'Dix Hills', 0, 0);
INSERT INTO Quarterback (playerID, percentage, yards, touchdowns, interceptions) VALUES (5297026, 0.477, 226, 1, 3);