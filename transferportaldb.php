<?php 
require("connect-db.php");
function getPlayerByID($id){
global $db;

$query = "SELECT * FROM Player WHERE playerID = :id";
$stmt = $db->prepare($query);
$stmt->bindParam(':id', $id);
$stmt->execute();
$res = $stmt->fetch(PDO::FETCH_ASSOC);
$stmt->closeCursor();
return $res;

}

function getTeamByID($id){
global $db;
$query = "SELECT * FROM Team WHERE teamID = :id";
$stmt = $db->prepare($query);
$stmt->bindParam(':id', $id);
$stmt->execute();
$res = $stmt->fetch(PDO::FETCH_ASSOC);
$stmt->closeCursor();
return $res;
}

function getUserByID($id){
global $db;
$query = "SELECT * FROM Portal_User WHERE userID = :id";
$stmt = $db->prepare($query);
$stmt->bindParam(':id', $id);
$stmt->execute();
$res = $stmt->fetch(PDO::FETCH_ASSOC);
$stmt->closeCursor();
return $res;
}

function getPlayersByMinimumValuation($min_val){
global $db;
$query = "SELECT * FROM Player WHERE valuation >= :min_val";
$stmt = $db->prepare($query);
$stmt->bindParam(':min_val', $min_val);
$stmt->execute();
$res = $stmt->fetchAll();
$stmt->closeCursor();
return $res;
}

function getPlayersByStarRating($star_rating){
global $db;
$query = "SELECT * FROM Player WHERE stars = :star_rating";
$stmt = $db->prepare($query);
$stmt->bindParam(':star_rating', $star_rating);
$stmt->execute();
$res = $stmt->fetchAll();
$stmt->closeCursor();
return $res;
}

function getCoachByID($id){
global $db;
$query = "SELECT * FROM Coach WHERE coachID = :id";
$stmt = $db->prepare($query);
$stmt->bindParam(':id', $id);
$stmt->execute();
$res = $stmt->fetch(PDO::FETCH_ASSOC);
$stmt->closeCursor();
return $res;
}

function getOffersByPlayer($player_id, $status="All"){
global $db;
if ($status == "All") {
    $query = "SELECT * FROM Offers WHERE playerID = :player_id";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':player_id', $player_id);
    $stmt->execute();
    $res = $stmt->fetchAll();
    $stmt->closeCursor();
    return $res;
}
$query = "SELECT * FROM Offers WHERE playerID = :player_id AND status = :status";
$stmt = $db->prepare($query);
$stmt->bindParam(':player_id', $player_id);
$stmt->bindParam(':status', $status);
$stmt->execute();
$res = $stmt->fetchAll();
$stmt->closeCursor();
return $res;
}

function getOffersByCoach($coach_id, $status="All"){
global $db;
$query = "SELECT * FROM Offers WHERE coachID = :coach_id AND status = :status";
$stmt = $db->prepare($query);
$stmt->bindParam(':coach_id', $coach_id);
$stmt->bindParam(':status', $status);
$stmt->execute();
$res = $stmt->fetchAll();
$stmt->closeCursor();
return $res;
}

function getStatsByPlayer($player_id){
global $db;
$query = "SELECT position FROM Player WHERE playerID = :id";
$stmt = $db->prepare($query);
$stmt->bindParam(':id', $player_id);
$stmt->execute();
$player = $stmt->fetch(PDO::FETCH_ASSOC);
$stmt->closeCursor();

if (!$player) return null;
$table = "";

switch ($player['position']) {
    case 'QB': $table = "Quarterback"; break;
    case 'RB': $table = "Running_Back"; break;
    case 'WR': $table = "Wide_Receiver"; break;
    case 'LB': $table = "Linebacker"; break;
    case 'S':  $table = "Safety"; break;
    case 'PK': $table = "Kicker"; break;
    default:   return null; 
}

$query = "SELECT * FROM Player p JOIN $table s ON p.playerID = s.playerID WHERE p.playerID = :id";
$stmt = $db->prepare($query);
$stmt->bindParam(':id', $player_id);
$stmt->execute();
$res = $stmt->fetch(PDO::FETCH_ASSOC);
$stmt->closeCursor();
return $res;
}

function getPlayersByPosition($position){
global $db;
$query = "SELECT * FROM Player WHERE position = :position";
$stmt = $db->prepare($query);
$stmt->bindParam(':position', $position);
$stmt->execute();
$res = $stmt->fetchAll();
$stmt->closeCursor();
return $res;
}

function getPlayersByTeam($team_id){
global $db;
$query = "SELECT * FROM Player WHERE teamID = :team_id";
$stmt = $db->prepare($query);
$stmt->bindParam(':team_id', $team_id);
$stmt->execute();
$res = $stmt->fetchAll();
$stmt->closeCursor();
return $res;
}


function getPlayerTeamName($player_id){
global $db;
$query = "SELECT name FROM Plays_For p JOIN Team t ON p.teamID = t.teamID WHERE p.playerID = :player_id";
$stmt = $db->prepare($query);
$stmt->bindParam(':player_id', $player_id);
$stmt->execute();
$res = $stmt->fetch(PDO::FETCH_ASSOC);
$stmt->closeCursor();
return $res;
}

