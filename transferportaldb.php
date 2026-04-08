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
$query = "SELECT * FROM Offers WHERE playerID = :player_id";
$stmt = $db->prepare($query);
$stmt->bindParam(':player_id', $player_id);
$stmt->execute();
$res = $stmt->fetchAll();
$stmt->closeCursor();
return $res;
}

function getOffersByCoach($coach_id, $status="All"){
global $db;
$query = "SELECT * FROM Offers WHERE coachID = :coach_id";
$stmt = $db->prepare($query);
$stmt->bindParam(':coach_id', $coach_id);
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

?>