function totalPlayers(){
    global $db;
    $query = "SELECT COUNT(*) as total FROM Player";
    $stmt = $db->prepare($query);
    $stmt->execute();
    $res = $stmt->fetch(PDO::FETCH_ASSOC);
    $stmt->closeCursor();
    return $res['total'];
}

function totalOffers($status='All'){
    global $db;
    if ($status == 'All') {
        $query = "SELECT COUNT(*) as total FROM Offers";
        $stmt = $db->prepare($query);
        $stmt->execute();
        $res = $stmt->fetch(PDO::FETCH_ASSOC);
        $stmt->closeCursor();
        return $res['total'];
    } else {
    $query = "SELECT COUNT(*) as total FROM Offers WHERE status = :status";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':status', $status);
    $stmt->execute();
    $res = $stmt->fetch(PDO::FETCH_ASSOC);
    $stmt->closeCursor();
    return $res['total'];
    }
}

function getTotalAverageValuation(){
    global $db;
    $query = "SELECT AVG(valuation) as average FROM Player";
    $stmt = $db->prepare($query);
    $stmt->execute();
    $res = $stmt->fetch(PDO::FETCH_ASSOC);
    $stmt->closeCursor();
    return $res['average'];
}

function createUser($username, $password){
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);
    global $db;
    $query = "INSERT INTO Portal_User (username, password) VALUES (:username, :password)";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':username', $username);
    $stmt->bindParam(':password', $hashed_password);
    $stmt->execute();
    $stmt->closeCursor();
}

function validLogin($username, $password){
global $db;
$query = "SELECT * FROM Portal_User WHERE username = :username";
$stmt = $db->prepare($query);
$stmt->bindParam(':username', $username);
$stmt->execute();
$res = $stmt->fetch(PDO::FETCH_ASSOC);
$stmt->closeCursor();
if ($res && password_verify($password, $res['password'])) {
    return true;
} else {
    return false;
}
}

function validateUsername($username){
global $db;
$query = "SELECT * FROM Portal_User WHERE username = :username";
$stmt = $db->prepare($query);
$stmt->bindParam(':username', $username);
$stmt->execute();
$res = $stmt->fetch(PDO::FETCH_ASSOC);
$stmt->closeCursor();
if ($res) {
    return false;
} else {
    return true;
}
}
function createAccount($username, $password){
global $db;
if (validateUsername($username)){
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);
    $query = "INSERT INTO Portal_User (username, password) VALUES (:username, :password)";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':username', $username);
    $stmt->bindParam(':password', $hashed_password);
$stmt->execute();
$stmt->closeCursor();
}
}

function deleteUser($username){
    global $db;
    $query = "DELETE FROM Portal_User WHERE username = :username";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':username', $username);
    $stmt->execute();
    $stmt->closeCursor();
}

function getUserID($username){
    global $db;
    $query = "SELECT userID FROM Portal_User WHERE username = :username";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':username', $username);
    $stmt->execute();
    $res = $stmt->fetch(PDO::FETCH_ASSOC);
    $stmt->closeCursor();
    return $res['userID'];
}

function getUserPlayers($userID){
    global $db;
    $query = "SELECT * FROM Player JOIN Plays_As ON Player.playerID = Plays_As.playerID WHERE Plays_As.userID = :userID";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':userID', $userID);
    $stmt->execute();
    $res = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $stmt->closeCursor();
    return $res[0];
}
function createOffer($coachID, $playerID, $offer_amount){
    global $db;
    $query = "INSERT INTO Offers (coachID, playerID, amount, status) VALUES (:coachID, :playerID, :offer_amount, 'Pending')";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':coachID', $coachID);
    $stmt->bindParam(':playerID', $playerID);
    $stmt->bindParam(':amount', $offer_amount);
    $stmt->execute();
    $stmt->closeCursor();
}

function getAllPlayers(){
    global $db;
    $query = "SELECT * FROM Player";
    $stmt = $db->prepare($query);
    $stmt->execute();
    $res = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $stmt->closeCursor();
    return $res;
}


function getOfferTeamByCoach($coachID){
    global $db;
    $query = "SELECT t.teamID FROM Team t JOIN Coach c ON t.teamID = c.teamID WHERE c.coachID = :coachID";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':coachID', $coachID);
    $stmt->execute();
    $res = $stmt->fetch(PDO::FETCH_ASSOC);
    $stmt->closeCursor();
    return $res;
}

function createNewPlayer($playerName, $position, $hometown, $userID, $stats_array){
    global $db;

    $playerID = "999" . $userID;

    if ($position == 'QB') {
        $query = "INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (:playerID, :name, :position, :hometown, 100, 1)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':name', $playerName);
        $stmt->bindParam(':position', $position);
        $stmt->bindParam(':hometown', $hometown);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Quarterback (playerID, yards, percentage,touchdowns,interceptions) VALUES (:playerID, :yards, :percentage, :touchdowns, :interceptions)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':yards', $stats_array['yards']);
        $stmt->bindParam(':percentage', $stats_array['passing_percentage']);
        $stmt->bindParam(':touchdowns', $stats_array['touchdowns']);
        $stmt->bindParam(':interceptions', $stats_array['interceptions']);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Plays_As (playerID, userID) VALUES (:playerID, :userID)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':userID', $userID);
        $stmt->execute();
        $stmt->closeCursor();

    }
    elseif ($position == 'RB') {
        $query = "INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (:playerID, :name, :position, :hometown, 100, 1)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':name', $playerName);
        $stmt->bindParam(':position', $position);
        $stmt->bindParam(':hometown', $hometown);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Running_Back (playerID, longest, touchdowns, carries, yards) VALUES (:playerID, :longest, :touchdowns, :carries, :yards)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':longest', $stats_array['longest']);
        $stmt->bindParam(':touchdowns', $stats_array['touchdowns']);
        $stmt->bindParam(':carries', $stats_array['carries']);
        $stmt->bindParam(':yards', $stats_array['yards']);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Plays_As (playerID, userID) VALUES (:playerID, :userID)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':userID', $userID);
        $stmt->execute();
        $stmt->closeCursor();
    }

    elseif ($position == 'WR') {
        $query = "INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (:playerID, :name, :position, :hometown, 100, 1)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':name', $playerName);
        $stmt->bindParam(':position', $position);
        $stmt->bindParam(':hometown', $hometown);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Wide_Receiver (playerID, receptions, yards, touchdowns, longest) VALUES (:playerID, :receptions, :yards, :touchdowns, :longest)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':receptions', $stats_array['receptions']);
        $stmt->bindParam(':yards', $stats_array['yards']);
        $stmt->bindParam(':touchdowns', $stats_array['touchdowns']);
        $stmt->bindParam(':longest', $stats_array['longest']);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Plays_As (playerID, userID) VALUES (:playerID, :userID)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':userID', $userID);
        $stmt->execute();
        $stmt->closeCursor();
    }

    elseif ($position == 'LB') {
        $query = "INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (:playerID, :name, :position, :hometown, 100, 1)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':name', $playerName);
        $stmt->bindParam(':position', $position);
        $stmt->bindParam(':hometown', $hometown);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Linebacker (playerID, sacks, tackles_for_loss, total_tackles, solo_tackles) VALUES (:playerID, :sacks, :tackles_for_loss, :total_tackles, :solo_tackles)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':sacks', $stats_array['sacks']);
        $stmt->bindParam(':tackles_for_loss', $stats_array['tackles_for_loss']);
        $stmt->bindParam(':total_tackles', $stats_array['total_tackles']);
        $stmt->bindParam(':solo_tackles', $stats_array['solo_tackles']);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Plays_As (playerID, userID) VALUES (:playerID, :userID)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':userID', $userID);
        $stmt->execute();
        $stmt->closeCursor();
    }

    elseif ($position == 'S') {
        $query = "INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (:playerID, :name, :position, :hometown, 100, 1)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':name', $playerName);
        $stmt->bindParam(':position', $position);
        $stmt->bindParam(':hometown', $hometown);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Safety (playerID, solo_tackles, total_tackles, interceptions, passes_defended) VALUES (:playerID, :solo_tackles, :total_tackles, :interceptions, :passes_defended)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':solo_tackles', $stats_array['solo_tackles']);
        $stmt->bindParam(':total_tackles', $stats_array['total_tackles']);
        $stmt->bindParam(':interceptions', $stats_array['interceptions']);
        $stmt->bindParam(':passes_defended', $stats_array['passes_defended']);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Plays_As (playerID, userID) VALUES (:playerID, :userID)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':userID', $userID);
        $stmt->execute();
        $stmt->closeCursor();
    }

    elseif ($position == 'K'){
        $query = "INSERT INTO Player (playerID, name, position, hometown, valuation, stars) VALUES (:playerID, :name, :position, :hometown, 100, 1)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':name', $playerName);
        $stmt->bindParam(':position', $position);
        $stmt->bindParam(':hometown', $hometown);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Kicker (playerID, longest, fg_attempted, fg_made, points) VALUES (:playerID, :longest, :fg_attempted, :fg_made, :points)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':longest', $stats_array['longest']);
        $stmt->bindParam(':fg_attempted', $stats_array['fg_attempted']);
        $stmt->bindParam(':fg_made', $stats_array['fg_made']);
        $stmt->bindParam(':points', $stats_array['points']);
        $stmt->execute();
        $stmt->closeCursor();

        $query = "INSERT INTO Plays_As (playerID, userID) VALUES (:playerID, :userID)";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':playerID', $playerID);
        $stmt->bindParam(':userID', $userID);
        $stmt->execute();
        $stmt->closeCursor();
    }
}

function hasPlayer($userID){
    global $db;
    $query = "SELECT * FROM Plays_As WHERE userID = :userID";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':userID', $userID);
    $stmt->execute();
    $res = $stmt->fetch(PDO::FETCH_ASSOC);
    $stmt->closeCursor();
    if ($res) {
        return true;
    } else {
        return false;
    }
}

?>